FROM java:7
#MAINTAINER Xavier Riley  <@xavriley>

RUN mkdir /setup
RUN echo "# Installing Maven"
RUN apt-get update && \
    apt-get -y -q install --fix-missing default-jdk maven unzip

RUN echo "# Installing Tika"
RUN mkdir install && \
			curl https://codeload.github.com/apache/tika/zip/trunk -o trunk.zip && \
			unzip trunk.zip

ADD install.sh /setup/install.sh
RUN /setup/install.sh

RUN echo "#Installing tesseract"
RUN apt-get -y -q install tesseract-ocr tesseract-ocr-deu tesseract-ocr-eng

RUN echo "# Cleaning up"
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /setup /build

EXPOSE 9998
CMD java -jar /srv/tika-server-1.*-SNAPSHOT.jar --host=0.0.0.0 --port=$PORT

