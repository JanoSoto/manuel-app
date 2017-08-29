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

# Encuesta 360
begin
	Survey.create(id: 1,
								name: 'Encuesta 360', 
								description: 'Esta encuesta tiene como objetivo evaluar el nivel de participación y colaboración 
								de los diferentes miembros de los equipos que trabajaron en el trabajo asignado. Luego, debe 
								responder una encuesta por cada miembro de su equipo, incluido usted mismo (se auto evalúa como 
								si fuera otra persona). Si el grupo es de seis personas debe responder seis veces la encuesta 
								eligiendo cada vez un miembro diferente del grupo que será evaluado por usted.

								El nombre de 360° proviene del hecho de que la evaluación la realizarán los propios equipos 
								sobre sus compañeros, de esta forma, se dará alguno de los siguientes casos:

								1) Si usted es miembro de un grupo, deberá evaluar a los miembros del equipo, líder de equipo 
								incluido.
								2) Si usted es líder de equipo, deberá evaluar a los miembros que participaron en su equipo como 
								cualquier otro miembro.

								Cada una de las preguntas debe ser respondida de manera independiente para cada miembro evaluado. 
								Cuando se auto-evalúe piense en cómo lo evaluarían sus compañeros de acuerdo a su comportamiento 
								y responsabilidad en la realización de las tareas en las cuales usted se involucró.'
							)
	Question.create([
							{
							 id: 1, 
							 statement: '1. ¿Realiza las tareas que le son asignadas dentro del grupo en los plazos requeridos?',
							 hint: 'Se aplica al integrante de su grupo.',
							 survey_id: 1
							},
							{
							 id: 2, 
							 statement: '2. ¿Participa de forma activa en los espacios de encuentro del equipo, compartiendo 
							 la información, los conocimientos y las experiencias?',
							 hint: 'Se aplica al integrante de su grupo.',
							 survey_id: 1
							},
							{
							 id: 3, 
							 statement: '3. ¿Colabora en la definición, organización y distribución de las tareas del equipo?',
							 hint: 'Se aplica al integrante de su grupo.',
							 survey_id: 1
							},
							{
							 id: 4, 
							 statement: '4. ¿Se orienta a la consecución de acuerdos y objetivos comunes y se compromete con ellos?',
							 hint: 'Se aplica al integrante de su grupo.',
							 survey_id: 1
							},
							{
							 id: 5, 
							 statement: '5. ¿Toma en cuenta los puntos de viste de los demás y retroalimenta constructivamente? ',
							 hint: 'Se aplica al integrante de su grupo.',
							 survey_id: 1
							},
							{
							 id: 6, 
							 statement: '6. ¿Volvería a involucrase con esta persona en otro proyecto?',
							 hint: 'Se aplica al integrante de su grupo o a su líder. En el caso que sea usted mismo el que se 
							 evalúa ponga lo que piensa su grupo piensa sobre usted.',
							 survey_id: 1
							}
							])
	AnswerOption.create([
							{
								id: 1,
								answer: 'No cumple las tareas asignadas',
								score: 1,
								question_id: 1
							},
							{
								id: 2,
								answer: 'Cumple parcialmente o se retrasa',
								score: 2,
								question_id: 1
							},
							{
								id: 3,
								answer: 'Cumple parcialmente o se retrasa',
								score: 3,
								question_id: 1
							},
							{
								id: 4,
								answer: 'Cumple con la tarea y la calidad supone un aporte notable.',
								score: 4,
								question_id: 1
							},
							{
								id: 5,
								answer: 'Cumple con la tarea y su trabajo aporta, orienta y facilita la del resto del equipo',
								score: 5,
								question_id: 1
							},
							{
								id: 6,
								answer: 'Se ausenta con facilidad y su presencia es irrelevante.',
								score: 1,
								question_id: 2
							},
							{
								id: 7,
								answer: 'Interviene poco, pero atiende a los requerimientos del resto.',
								score: 2,
								question_id: 2
							},
							{
								id: 8,
								answer: 'En general, se muestra activo y participativo.',
								score: 3,
								question_id: 2
							},
							{
								id: 9,
								answer: 'Fomenta la participación y mejora la calidad de los resultados del equipo.',
								score: 4,
								question_id: 2
							},
							{
								id: 10,
								answer: 'Sus aportes son fundamentales tanto para la calidad como el resultado del producto.',
								score: 5,
								question_id: 2
							},
							{
								id: 11,
								answer: 'Se resiste a trabajar en equipo.',
								score: 1,
								question_id: 3
							},
							{
								id: 12,
								answer: 'Se limita a aceptar la organización propuesta por los otros miembros.',
								score: 2,
								question_id: 3
							},
							{
								id: 13,
								answer: 'Participa en la planificación, organización y distribución de tareas.',
								score: 3,
								question_id: 3
							},
							{
								id: 14,
								answer: 'Es organizado y distribuye el trabajo con eficacia.',
								score: 4,
								question_id: 3
							},
							{
								id: 15,
								answer: 'Fomenta la organización del trabajo aprovechando los recursos y habilidades del equipo.',
								score: 5,
								question_id: 3
							},
							{
								id: 16,
								answer: 'Persigue objetivos personales.',
								score: 1,
								question_id: 4
							},
							{
								id: 17,
								answer: 'Le cuesta integrar los objetivos personales con los del equipo.',
								score: 2,
								question_id: 4
							},
							{
								id: 18,
								answer: 'Asume como propios los objetivos del equipo.',
								score: 3,
								question_id: 4
							},
							{
								id: 19,
								answer: 'Promueve la definición de objetivos de manera clara e integrando al equipo en torno a los mismos.',
								score: 4,
								question_id: 4
							},
							{
								id: 20,
								answer: 'Moviliza y cohesiona al equipo para alcanzar objetivos más exigentes (el equipo sobresale por su rendimiento y calidad).',
								score: 5,
								question_id: 4
							},
							{
								id: 21,
								answer: 'No escucha las intervenciones de sus compañeros y las descalifica sistemáticamente (Quiere imponer sus opiniones).',
								score: 1,
								question_id: 5
							},
							{
								id: 22,
								answer: 'Escucha poco, no pregunta, no se preocupa por la opinión ajena (intervenciones redundantes y poco sugerentes).',
								score: 2,
								question_id: 5
							},
							{
								id: 23,
								answer: 'Acepta las opiniones de otros y sabe dar su punto de vista constructivamente.',
								score: 3,
								question_id: 5
							},
							{
								id: 24,
								answer: 'Fomenta el diálogo constructivo e inspira la participación de los otros miembros del equipo.',
								score: 4,
								question_id: 5
							},
							{
								id: 25,
								answer: 'Integra las opiniones ajenas en una perspectiva superior, manteniendo un clima de colaboración y apoyo.',
								score: 5,
								question_id: 5
							},
							{
								id: 26,
								answer: 'Definitivamente no',
								score: 1,
								question_id: 6
							},
							{
								id: 27,
								answer: 'Posiblemente no',
								score: 2,
								question_id: 6
							},
							{
								id: 28,
								answer: 'Me es indiferente',
								score: 3,
								question_id: 6
							},
							{
								id: 29,
								answer: 'Posiblemente sí',
								score: 4,
								question_id: 6
							},
							{
								id: 30,
								answer: 'Definitivamente sí',
								score: 5,
								question_id: 6
							}
							])
	puts 'Encuesta 360 creada con éxito'
rescue Exception => e
	puts 'La encuesta 360 ya ha sido agregada al sistema'
	puts e.to_s
end