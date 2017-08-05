# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

begin
	Role.create([
						{id: 1, name: 'Administrador'},
						{id: 2, name: 'Profesor'},
						{id: 3, name: 'Estudiante'}
						])
	puts 'Roles creados con éxito'
rescue Exception => e
	puts 'WARNING: Los roles ya están agregados'
end

begin
	User.create([
		{id: 1, email: 'administrador@mail.com', password: '123456', name: 'administrador', lastname: 'administrador', roles_id: 1},
		{id: 2, email: 'profesor@mail.com', password: '123456', name: 'profesor', lastname: 'profesor', roles_id: 2},
		{id: 3, email: 'estudiante1@mail.com', password: '123456', name: 'estudiante1', lastname: 'estudiante', roles_id: 3},
		{id: 4, email: 'estudiante2@mail.com', password: '123456', name: 'estudiante2', lastname: 'estudiante', roles_id: 3}
	])
rescue Exception => e
	puts 'WARNING: Los usuarios ya han sido creados'
end