class Catagory < ApplicationRecord
  has_many :recipes, dependent: :destroy
end
