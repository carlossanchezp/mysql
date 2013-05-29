#!/bin/bash

###############################################################
#
# autor: STR Sistemas - Octubre 2012
# 
# este fichero contiene un listado de comandos que se deben seguir leyendo los comentarios
# aunque puede ejecutarse directamente en consola, este fichero NO DEBE considerarse un script 
# ya que por ejemplo no tiene control de errores
#
###############################################################

# creamos el usuario y el grupo que ejecutará MySQL
groupadd mysql
useradd -g mysql -d /var/lib/mysql mysql

# creamos directorios de ejecución y datos de MySQL y damos los permisos adecuados
mkdir /var/lib/mysql
mkdir /var/run/mysqld
mkdir /var/log/mysql
# ya existe en la imagen de STR Sistemas
#mkdir /etc/mysql
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/log/mysql

# descomprimimos el paquete de MySQL previamente descargado desde la web de MySQL y disponible en la imagen de STR Sistemas
cd /usr/local
tar xvzf /root/resources/mysql-5.5.28-linux2.6-i686.tar.gz

# creamos un enlace simbólico para facilitar tanto el acceso como las posteriores acutalizaciones de versiones
ln -s mysql-5.5.28-linux2.6-i686 mysql

# creamos enlaces simbólicos a los binarios más utilizados de MySQL por el administrador para acceder desde el PATH
ln -s /usr/local/mysql/share /usr/share/mysql 
ln -s /usr/local/mysql/bin/mysql /usr/bin/mysql
ln -s /usr/local/mysql/bin/mysqld /usr/bin/mysqld
ln -s /usr/local/mysql/bin/mysqldump /usr/bin/mysqldump
ln -s /usr/local/mysql/bin/mysqladmin /usr/bin/mysqladmin
ln -s /usr/local/mysql/bin/mysql_config /usr/bin/mysql_config

# realicemos las configuraciones básicas de MySQL
# paquetes requeridos por MySQL ya instalados en la imagen de STR Sistemas
# apt-get install libaio-dev libaio1 
cd /usr/local/mysql
rm -rf data
ln -s /var/lib/mysql data
./scripts/mysql_install_db --user=mysql --force

# instalamos un fichero de configuración base descargable desde http://cursos-se-puede.strsistemas.com/sites/default/files/my.cnf.tgz
cd /root/resources
wget http://cursos-se-puede.strsistemas.com/sites/default/files/my.cnf.gz
gzip -d my.cnf.gz
mv my.cnf /etc/mysql/

# Para poder arrancar y parar de manera sencilla MySQL copiamos al host el fichero mysql5.5 descargable desde http://cursos-se-puede.strsistemas.com/sites/default/files/mysql5.5.tgz y lo ubicamos en /etc/init.d
# con ese script podemos además configurar el arranque automático del servicio en el arranque del sistema
wget http://cursos-se-puede.strsistemas.com/sites/default/files/mysql5.5.tgz
tar xvzf mysql5.5.tgz
mv mysql5.5 /etc/init.d/

# arrancamos MySQL
/etc/init.d/mysql5.5 start

# comprobamos si ha habido errores
tail -15 /var/log/mysql/mysql_err.log

# cargar la base de datos de pruebas
wget http://cursos-se-puede.strsistemas.com/sites/default/files/bd_pruebas.sql.gz
zcat bd_pruebas.sql.gz | mysql -u root

# establecer una contraseña para el usuario root de MySQL
/usr/bin/mysqladmin -u root password 'strsistemas'