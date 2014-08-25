fs_curl
=======

FreeSWITCH mod_xml_curl base configuration classes
Users and dialplan use Mysql Database using XML_curl using "intralanman" contrib
--------------------------------------------------------------------------------

Source available  /usr/src/freeswitch.trunk/contrib/intralanman   # /usr/src ( is the path where i have downloaded the trunk)

This README.  created by Balaji BHR .... balajibhr@gmail.com    IRC : ramindia


REQUIREMENTS:


apt-get install mysql-server libmysqlclient15-dev

apt-get install php5 php5-common libapache2-mod-php5 php5-gd php5-dev curl libcurl3 libcurl3-dev php5-curl

apt-get install php-pear

pecl install pdo

pecl install pdo_mysql

updatedb




vi /etc/php5/apache2/php.ini

add below lines

extension=pdo.so
extension=pdo_mysql.so

Copying the Source intralanman to web server root directory
-----------------------------------------------------------

cp -R contrib/intralanman/PHP/fs_curl /var/www


Creating the database in Mysql
------------------------------

create database "freeswitch"


populate the tables in to freeswitch database
---------------------------------------------

mysql -u root -p < /var/www/fs_curl/sql/mysql-5.0-with-samples.sql


cd /var/www/fs_curl


vi global_defines.php

change the below settings according to your setup



/**
 * Defines the default dsn for the FS_PDO class
 */
define('DEFAULT_DSN', 'mysql:dbname=freeswitch;host=localhost');
/**
 * Defines the default dsn login for the PDO class
 */
define('DEFAULT_DSN_LOGIN', 'root');
/**
 * Defines the default dsn password for the PDOclass
 */
define('DEFAULT_DSN_PASSWORD', 'password');
/**

save the file

Configuring the XML_CURL Module
-------------------------------

cd /usr/local/freeswitch/conf/autoload_configs


vi modules.conf.xml

add line     <load module="mod_xml_curl"/>

example below


    <load module="mod_console"/>
    <load module="mod_xml_curl"/>
    <load module="mod_logfile"/>
    <!-- <load module="mod_syslog"/> -->

save files

Configuring the xml_curl to take users and dialplan information from Database
-----------------------------------------------------------------------------


vi xml_curl.conf.xml

add this line "<param name="gateway-url" value="http://localhost/fs_curl/index.php bindings="dialplan|directory"/>

example looks like this


<bindings>
    <binding name="example">
      <!-- The url to a gateway cgi that can generate xml similar to
           what's in this file only on-the-fly (leave it commented if you dont
           need it) -->
      <!-- one or more |-delim of configuration|directory|dialplan -->
 <param name="gateway-url" value="http://localhost/fs_curl/index.php bindings="dialplan|directory"/>
      <!-- set this to provide authentication credentials to the server -->


save the file


move or remove all userfile from directory/default
--------------------------------------------------

example :


mv /usr/local/freeswitch/conf/directory/deafult/1000.xml to /usr/local/freeswitch/conf/directory/deafult/1000.xml.noload


Restaring the Services
----------------------

stop the freeswitch

start the freeswitch

restart apache


TESTING
-------


http://ipaddress/fs_curl/index.php?section=directory&user=1000&domain=domain.com


you see this results

<?xml version="1.0" encoding="UTF-8" standalone="no" ?> 
- <document type="freeswitch/xml">
- <section name="directory" description="FreeSWITCH Directory">
- <domain name="domain.com">
- <params>
  <param name="default_gateway" value="errors" /> 
  </params>
  <variables /> 
- <user id="1000" mailbox="1000">
- <params>
  <param name="password" value="password" /> 
  <param name="vm-password" value="861000" /> 
  </params>
- <variables>
  <variable name="numbering_plan" value="US" /> 
  </variables>
  </user>
  </domain>
  </section>
- <!-- User is 1000
  --> 
- <!-- where array has contents
  --> 
- <!-- user id is: 1
  --> 
- <!-- fs_directory:204 - 2:array_key_exists() [<a href='function.array-key-exists'>function.array-key-exists</a>]: The second argument should be either an array or an object
  --> 
- <!-- Total # of Queries Run: 14
  --> 
- <!-- Estimated Execution Time Is: 0.216974020004
  --> 
  </document>



CONGRADULATIONS... XML_CURL with intralan contrib working

now its your own, how you like to do next

Good luck

try login using username and password as show below document


http://wiki.freeswitch.org/wiki/Getting_Started_Guide#Some_stuff_to_try_out.21

try calling 

5000 - demo IVR (requires sounds and music files to be installed) 
9995 - five second delay echo test 
9996 - standard echo test 
9999 - music on hold (requires music files to be installed) 
