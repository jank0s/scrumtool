# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(name: "User")
Role.create(name: "Admin")
User.create(username: "admin", password: "admin", password_confirmation: "admin", name: "Administrator", surname: "Default", email: "admin@tpo11.tk", role_id:"2")
User.create(username: "user", password: "user", password_confirmation: "user", name: "User", surname: "Default", email: "user@tpo11.tk", role_id:"1")
Priority.create(name: "Must have")
Priority.create(name: "Could have")
Priority.create(name: "Should have")
Priority.create(name: "Won't have this time")
Project.create(name: "Scrumer", description: "Something", scrummaster_id: 1, user_ids: [1,2])
Sprint.create(start: "2014-04-20", end: "2014-05-30", velocity: 3, project_id: 1)
Story.create(project_id: 1, name: "Story1", description: "Story one", priority_id: 1, sprint_id: 1, finished: false, test: "", timeestimates: 2)
Story.create(project_id: 1, name: "Story2", description: "Story two", priority_id: 1, sprint_id: 1, finished: false, test: "", timeestimates: 1)
Story.create(project_id: 1, name: "Story3", description: "Story three", priority_id: 1, finished: false, test: "", timeestimates: 3)

Task.create(name: "Task1", story_id: "1", completed: false, time_estimation: 6, assigned_date: "2014-04-20 00:00:00")
Task.create(name: "Task2", story_id: "1", completed: false, time_estimation: 2, assigned_date: "2014-04-20 00:00:00")
Task.create(name: "Task3", story_id: "1", completed: false, time_estimation: 4, assigned_date: "2014-04-20 00:00:00")