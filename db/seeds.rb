# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.all.blank?
  user = User.new
  user.email = "ryan.scott@lambdasoftware.com.au"
  user.password = "password"
  user.password_confirmation = "password"
  user.login = "rscott"
  user.save!
end

repo = Repository.create({name: "Test Repository",
                          path: "git://github.com/mojombo/grit.git"})