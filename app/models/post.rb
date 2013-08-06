class Post < ActiveRecord::Base
  attr_accessible :article, :title, :need_symbols, :category_id

  has_many    :comments
  belongs_to  :category
end
