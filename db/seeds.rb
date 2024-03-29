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
User.create(username: "mojca", password: "mojca", password_confirmation: "mojca", name: "Mojca", surname: "Komavec", email: "mojca.komavec@tpo11.tk", role_id:"1")
User.create(username: "jan", password: "jan", password_confirmation: "jan", name: "Jan", surname: "Kos", email: "jan.kos@tpo11.tk", role_id:"1")
User.create(username: "edin", password: "edin", password_confirmation: "edin", name: "Edin", surname: "Mahmutovic", email: "edin.mahmutovic@tpo11.tk", role_id:"1")
User.create(username: "matic", password: "matic", password_confirmation: "matic", name: "Matic", surname: "Repse", email: "matic.repse@tpo11.tk", role_id:"1")
Priority.create(name: "Must have")
Priority.create(name: "Could have")
Priority.create(name: "Should have")
Priority.create(name: "Won't have this time")
Project.create(name: "Scrumer", description: "Something", scrummaster_id: 2, user_ids: [1,2,3,4,5,6])
Sprint.create(start: "2014-05-20", end: "2014-05-24", velocity: 3, project_id: 1)
Sprint.create(start: "2014-05-28", end: "2014-06-03", velocity: 3, project_id: 1)


#Story.create(project_id: 1, name: "Story1", description: "Story one", priority_id: 1, sprint_id: 2, finished: false, test: "", timeestimates: 2)
#Story.create(project_id: 1, name: "Story2", description: "Story two", priority_id: 1, sprint_id: 2, finished: false, test: "", timeestimates: 1)
#Story.create(project_id: 1, name: "Story3", description: "Story three", priority_id: 1, finished: false, test: "", timeestimates: 1)
#Story.create(project_id: 1, name: "Story4", description: "Story four", priority_id: 1, finished: true, test: "", timeestimates: 3, finished_in_sprint: 1)

Story.create(project_id: 1, name: "Dodajanje projekta", description: "Administrator lahko ustvari nov projekt, izbere uporabnike za delo na tem projektu in določi njihove projektne vloge (produktni vodja, skrbnik metodologije, član razvojne skupine).", priority_id: 1, sprint_id: 2, finished: false, test: "", timeestimates: 2, test: "# Preveri dodajanje novega projekta in morebitno podvajanje imen projektov.
# Preveri izbiro uporabnikov za delo na projektu.
# Preveri določitev projektnih vlog.")
Story.create(project_id: 1, name: "Ustvarjanje novega Sprinta", description: "Skrbnik metodologije lahko ustvari nov Sprint. Določi mu začetni in končni datum ter pričakovano hitrost.", priority_id: 1, sprint_id: 2, finished: false, test: "", timeestimates: 1, test: "# Preveri običajen potek: dodaj nov Sprint, določi mu začetni in končni datum (v prihodnosti) in nastavi začetno hitrost.
# Preveri za primer, ko je končni datum pred začetnim.
# Preveri za primer, ko je začetni datum v preteklosti.
# Preveri za neregularno vrednost hitrosti Sprinta.
# Preveri za primer, ko se dodani Sprint prekriva s katerim od obstoječih.")
Story.create(project_id: 1, name: "Dodajanje opomb k zgodbam", description: "Člani razvojne skupine lahko k uporabniškim zgodbam v dogovoru s produktnim vodjo ali skrbnikom metodologije dopisujejo svoje opombe.", priority_id: 1, finished: false, test: "", timeestimates: 1, test: "# Preveri regularen potek.")
Story.create(project_id: 1, name: "Ocena časovne zahtevnosti", description: "Skrbnik metodologije lahko nedodeljeni zgodbi v seznamu zahtev določi (oziroma spremeni) oceno časovne zahtevnosti.", priority_id: 1, finished: true, test: "", timeestimates: 3, finished_in_sprint: 1, test: "# Preveri regularen potek.
# Preveri veljavnost ocene časovne zahtevnosti.
# Preveri za zgodbo, ki je že dodeljena nekemu Sprintu.")


Task.create(name: "Logika", story_id: "1", completed: false, time_estimation: 6, assigned_date: "2014-05-28 00:00:00", assigned_to: 2)
Task.create(name: "Uporabniški vmesnik", story_id: "1", completed: false, time_estimation: 2, assigned_date: "2014-06-02 00:00:00")
Task.create(name: "Baza", story_id: "1", completed: false, time_estimation: 4, assigned_date: "2014-05-28 00:00:00", assigned_to: 2)
Task.create(name: "Testiranje", story_id: "1", completed: false, time_estimation: 5, assigned_date: "2014-06-02 00:00:00")

#Task.create(name: "Task1.1", story_id: "1", completed: false, time_estimation: 4, assigned_date: "2014-05-28 00:00:00")
#Task.create(name: "Task2.1", story_id: "1", completed: false, time_estimation: 6, assigned_date: "2014-05-28 00:00:00")

Worktime.create(done: 0, remaining: 6, day: "2014-05-28", task_id: 1, task_estimation: 6, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 6, day: "2014-05-29", task_id: 1, task_estimation: 6, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 6, day: "2014-05-30", task_id: 1, task_estimation: 6, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 6, day: "2014-05-31", task_id: 1, task_estimation: 6, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 6, day: "2014-06-01", task_id: 1, task_estimation: 6, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 6, day: "2014-06-02", task_id: 1, task_estimation: 6, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 6, day: "2014-06-03", task_id: 1, task_estimation: 6, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 2, day: "2014-05-28", task_id: 2, task_estimation: 2, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 2, day: "2014-05-29", task_id: 2, task_estimation: 2, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 2, day: "2014-05-30", task_id: 2, task_estimation: 2, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 2, day: "2014-05-31", task_id: 2, task_estimation: 2, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 2, day: "2014-06-01", task_id: 2, task_estimation: 2, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 2, day: "2014-06-02", task_id: 2, task_estimation: 2, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 2, day: "2014-06-03", task_id: 2, task_estimation: 2, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 4, day: "2014-05-28", task_id: 3, task_estimation: 4, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 4, day: "2014-05-29", task_id: 3, task_estimation: 4, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 4, day: "2014-05-30", task_id: 3, task_estimation: 4, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 4, day: "2014-05-31", task_id: 3, task_estimation: 4, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 4, day: "2014-06-01", task_id: 3, task_estimation: 4, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 4, day: "2014-06-02", task_id: 3, task_estimation: 4, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 4, day: "2014-06-03", task_id: 3, task_estimation: 4, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 5, day: "2014-05-28", task_id: 4, task_estimation: 5, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 5, day: "2014-05-29", task_id: 4, task_estimation: 5, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 5, day: "2014-05-30", task_id: 4, task_estimation: 5, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 5, day: "2014-05-31", task_id: 4, task_estimation: 5, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 5, day: "2014-06-01", task_id: 4, task_estimation: 5, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 5, day: "2014-06-02", task_id: 4, task_estimation: 5, sprint_id: 2, story_id: 1)
Worktime.create(done: 0, remaining: 5, day: "2014-06-03", task_id: 4, task_estimation: 5, sprint_id: 2, story_id: 1)

Worktime.create(done: 0, remaining: 4, day: "2014-05-20", task_id: 5, task_estimation: 4, sprint_id: 1, story_id: 4)
Worktime.create(done: 2, remaining: 2, day: "2014-05-21", task_id: 5, task_estimation: 4, sprint_id: 1, story_id: 4)
Worktime.create(done: 0, remaining: 4, day: "2014-05-22", task_id: 5, task_estimation: 4, sprint_id: 1, story_id: 4)
Worktime.create(done: 2, remaining: 1, day: "2014-05-23", task_id: 5, task_estimation: 4, sprint_id: 1, story_id: 4)
Worktime.create(done: 1, remaining: 0, day: "2014-05-24", task_id: 5, task_estimation: 4, sprint_id: 1, story_id: 4)

Worktime.create(done: 0, remaining: 6, day: "2014-05-20", task_id: 6, task_estimation: 6, sprint_id: 1, story_id: 4)
Worktime.create(done: 0, remaining: 6, day: "2014-05-21", task_id: 6, task_estimation: 6, sprint_id: 1, story_id: 4)
Worktime.create(done: 3, remaining: 3, day: "2014-05-22", task_id: 6, task_estimation: 6, sprint_id: 1, story_id: 4)
Worktime.create(done: 3, remaining: 0, day: "2014-05-23", task_id: 6, task_estimation: 6, sprint_id: 1, story_id: 4)
Worktime.create(done: 0, remaining: 0, day: "2014-05-24", task_id: 6, task_estimation: 6, sprint_id: 1, story_id: 4)

Worktime.create(done: 0, remaining: 6, day: "2014-05-20", task_id: 7, task_estimation: 6, sprint_id: 1, story_id: 4)
Worktime.create(done: 1, remaining: 5, day: "2014-05-21", task_id: 7, task_estimation: 6, sprint_id: 1, story_id: 4)
Worktime.create(done: 0, remaining: 5, day: "2014-05-22", task_id: 7, task_estimation: 6, sprint_id: 1, story_id: 4)
Worktime.create(done: 4, remaining: 0, day: "2014-05-23", task_id: 7, task_estimation: 6, sprint_id: 1, story_id: 4)
Worktime.create(done: 0, remaining: 0, day: "2014-05-24", task_id: 7, task_estimation: 6, sprint_id: 1, story_id: 4)

History.create(sprint_id: 1, estimation: 2, project_id:1, story_id: 1, belongs_sprint: false)
History.create(sprint_id: 1, estimation: 1, project_id:1, story_id: 2, belongs_sprint: true)
History.create(sprint_id: 1, estimation: 3, project_id:1, story_id: 3, belongs_sprint: false)
History.create(sprint_id: 1, estimation: 3, project_id:1, story_id: 4, belongs_sprint: true)
History.create(sprint_id: 2, estimation: 2, project_id:1, story_id: 1, belongs_sprint: true)
History.create(sprint_id: 2, estimation: 1, project_id:1, story_id: 2, belongs_sprint: true)
History.create(sprint_id: 2, estimation: 1, project_id:1, story_id: 3, belongs_sprint: true)
#History.create(sprint_id: 2, estimation: 1, project_id:1, story_id: 4, belongs_sprint: false)

#Workload.create(sprint_id: 1, estimation: 2, project_id:1, story_id: 1)
#Workload.create(sprint_id: 1, estimation: 1, project_id:1, story_id: 2)
#Workload.create(sprint_id: 1, estimation: 3, project_id:1, story_id: 3)
#Workload.create(sprint_id: 1, estimation: 3, project_id:1, story_id: 4)


