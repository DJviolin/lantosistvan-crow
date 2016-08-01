#!/usr/bin/bash

# set -e making the commands if they were like &&
# set -x putting + before every line
set -e

read -e -p "Enter the path to the install dir (or hit enter for default path): " -i "$HOME/www/crow" INSTALL_DIR
echo $INSTALL_DIR
REPO_DIR=$INSTALL_DIR

echo -e "\nCreating folder structure:"
mkdir -p $INSTALL_DIR/app/bin $INSTALL_DIR/app/src/include/{amalgamate,boost,mstch} $INSTALL_DIR/docker
ls -al $INSTALL_DIR
echo "Done!"

if test "$(ls -A "$REPO_DIR")"; then
  echo -e "\n\"$REPO_DIR\" directory is not empty!\nYou have to remove everything from here to continue!\nRemove \"$REPO_DIR\" directory (y/n)?"
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    rm -rf $REPO_DIR/
    echo -e "\"$REPO_DIR\" is removed, continue installation...";
    mkdir -p $REPO_DIR
    echo -e "\nCloning git repo into \"$REPO_DIR\":"
    cd $REPO_DIR
    git clone https://github.com/DJviolin/lantosistvan-crow.git $REPO_DIR
    #chmod +x $REPO_DIR/docker/service-start.sh $REPO_DIR/docker/service-stop.sh
    echo -e "\nShowing working directory..."
    ls -al $REPO_DIR
  else
    echo -e "\nScript aborted to run\nExiting..."; exit 1;
  fi
else
  echo -e "\nCloning git repo into \"$REPO_DIR\":"
  cd $REPO_DIR
  git clone https://github.com/DJviolin/lantosistvan-crow.git $REPO_DIR
  #chmod +x $REPO_DIR/docker/service-start.sh $REPO_DIR/docker/service-stop.sh
  echo -e "Showing working directory..."
  ls -al $REPO_DIR
fi

cd $HOME

echo -e "\n
Stack has successfully built!\n\n\
Run docker-compose with:\n\
  $ docker-compose --file $REPO_DIR/docker/docker-compose.yml build\n\
Run the systemd service with:\n\
  $ cd $REPO_DIR/docker && ./service-start.sh\n\
Stop the systemd service with:\n\
  $ cd $REPO_DIR/docker && ./service-stop.sh"
echo -e "\nAll done! Exiting..."
