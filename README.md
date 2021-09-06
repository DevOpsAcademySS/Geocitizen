# Geocitizen

build and deploy (ubuntuserver, centos7, git, java11, maven3, tomcat9, postgresql11)
___
## Configuration of virtual machines
All links bellow i used to configure my virtual machines: Ubuntu Server with PostgreSQL database and CentOS 7 to deploy Geocitizen.

[Installing Tomcat on CentOS](https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-8-on-centos-7)

[Installing Maven on CentOS](https://linuxize.com/post/how-to-install-apache-maven-on-centos-7/)

[Java on CentOS](https://phoenixnap.com/kb/install-java-on-centos)

[NodeJS](https://linuxize.com/post/how-to-install-node-js-on-centos-7/)

[Install and configure PostgreSQL](https://winitpro.ru/index.php/2019/09/26/ustanovka-postgresql-db-centos/)
___
## Manual deploy of Geocitizen

1) `git clone https://github.com/DevOpsAcademySS/Geocitizen.git`
2) Configure and build front-end:
	- change [`localhost`](https://github.com/DevOpsAcademySS/Geocitizen/blob/b17414654293ec4f8c9d2509aa5d7c9c72080089/front-end/src/main.js#L26) in [`~/Geocitizen/front-end/src/main.js`](front-end/src/main.js) to VM's IP.
	- change directory to `~/Geocitizen/front-end/` and run `npm install`. In my case, I had [errors](), so I changed versions of these packages in [`package.json`](front-end/package.json) : 
	`"vue-material": "^1.0.0-beta-7"` to `"vue-material": "1.0.0-beta-8"` and `"vue-router": "^3.0.1"` to `"vue-router": "3.0.1"`. Now `nmp install` should be successfull.
	- run `npm audit fix` if needed
	- after successfull `npm install` run `npm run build`
	- after build copy everything from `~/Geocitizen/front-end/dist/` to `~/Geocitizen/src/main/webapp/`, and in [`~/Geocitizen/src/main/webapp/index.html`](src/main/webapp/index.html)(not in front-end, but in forlder there we copied it to) put dots in lines:
		```
			after <link href=

			after <script type=text/javascript src=
		```	
3) in config file [`~/Geocitizen/src/main/resources/application.properties`](src/main/resources/application.properties)
	you need to edit following properties:
	 * [`front.url`](https://github.com/DevOpsAcademySS/Geocitizen/blob/b17414654293ec4f8c9d2509aa5d7c9c72080089/src/main/resources/application.properties#L2) - front url
	 * [`front-end.url`](https://github.com/DevOpsAcademySS/Geocitizen/blob/b17414654293ec4f8c9d2509aa5d7c9c72080089/src/main/resources/application.properties#L3) - front-end url
	 * [`db.url`](https://github.com/DevOpsAcademySS/Geocitizen/blob/b17414654293ec4f8c9d2509aa5d7c9c72080089/src/main/resources/application.properties#L6) - db url (__db must be created manually__)
	 * [`db.username`](https://github.com/DevOpsAcademySS/Geocitizen/blob/b17414654293ec4f8c9d2509aa5d7c9c72080089/src/main/resources/application.properties#L7) & [`db.password`](https://github.com/DevOpsAcademySS/Geocitizen/blob/b17414654293ec4f8c9d2509aa5d7c9c72080089/src/main/resources/application.properties#L8) - db credentials
4) Edit [`pom.xml`](pom.xml) file, change port from http to https in this line:[`<url>http://repo.spring.io/milestone</url>`](https://github.com/DevOpsAcademySS/Geocitizen/blob/b17414654293ec4f8c9d2509aa5d7c9c72080089/pom.xml#L587)
5) `mvn install` in `~/Geocitizen/`
6) `mv target/citizen.war /opt/tomcat/webapps/` (instead of `/opt/tomcat/` path to tomcat home directory can be different e.g., `/usr/share/tomcat9/` or `/var/lib/tomcat`)
7) restart tomcat service `systemctl restart tomcat`
8) go to http://< IP of your VM >:8080 
___
## [**Results**](https://imgur.com/a/7RSJC7K)
___
## Errors
* `vue-material` error:
	![image](https://imgur.com/9qfcdrx.png)
* `vue-router` error(no "Login" buttin):
	![image](https://i.imgur.com/b6YVdpF.png)
	![image](https://i.imgur.com/CG9lNvq.png)
	<p align=center>Google Chrome</p>

	![image](https://i.imgur.com/Kjo0pKn.png)

	<p align=center>Mozilla Firefox</p>
