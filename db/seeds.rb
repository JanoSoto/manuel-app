# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

begin
	Role.create([
						{id: 1, name: 'Admin'},
						{id: 2, name: 'Recepcionista'},
						])
	puts 'Roles creados con éxito'
rescue Exception => e
	puts 'WARNING: Los roles ya están agregados'
end