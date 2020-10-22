FROM debian:bullseye as intermediate


RUN apt-get update -qy && \
  apt-get install dialog apt-utils wget gpg --reinstall ca-certificates -qy

#Download clang 
RUN echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster-11 main" >> /etc/apt/sources.list
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update -qy && \
  apt-get install -yq build-essential cmake git \
  libfontconfig1 libdbus-1-3 libx11-xcb1 libxrender1 libxkbcommon-x11-0 \
  libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 \
  libxtst6 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0  \
  libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 \
  vim python3-pip cmake bash-completion curl \
  clang-10 clang-tools-10 clang-10-doc libclang-common-10-dev libclang-10-dev libclang1-10 \
  clang-format-10 python3-clang-10 clangd-10 lldb-10 lld-10

ARG INSTALL_DIR=/root
# display content on xvfb

WORKDIR $INSTALL_DIR

# Download / install Qt
RUN mkdir -p /root/.local/share/Qt
COPY qtaccount.ini /root/.local/share/Qt/
COPY qt_installer.qs /root/
ENV QT_QPA_PLATFORM=minimal
ARG QT=qt-unified-linux-x64-online.run
RUN curl -sL --retry 10 --retry-delay 10 -o /root/$QT https://download.qt.io/official_releases/online_installers/$QT
RUN chmod +x /root/$QT
RUN /root/$QT --verbose --script qt_installer.qs LINUX=true
RUN rm -rf /root/Qt/Examples && rm -rf /root/Qt/Docs && rm -rf /root/Qt/Tools && rm -f /root/Qt/MaintenanceTool.*

