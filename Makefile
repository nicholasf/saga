.PHONY:

db_down:
	dropdb -U postgres --password

db_up:
	createdb saga_development -U postgres --password
	psql -U postgres saga_development < db/schema.sql --password
