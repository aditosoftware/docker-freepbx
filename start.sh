#!/bin/bash
/etc/init.d/mysql start
/etc/init.d/apache2 start
fwconsole start

touch /var/log/asterisk/freepbx.log
tail -f /var/log/asterisk/freepbx.log