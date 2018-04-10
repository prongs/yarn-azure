install_and_configure() {
	cd hadoop
	./install.sh
	cd ..
}

install_and_configure
SERVICE_DIRECTORY="$1"
shift

# EXPORT rest of the arguments
for i in "$@"
do
   eval "export $i"
done

cd $SERVICE_DIRECTORY
bash start.sh
cd ..
