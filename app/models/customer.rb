class Customer < ApplicationRecord
  has_many :contracts, dependent: :destroy
end
