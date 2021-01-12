FROM maven AS build_img
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean package


FROM openjdk:7-jre
COPY --from=build_img /usr/src/app/bin /javabin
COPY ./permission.sh /javabin/permission.sh
WORKDIR /javabin

RUN ["chmod", "+x", "/javabin/permission.sh"]
RUN /javabin/permission.sh

# RUN ["find . -type f -exec chmod 755 {} \"]

# ENTRYPOINT [ "java", "-jar", "/javabin/POCDriver.jar" ]
