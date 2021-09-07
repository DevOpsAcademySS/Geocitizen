# Geocitizen

1. [ubuntu20.04](#Ubuntu 20.04)
2. [centos7](#CentOS 7)
3. [Manual deploy Geocitizen](#Manual deploy Geocitizen)
4. [Diagram as code](#Diagram as code)

## Manual deploy Geocitizen <a name="Manual deploy Geocitizen"></a>


1) `git clone git@github.com:DevOpsAcademySS/Geocitizen.git; cd Geocitizen`
1) in [`pom.xml`](https://git.io/JuGgS) file change port from `http` to `https` in [`this`](https://git.io/JuGgS) line
1) in config file [`~/Geocitizen/src/main/resources/application.properties`](https://git.io/JuGlO)
	Edit following properties
	 * [`front.url`](https://git.io/JuGWH) - front url
	 * [`db.url`](https://git.io/JuGWA) - db uri (__db must be created manually__)
1) replace url with tomcat's url (e.g. `'http://51.138.200.208:8080/citizen'`) in [`~/Geocitizen/front-end/src/main.js`](https://git.io/JuGlP)
1) `mvn install && mv target/citizen.war /usr/share/tomcat9/webapps/ && /usr/share/tomcat9/bin/startup.sh`
1) e.g. <http://51.138.200.208:8080/citizen/>


## Ubuntu 20.04 <a name="Ubuntu 20.04"></a>


Install PostgreSQL, create database 'ss_demo_1', add password, garint all privileges on database

edit following files:
    
in `/etc/postgresql/12/main/pg_hba.conf` write `host all all 192.168.1.7/24 md5`

in `/etc/postgresql/12/main/postgresql.conf ` replace `listen_addresses='localhost'` with `listen_addresses='*'`

## CentOS 7 <a name="CentOS 7"></a>


Install OpenJDK, create Tomcat system user, download and configure Tomcat

## Diagram as code <a name="Diagram as code"></a>


### diagram 1
![diagram_as_code_1](diagram_as_code_1.png)
### diagram  2
![diagram_as_code_2](diagram_as_code_2.png)
#
    
[Geocitizen](http://51.138.200.208:8080/citizen/swagger-ui.html)

