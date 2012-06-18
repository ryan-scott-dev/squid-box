class User < ActiveRecord::Base
  acts_as_authentic

  attr_accessible :email, :crypted_password, :username

end
