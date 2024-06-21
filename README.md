# Geocitizen

_Build and deploy (ubuntu20.04, centos7, git, java8, maven3, tomcat9)._

## Setup:
### CentOs 7 (database):
Install, config, create user and database: use instruction from [How To Install PostgreSQL 11.x on CentOS 7 - SymmCom](https://www.symmcom.com/docs/how-tos/databases/how-to-install-postgresql-11-x-on-centos-7) but create db ss_demo_1
To check db:
1. Enter the postgres : `sudo -u postgres psql` and enter password

2. Enter db: `\c ss_demo_1 ` (`\l ` to see all db)

3. See all tables: `\dt`

4. See all users: `SELECT * FROM users;`

### Ubuntu 20.4(front&back-end):
Install maven 3.6.3 and setup environment variables: use instruction from [How to Install Apache Maven on Ubuntu 20.04](https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-20-04/)

Be careful with setup variables, check **YOUR** path to `JAVA_HOME`, `M2_HOME` and `MAVEN_HOME`. 

Install tomcat9 and create user: use instruction from [How to Install Apache Tomcat Server on Ubuntu 20.04](https://linuxhint.com/install_apache_tomcat_server_ubuntu/) 

### Launch Geocitizen:

1. Clone repository : 
```sh
git clone https://github.com/DevOpsAcademySS/Geocitizen.git
```

2. Edit pom.xml file, change protocol from http to https in line: 
```
url>http://repo.spring.io/milestone</url>
```

3. Change in *front-end/src/main.js*: `backEndUrl` from *localhost* to *ip address of Ubuntu*

4. Change in *src/main/resources/application.properties*: `front.url & front-end.url` from *localhost* to *ip address of Ubuntu*, `db.url & url & referenceUrl` from *localhost* to *ip address of CentOs*

5. Change in *src/main/webapp/static/js/app.6313e3379203ca68a255.js*: `St` from *localhost* to *ip address of Ubuntu*

6. Change in *src/main/webapp/static/js/app.6313e3379203ca68a255.js.map*: `backEndUrl` from *localhost* to *ip address of Ubuntu*

7.Do 
```sh
mvn install 
```

8. Copy *target/citizen.war* to tomcat webapps folder( can be different): 
```sh
mv target/citizen.war  /var/lib/tomcat9/webapps
```

9. Restart tomcat service: 
```sh
sudo systemctl restart tomcat9
```

10. Check site: http://192.168.0.41:8080/ (Ubuntu ip address and port 8080) & http://192.168.0.41:8080/citizen/#/


