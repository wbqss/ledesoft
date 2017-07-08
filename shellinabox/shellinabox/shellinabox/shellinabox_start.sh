#! /bin/sh
export KSROOT=/koolshare
if [ ! -L "$KSROOT/init.d/S99Shellinabox.sh" ]; then 
	ln -sf $KSROOT/shellinabox/shellinabox_start.sh /etc/rc.d/S99Shellinabox.sh
fi

fix_libssl() {
	libssl=$(find /lib /usr/lib -name "libssl.so*" -type f)
	if [ -n "$libssl" ];then
		dir=$(dirname $libssl)
		libssl=$(basename $libssl)

		cd $dir
		[ ! -f libssl.so ] && ln -s $libssl libssl.so
		cd - > /dev/null
	fi
}

case $ACTION in
start)
	killall shellinaboxd
	fix_libssl
	$KSROOT/shellinabox/shellinaboxd -u root -c /koolshare/shellinabox --css=/koolshare/shellinabox/white-on-black.css -b
	;;
stop)
	killall shellinaboxd
	;;
*)
	killall shellinaboxd
	fix_libssl
	$KSROOT/shellinabox/shellinaboxd -u root -c /koolshare/shellinabox --css=/koolshare/shellinabox/white-on-black.css -b
	;;
esac
