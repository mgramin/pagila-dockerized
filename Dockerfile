FROM postgres:17

RUN mkdir -p /var/lib/postgresql-static/data
ENV PGDATA /var/lib/postgresql-static/data

RUN apt-get update
RUN apt-get install wget -y

RUN wget --output-document=/var/tmp/pagila-schema.sql https://raw.githubusercontent.com/devrimgunduz/pagila/refs/heads/master/pagila-schema.sql
RUN wget --output-document=/var/tmp/pagila-data.sql https://raw.githubusercontent.com/devrimgunduz/pagila/refs/heads/master/pagila-data.sql



RUN echo "psql -t template1 -U postgres -c 'alter system set shared_preload_libraries=''pg_stat_statements'',''pg_buffercache'';'" >> /docker-entrypoint-initdb.d/run_dbdump.sh

RUN echo "psql -U postgres -c 'CREATE EXTENSION IF NOT EXISTS pg_stat_statements;'" >> /docker-entrypoint-initdb.d/run_dbdump.sh



RUN echo "psql -U postgres -f /var/tmp/pagila-schema.sql" >> /docker-entrypoint-initdb.d/run_dbdump.sh
RUN echo "psql -U postgres -f /var/tmp/pagila-data.sql" >> /docker-entrypoint-initdb.d/run_dbdump.sh
