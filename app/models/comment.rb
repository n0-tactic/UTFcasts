class Comment < ActiveRecord::Base

  attr_accessible :author, :comment, :post_id

  validates :author, :comment, presence: true
  validates :post_id, numericality: { only_integer: true }

  belongs_to :post
end
