# archeology_path_planning

Launch container
```sh
cd docker
docker compose up
```

Attach to running container
```
source bash_scripts/host/docker_functions.sh
ahndas_attach
```

Download data from [https://archaeologydataservice.ac.uk/archives/view/romancities_ahrc_2019/downloads.cfm?group=1727](Falerii Novi Field 5) so the raw data is in `./data/raw_bkp` and the slice data is in `./data/slices`. The anaysis is setup to use the information provided in the csv file (hardcoded), this is to be made more modular going forward.
