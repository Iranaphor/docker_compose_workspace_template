# Configure from template
```
1. docker namings
replace 

2. attach shortcut
Replace _attach with a named function in both:
- bash_scripts/host/docker_functions.sh
- bash_scripts/container/start.sh
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

