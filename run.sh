install_and_configure() {
	cd hadoop
	./install.sh
}
resourcemanager() {
	install_and_configure
	cd resourcemanager/
}
nodemanager() {
	install_and_configure
	cd nodemanager/
	bash start.sh
}

install_and_configure
cd $1/
bash start.sh
