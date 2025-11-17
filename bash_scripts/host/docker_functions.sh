# Attach to the running dev container
function _attach () {
    cd $HOME/docker_workspaces/_/docker
    xhost +local:docker
    docker compose exec ros2_container_service bash -l
}
