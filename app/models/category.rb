class Category < ActiveRecord::Base
  attr_accessible :title, :alias

  validates :title, :alias, presence: true

  has_many :posts
end
