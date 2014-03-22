# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(name: "User")
Role.create(name: "Admin")
User.create(username: "admin", password: "admin", password_confirmation: "admin", name: "Administrator", surname: "", email: "admin@tpo11.tk", role_id:"2")
User.create(username: "user", password: "user", password_confirmation: "user", name: "User", surname: "", email: "user@tpo11.tk", role_id:"1")
