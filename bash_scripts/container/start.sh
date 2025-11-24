#!/usr/bin/env bash
# ------------------------------------------------------------
# First-run setup script for ROS 2 development container
# ------------------------------------------------------------

TOTAL_SLEEP_TIME="${1:-infinity}"   # Optional arg (defaults to infinity)
MARKER_FILE="$HOME/.ros2_first_run_done"

ls -a "$HOME"

echo -e "\n\n\nSourcing /opt/ros/humble/setup.bash\n"
source /opt/ros/humble/setup.bash


echo -e "\n\n\nSet working directory to /home/ros/ros2_ws\n"
[ -d "$HOME/ros2_ws" ] && cd "$HOME/ros2_ws"


if [ ! -f "$MARKER_FILE" ]; then
    echo -e "\n\n\nRunning apt update\n"
    sudo apt-get update

    echo -e "\n\n\nRunning ROSDep update and install\n"
    rosdep update
    rosdep install --from-paths src --ignore-src -r -y

    echo -e "\n\n\nBuilding Colcon Workspace at /home/ros/ros2_ws\n"
    colcon build --symlink-install

    echo -e "\n\n\nMarking first run complete\n"
    touch "$MARKER_FILE"
else
    echo -e "\n\n\nFirst run already completed — skipping setup steps\n"
fi


echo -e "\n\n\nSourcing built workspace\n"
[ -f "$HOME/ros2_ws/install/setup.bash" ] && source "$HOME/ros2_ws/install/setup.bash"


echo -e "\n\n\nCustomise ros logger\n"
export RCUTILS_CONSOLE_OUTPUT_FORMAT="{severity}: {message}"
export RCUTILS_COLORIZED_OUTPUT=1


if [ "$AUTO_LAUNCH_TMULE" = "true" ]; then
    echo -e "\n\n\nLaunching TMULE (conditional)\n"
    if [ -f "$TMULE_FILE" ]; then
        tmule -c "$TMULE_FILE" launch
    else
        echo "\$TMULE_FILE not found"
    fi
fi


echo -e "\n\n\n######################################"
echo -e "Start script completed."
echo -e "Container will continue running for: ${TOTAL_SLEEP_TIME}s"
if [ "${TOTAL_SLEEP_TIME}" != "infinity" ]; then
    END_TIME=$(date --date="now + ${TOTAL_SLEEP_TIME} seconds" +"%Y-%m-%d %H:%M:%S")
    echo -e "Sleep will end at: ${END_TIME}"
else
    echo -e "Sleep will end: never (infinity)"
fi
echo -e "Open a new terminal and connect with:"
echo -e "            _attach"
echo -e "############################################\n"

sleep "${TOTAL_SLEEP_TIME}"


if [ "$AUTO_LAUNCH_TMULE" = "true" ]; then
    echo -e "\n\n\nBeginning Termination\n"
    if [ -f "$TMULE_FILE" ]; then
        tmule -c "$TMULE_FILE" terminate
    fi
fi

exec sleep "1"
