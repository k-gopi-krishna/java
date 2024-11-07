# Use the official Ubuntu image as the base image for the build stage
FROM ubuntu as build

# Update the package list and install OpenJDK 17
RUN apt update && apt install -y openjdk-17-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the Java source file into the container
COPY testfile.java .

# Compile the Java source file
RUN javac testfile.java

# Use the official Eclipse Temurin JRE image as the base image for the runtime stage
FROM eclipse-temurin:17-jre-noble

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled Java class file from the build stage
COPY --from=build /app/testfile.class .

# Specify the command to run the Java application
CMD ["java", "testfile"]