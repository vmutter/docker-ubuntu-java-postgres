#!/bin/sh
/etc/init.d/postgresql start

su -c 'psql --command "CREATE USER postgres WITH SUPERUSER PASSWORD 'postgres';"' postgres
su -c 'createdb -O postgres postgres' postgres
