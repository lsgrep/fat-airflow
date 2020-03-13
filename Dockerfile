FROM puckel/docker-airflow:latest

USER root
RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7
RUN apt update && apt install default-libmysqlclient-dev libpq-dev postgresql-client telnet unixodbc-dev libpng-dev libssl-dev libgssapi-krb5-2 gnupg g++ -y
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt update
RUN ACCEPT_EULA=Y apt-get install msodbcsql17 -y
RUN ACCEPT_EULA=Y apt-get install mssql-tools -y
RUN cp /opt/mssql-tools/bin/* /usr/local/bin/


RUN pip install --upgrade setuptools
RUN pip install --upgrade pip
RUN pip install cython
RUN pip install tensorflow
RUN pip install matplotlib
RUN pip install pandas
RUN pip install numpy
RUN pip install seaborn
RUN pip install mysqlclient
RUN pip install psycopg2
RUN pip install sqlalchemy
RUN pip install convertdate
RUN pip install LunarCalendar
RUN pip install holidays
RUN pip install plotly
# this is the only way to install pystan
RUN pip install --no-binary :all: --upgrade pystan
RUN pip install fbprophet

ENV PYTHONPATH "${PYTHONPATH}:/usr/local/airflow/dags"
USER airflow

