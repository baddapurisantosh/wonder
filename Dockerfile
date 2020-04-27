FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y curl unzip zip software-properties-common lib32stdc++6 lib32z1
RUN add-apt-repository ppa:webupd8team/java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update && apt-get install -y maven oracle-java8-installer
ENV TZ=America/New_York
ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
RUN curl -s https://get.sdkman.io | bash
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install gradle 4.4"
RUN mkdir -p /opt/android
ADD https://dl.google.com/android/repository/tools_r25.2.3-linux.zip /opt/android
WORKDIR /opt/android
RUN unzip tools_r25.2.3-linux.zip
ENV ANDROID_HOME=/opt/android
WORKDIR /opt/android/tools
RUN echo y | ./android update sdk --no-ui --filter build-tools-23.0.0,android-23,extra-android-m2repository
RUN echo y | ./android update sdk --no-ui --filter build-tools-24.0.0,android-24,extra-android-m2repository
RUN echo y | ./android update sdk --no-ui --filter build-tools-25.0.0,android-25,extra-android-m2repository


RUN yes | bin/sdkmanager --update


RUN mkdir /app
WORKDIR /app
CMD /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && gradle assembleRelease"
