#!/bin/bash
apt-get -y update
apt-get -y install jq tree

apt-get -y install postgresql
#update config to all connections from app server
echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf
sed -i "s/127\.0\.0\.1\/32/all/g" /etc/postgresql/12/main/pg_hba.conf

systemctl restart postgresql.service
systemctl status postgresql.service

mkdir -p /cloudacademy-app
cd /cloudacademy-app

sudo -i -u postgres psql -c "ALTER USER postgres PASSWORD 'cloudacademy';"
sudo -i -u postgres psql -c "CREATE DATABASE cloudacademy;"

cat > dbsetup.sql << EOF
CREATE TABLE IF NOT EXISTS users(user_id VARCHAR (36) PRIMARY KEY, username VARCHAR (50) UNIQUE NOT NULL, password VARCHAR (50) NOT NULL, created_on TIMESTAMP NOT NULL, last_login TIMESTAMP);
CREATE TABLE IF NOT EXISTS comments(id VARCHAR (36) PRIMARY KEY, username VARCHAR (36), body VARCHAR (500), created_on TIMESTAMP NOT NULL);

INSERT INTO users (user_id, username, password, created_on) VALUES ('$(uuidgen)', 'admin', '$(echo -n v3rysecretpassword | md5sum | cut -b-32)', current_timestamp);
INSERT INTO users (user_id, username, password, created_on) VALUES ('$(uuidgen)', 'alice', '$(echo -n password1 | md5sum | cut -b-32)', current_timestamp);
INSERT INTO users (user_id, username, password, created_on) VALUES ('$(uuidgen)', 'bob', '$(echo -n password2 | md5sum | cut -b-32)', current_timestamp);
INSERT INTO users (user_id, username, password, created_on) VALUES ('$(uuidgen)', 'joe', '$(echo -n password3 | md5sum | cut -b-32)', current_timestamp);

INSERT INTO comments (id, username, body, created_on) VALUES ('$(uuidgen)', 'bob', 'good times ahead', current_timestamp);
INSERT INTO comments (id, username, body, created_on) VALUES ('$(uuidgen)', 'alice', 'security review required', current_timestamp);
INSERT INTO comments (id, username, body, created_on) VALUES ('$(uuidgen)', 'joe', 'lets roll', current_timestamp);
EOF

sudo -i -u postgres psql -d cloudacademy -f /cloudacademy-app/dbsetup.sql

echo fin v1.01!
