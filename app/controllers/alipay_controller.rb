class AlipayController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :notify

  def pay
    @apple_id = params[:apple_id]
    @charge_amount = params[:charge_amount]
    
    flash[:notice] = "价格必须输入为20元" if @charge_amount.blank? or @charge_amount.to_f != 20
    flash[:notice] = "必须输入正确的AppleID，否则我们将无法发送您的帐号。" if @apple_id.blank? or @apple_id !~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

    redirect_to :back if flash[:notice].present?
  end

  def notify
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)

    ### check if the notification is correct.
    notification.acknowledge

    case notification.status
    when "WAIT_BUYER_PAY", "TRADE_CLOSED"
      raise "Money didn't paid."
    when "TRADE_FINISHED", "TRADE_SUCCESS"
      Order.create!(:apple_id => notification.extra_common_param, :trade_no => notification.trade_no)
      render :text => "success"
      return
    else
      raise "Money didn't arrived."
    end
  end

  def done
    @result = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)
    if @result.success?
      logger.warn(@result.order)
      render :done
    else
      logger.warn(@result.message)
      render :error
    end
  end

  def error
  end
end