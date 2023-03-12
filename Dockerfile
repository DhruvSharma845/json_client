FROM gcc:12
LABEL author dhrsharm
LABEL version "1.0.0"


# Installing cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.26.0-rc6/cmake-3.26.0-rc6-linux-x86_64.sh \
      -q -O /tmp/cmake-install.sh \
      && chmod u+x /tmp/cmake-install.sh \
      && mkdir /usr/bin/cmake \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
      && rm /tmp/cmake-install.sh

ENV PATH="/usr/bin/cmake/bin:${PATH}"

# Installing openssh for incoming connections for debugging
RUN apt-get update \
&& apt-get -y dist-upgrade \
&& apt-get install -y openssh-server rsync sudo git zip gdb gdbserver

# configure SSH for communication with Visual Studio 
RUN mkdir -p /var/run/sshd

RUN echo 'root:root' | chpasswd \
    && sed -i -E 's/#\s*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    ssh-keygen -A

RUN mkdir -p /json_client

WORKDIR /json_client

EXPOSE 2000
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

# Build
# docker build -t json_client_build .

# Run
# docker run -it -v /Users/dhrsharm/Documents/cpp_open_source/json_client:/json_client xmlfm-build-linux /bin/bash
# docker run -d -v /Users/dhrsharm/Documents/cpp_open_source/json_client:/json_client -p 2233:22 -p 2033:2000 --privileged --security-opt seccomp:unconfined --name json_client_run json_client_build