install_and_configure() {
	cd hadoop
	./install.sh
	cd ..
}

install_and_configure
cd $1/
bash start.sh
