class ProfileUser < ApplicationRecord
  belongs_to :profile
  has_one_attached :avatar
end
