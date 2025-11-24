# Configure from template
```
> docker-compose.yaml
replace the service name, image name, and containter name with your own appropriate names
also set your ROS_DOMAIN_ID to match your host machine
also set any ros2 packages in the workspace to mount

> Dockerfile
set any COPY commands to copy in the default packages for use with image building
the docker compose volume mounts can override these for ease of development
add any lines to clone packages internally which are not in your workspace already

> docker_functions.sh
replace the _attach function name with an appropriately named function
and add a source to this file at the end of your ~/.bashrc

> start.sh
add the printout of this new function name at the end of your start.sh script
```

# Launch container
```sh
cd docker
docker compose up
```

# Attach to running container
```
source bash_scripts/host/docker_functions.sh
_attach
```

