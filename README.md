# Geocitizen

_Build and deploy (ubuntu20.04, centos7, git, java8, maven3, tomcat9)._

[Configuration of Ubuntu 20.04 Server](#cus)

1. [PostgreSQL](#postgresql) 

[Configuration of CentOS 7 Core](#ccc)

1. [Git](#git)
2. [Java](#java)
4. [Maven](#maven)
5. [Tomcat](#tomcat)
6. [Node.js](#nodejs)
7. [Manual deploy of Geocitizen](#geo)

---

### Configuration of Ubuntu 20.04 Server: <a name="cus"></a>

> *Sourses:* 
> 1. [How To Install and Use PostgreSQL on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04)
> 2. [How to Set the Default User Password in PostgreSQL](https://chartio.com/resources/tutorials/how-to-set-the-default-user-password-in-postgresql/)
> 3. [How Do I Enable remote access to PostgreSQL database server?](https://www.cyberciti.biz/tips/postgres-allow-remote-access-tcp-connection.html)

1. Update system: <a name="us"></a>
```sh
sudo apt update -y
```

#### PostgreSQL <a name='postgresql'></a>

---

2. Install PostgreSQL:

```sh
sudo apt install postgresql postgresql-contrib -y
```

3. Enter into PostgreSQL:

```sh
sudo -u postgres psql
```

4. CREATE DATABASE ***'ss_demo_1'*** for user ***'postgres'***:

```sql
CREATE DATABASE ss_demo_1;
```

5. Add password for ***'postgres'***: 

```sql
ALTER USER postgres PASSWORD 'postgres';
```

6. Exit from PostgreSQL: 

```sh
\q
```

7. Edit the file:

```sh
sudo vi /etc/postgresql/12/main/pg_hba.conf
```

8. Add next line after ***'# IPv4 local connections'*** comment and set ip addres of your server:

```sh
host all all 192.168.1.7/24 md5
```

9. Edit file ***'postgresql.conf'***:

```sh
sudo vi /etc/postgresql/8.2/main/postgresql.conf
```

10. Find and edit line: `listen_addresses='localhost'` to `listen_addresses='*'` or add litening addres insted of '*'.

11. Restart PostgreSQL:

```sh
sudo /etc/init.d/postgresql restart
```

12. Make shure that firewall not blocking port 5430 enter next commands:

```sh
iptables -A INPUT -p tcp -s 0/0 --sport 1024:65535 -d 192.168.1.10  --dport 5432 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s 192.168.1.10 --sport 5432 -d 0/0 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT
```

13. Restart firewall:

```sh
sudo /etc/init.d/iptables restart
```

---

### Configuration of CentOS 7 Core: <a name="ccc"></a>

> *Sourses:* 
> 1. [Install Java 8 on CentOS 7](https://www.liquidweb.com/kb/install-java-8-on-centos-7/)
> 2. [How to install Apache Maven on CentOS 7](https://baks.dev/article/centos/how-to-install-apache-maven-on-centos-7)
> 3. [How to Install Tomcat 9 on CentOS 7](https://linuxize.com/post/how-to-install-tomcat-9-on-centos-7/)

#### Git <a name='git'></a>

---

1. Update system and install ***'Git'***:

```sh
sudo yum update -y
sudo yum install git -y
```

2. (Optional) Install bash autocomplete and Midnight Commander: 

```sh
sudo yum install bash-completion bash-completion-extras mc -y
source /etc/profile.d/bash_completion.sh
```

3. Clone git repository:

```sh
git clone https://github.com/DevOpsAcademySS/Geocitizen.git
```

#### Java <a name='java'></a>

---

4. Install Java 8 jdk:

```sh
sudo yum install java-1.8.0-openjdk-devel -y
```

5. Find Java 8 Path and set ***'JAVA_HOME'*** variable, using the following command will give us a path so we can set the variable:

```sh
sudo update-alternatives --config java
```

6. Open ***'.bash_profile'***:

```sh
sudo vi .bash_profile
```

7. Export your Java path into the ***'.bash_profile'*** by adding the following to the bottom of the file. (Your path may look different from mine, and it’s not important that they vary.):

```sh
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-1.el7_6.x86_64/jre/bin/java
```

8. Refresh the File:

```sh
source .bash_profile
```

9. Install ***'wget'***:

```sh
sudo yum install wget -y
```

#### Maven <a name='maven'></a>

---

10. Download Maven 3.6+ from [official website](https://maven.apache.org/download.cgi) with ***'wget'*** commandв into ***'/tmp'*** directory:

```sh
wget https://www-us.apache.org/dist/maven/maven-3/3.8.2/binaries/apache-maven-3.8.2-bin.tar.gz -P /tmp
```

11. Unarchivate ***'apache-maven-3.8.2-bin.tar.gz'*** into ***'/opt'*** directory:

```sh
sudo tar xf /tmp/apache-maven-3.8.2-bin.tar.gz -C /opt
```

12. To better control Maven versions and updates, we will create a symbolic link maven that will point to the Maven installation directory:

```sh
sudo ln -s /opt/apache-maven-3.8.2 /opt/maven
```

13. Next, we need to set up environment variables. Open your text editor and create a new file called mavenenv.sh inside ***'/etc/profile.d/directory'***:

```sh
sudo vi /etc/profile.d/maven.sh
```

14. Paste the following lines in ***'/etc/profile.d/maven.sh'***:

```sh
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-1.el7_6.x86_64
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}
```

15. Make the script executable by running the following ***'chmod'** command:

```sh
sudo chmod +x /etc/profile.d/maven.sh
```

16. Load environment variables using source command:

```sh
source /etc/profile.d/maven.sh
```

17. (Optional) To make sure Maven is installed, use the ***'mvn -version'*** command, which will display the Maven version:

```sh
mvn -version
```

#### Tomcat <a name='tomcat'></a>

---

18. Download Tomcat from [official website](https://tomcat.apache.org/download-90.cgi) with ***'wget'*** commandв into ***'/tmp'*** directory:

```sh
wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.52/bin/apache-tomcat-9.0.52.tar.gz -P /tmp
```

19. Unarchivate ***'apache-tomcat-9.0.52.tar.gz'*** into ***'/opt'*** directory:

```sh
sudo tar xf /tmp/apache-tomcat-9.0.52.tar.gz -C /opt
```

20. Tomcat 9 is updated frequently. To have more control over versions and updates, we’ll create a symbolic link called ***'latest'***, that points to the Tomcat installation directory:

```sh
sudo ln -s /opt/tomcat/apache-tomcat-9.0.27 /opt/tomcat/latest
```

21. To make Tomcat run as a service create a ***'tomcat.service'*** unit file in the ***'/etc/systemd/system/'*** directory:

```sh
sudo vi /etc/systemd/system/tomcat.service
```

22. Paste the following content in ***'/etc/systemd/system/tomcat.service'***:

```s
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-1.el7_6.x86_64/jre"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```

23. Notify systemd that we created a new unit file by typing:

```sh
sudo systemctl daemon-reload
```

24. Enable and start the Tomcat service:

```sh
sudo systemctl enable tomcat
sudo systemctl start tomcat
```

25. (Optional) Check the service status with the following command:

```sh
sudo systemctl status tomcat
```

26. Adjust the Firewall.

If your server is protected by a firewall and you want to access the tomcat interface from the outside of the local network, you need to open port 8080.

Use the following commands to open the necessary port:

```sh
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
```

27. (Optional) Configure Tomcat Web Management Interface.

At this point Tomcat is installed, and we can access it with a web browser on port 8080, but we can not access the web management interface because we have not created a user yet.

Tomcat users and their roles are defined in the tomcat-users.xml file.
If you open the file, you will notice that it is filled with comments and examples describing how to configure the file:

```sh
sudo vi /opt/tomcat/latest/conf/tomcat-users.xml
```

28. (Optional) To add a new user that will be able to access the tomcat web interface (manager-gui and admin-gui) you need to define the user in ***'/opt/tomcat/latest/conf/tomcat-users.xml'*** file as shown below. Make sure you change the username and password to something more secure:

```xml
<tomcat-users>
<!--
    Comments
-->
   <role rolename="admin-gui"/>
   <role rolename="manager-gui"/>
   <user username="admin" password="admin_password" roles="admin-gui,manager-gui"/>
</tomcat-users>
```

29. (Optional) By default Tomcat web management interface is configured to allow access only from the localhost. If you want to be able to access the web interface from a remote IP or from anywhere which is not recommended because it is a security risk you can open the following files and make the following changes.

If you need to access the web interface from anywhere open the following files and comment or remove the lines highlighted in green:

***/opt/tomcat/latest/webapps/manager/META-INF/context.xml***
```xml
<Context antiResourceLocking="false" privileged="true" >
<!--
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
</Context>
```

***/opt/tomcat/latest/webapps/host-manager/META-INF/context.xml***
```xml
<Context antiResourceLocking="false" privileged="true" >
<!--
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
</Context>
```

If you need to access the web interface only from a specific IP, instead of commenting the blocks add your public IP to the list. Let’s say your public IP is 41.41.41.41 and you want to allow access only from that IP:

***/opt/tomcat/latest/webapps/manager/META-INF/context.xml***
```xml
<Context antiResourceLocking="false" privileged="true" >
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1|41.41.41.41" />
</Context>
```

***/opt/tomcat/latest/webapps/host-manager/META-INF/context.xml***
```xml
<Context antiResourceLocking="false" privileged="true" >
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1|41.41.41.41" />
</Context>
```

The list of allowed IP addresses is a list separated with vertical bar |. You can add single IP addresses or use a regular expressions.

30. Once done, restart the Tomcat service for changes to take effect:

```sh
sudo systemctl restart tomcat
```

#### Node.js <a name='nodejs'></a>

---

31. Install Node.js:

```sh
sudo yum install nodejs -y
```

#### Manual deploy Geocitizen <a name='geo'></a>

---

32. Edit pom.xml file, change port from http to https in this line:

```html
<url>http://repo.spring.io/milestone</url>
```

33. Edit ***'/Geocitizen/src/main/resources/application.properties'*** file:

Change ***'localhost'*** to the IP, that your virtual machine is using _(also u can assign IP to MAC address, so DHCP wont change VM’s IP, I did it in router settings)_ and change database IP. 

34. Build front-end:

Change ***'localhost'*** in ***'front-end/src/main.js'*** to your IP.

In ***'front-end'*** directory do `npm install`. In my case I had errors, so I changed these lines in ***'package.json'*** : ***"vue-material"***: ***"^1.0.0-beta-7"*** to ***"vue-material"***: ***"1.0.0-beta-8"***, also ***"vue-router"***: ***"^3.0.1"*** to ***"vue-router"***: ***"3.0.1"***. Now `nmp install` should work. !_(Changing versions is not necessary and only if you have errors while doing npm install)!_

If every dependencies are downloaded do `npm run build`.

After build copy everything in ***'front-end/dist'*** to ***'src/main/webapp'*** and in ***'/src/main/webapp/index.html'***_(not in ***'front-end'***, but in forlder there we copied it to)_ put dots on lines:
Aafter `<link href=`
Aafter `<script type=text/javascript src=`
Now do `mvn install`.
Aafter that do `mv target/citizen.war /usr/share/tomcat9/webapps/`  _(tomcat folder could be this ***'/var/lib/tomcat/'***)_.

35. Now you can start tomcat service : `sudo systemctl <start/restart> tomcat`

Check if it works, go to `https://<IP of your VM>:8080`
