class Post < ActiveRecord::Base
  attr_accessible :article, :title, :need_symbols, :category_id
  
  validates :article, :title, presence: true
  validates :need_symbols, :category_id, numericality: { only_integer: true } 
  
  has_many    :comments
  belongs_to  :category
end
