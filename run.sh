install_and_configure() {
	cd hadoop
	./install.sh
	cd ..
}

SERVICE_DIRECTORY="$1"
shift

# EXPORT rest of the arguments
for i in "$@"
do
   eval "export $i"
done

install_and_configure

cd $SERVICE_DIRECTORY
./start.sh
cd ..
