class Feedback < ActiveRecord::Base
  paginates_per 50

  validates_presence_of :name, :content, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
