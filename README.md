# dotnetcoredev
Dockerfile for creating a container including .NET Core development environment w/ VS Code

After creating the container, run this command from Linux to start VSCode inside the container.

docker run -v $HOME/Projects:/home/appuser/Projects --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" dotnetcoredev

NOTES:
1. Create "Projects" folder before running the command to make it writable.
2. appuser id (1001 in the dockerfile) must be the same id for logged in user.
