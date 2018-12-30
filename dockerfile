FROM ubuntu:latest
RUN apt-get update -y && apt-get upgrade -y

#Dependencies for .NET Core installation
RUN apt-get install -y \
    libunwind8 \
    libicu60 \
    ca-certificates \
    software-properties-common

#.NET Core SDK installation
ADD https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb /tmp
RUN cd /tmp && dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb 
RUN add-apt-repository universe
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y dotnet-sdk-2.2

#Dependencies for VSCode
RUN apt-get install -y \
    libnotify4 \
    libnss3 \
    gnupg \
    libxkbfile1 \
    libgconf-2-4 \
    libsecret-1-0 \ 
    libgtk-3-0 \
    libxss1 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module

#VSCode installation
ADD https://go.microsoft.com/fwlink/?LinkID=760868 /tmp/vscode.deb
RUN cd /tmp && dpkg -i ./vscode.deb && rm vscode.deb

#Add non-root user
RUN useradd -ms /bin/bash -u 1000 appuser
USER appuser
WORKDIR /home/appuser

#Install C# extension
RUN code --install-extension ms-vscode.csharp

#Start VSCode
ENTRYPOINT ["code","--verbose","/home/appuser/Projects"]
