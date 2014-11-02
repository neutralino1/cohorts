class User < ActiveRecord::Base

  ## ASSOCIATIONS
  has_many :orders

end