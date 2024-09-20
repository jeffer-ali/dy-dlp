#!/bin/bash

# Ask for confirmation to proceed with the update
read -r -p "Do you want to update dy-dlp? [y/n] " input
case $input in
    [yY])
        # Navigate to the project directory or exit if it fails
        cd /www/wwwroot/dy-dlp || { echo "The directory does not exist."; exit 1; }

        # Pull the latest changes from the repository
        git pull

        # Activate the virtual environment
        source venv/bin/activate

        # Optionally, update Python dependencies
        pip install -r requirements.txt

        # Deactivate the virtual environment
        deactivate

        # Restart the service to apply changes
        echo "Restarting dy-dlp service"
        sudo systemctl restart dy-dlp.service
        echo "Successfully restarted all services!"
        ;;
    [nN]|*)
        echo "Exiting..."
        exit 1
        ;;
esac
