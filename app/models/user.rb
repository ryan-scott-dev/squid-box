class User < ActiveRecord::Base
  acts_as_authentic

  attr_accessible :email, :password, :username

end
