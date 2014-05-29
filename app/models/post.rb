class Post < ActiveRecord::Base
  validates :title, :link, presence: true
end
