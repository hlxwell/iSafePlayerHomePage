module ApplicationHelper

  # <li>
  #   Home
  # </li>
  # <li>
  #   <a href='/'>Feedback</a>
  # </li>
  # <li class='no_right'>
  #   <a href='/'>About</a>
  # </li>
  #
  def top_menu
    output_html = ""
    [
      [t("menus.home"), root_path],
      [t("menus.feedback"), feedbacks_path],
      I18n.locale == :zh ? ["English", "?locale=en", true] : ["中文", "?locale=zh", true]
    ].each do |title, path, is_last_one|
      options = is_last_one ? {:class => 'no_right'} : {}
      content = current_page?(path) ? title : content_tag(:a, title, :href => path)
      output_html << content_tag(:li, content, options)
    end
    output_html
  end
  
  def show_notice_flash
    content_tag :div, flash[:notice], :class => "notice" if flash[:notice].present?
  end
end
