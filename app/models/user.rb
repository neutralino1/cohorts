class User < ActiveRecord::Base

  ## ASSOCIATIONS
  has_many :orders

  ## SCOPES
  scope :signed_up_since, -> (date) { where("created_at > ?", date) }
end