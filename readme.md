# WebGoat.NET with Contrast
This is a re-implementation of the original [WebGoat project for .NET](https://github.com/rappayne/WebGoat.NET).

This web application is a learning platform that attempts to teach about
common web security flaws. It contains generic security flaws that apply to
most web applications. It also contains lessons that specifically pertain to
the .NET framework. The exercises in this app are intended to teach about 
web security attacks and how developers can overcome them.

## WARNING!
THIS WEB APPLICATION CONTAINS NUMEROUS SECURITY VULNERABILITIES 
WHICH WILL RENDER YOUR COMPUTER VERY INSECURE WHILE RUNNING! IT IS HIGHLY
RECOMMENDED TO COMPLETELY DISCONNECT YOUR COMPUTER FROM ALL NETWORKS WHILE
RUNNING!

## Google Chrome Note
Google Chrome performs filtering for reflected XSS attacks. These attacks will not work unless chrome is run with the argument `--disable-xss-auditor`.

### Contrast Instrumentation 
This repo includes the components necessary to instrument contrast Assess/Protect with this dotnet application except for the contrast_security.yaml file containing the connection strings.

Specifically modified:

1. WebGoatCore.csproj includes the Contrast.SensorsNetCore NuGet package as a dependency.
2. The docker-compose.yml includes the path to the contrast_security.yaml (not included), dotnet Core specific environment variables required (CORECLR_PROFILER_PATH_64, CORECLR_PROFILER, and CORECLR_ENABLE_PROFILING=1), and a few other specific environment variables.
3. Three other docker-compose YAMLs depending on what "environment" you're wanting to run: Development, QA, or Production.

contrast_security.yaml example:

api:<br>
&nbsp&nbspurl: https://apptwo.contrastsecurity.com/Contrast<br>
  api_key: [REDACTED<br>
  service_key: [REDACTED]<br>
  user_name: [REDACTED]<br>
application:<br>
  session_metadata: buildNumber=${BUILD_NUMBER}, committer=Steve Smith #buildNumber is inserted via Jenkins Pipeline<br>

Your contrast_security.yaml file needs to be in the root of the web application directory. It then gets copied into the Docker Container.

# Requirements

1. Docker Community Edition
2. docker-compose

When built, the Dockerfile pulls in all of the source code and builds the dotnet Core application. 

## How to build and run

### 1. Running in a Docker Container

The provided Dockerfile is compatible with both Linux and Windows containers (note from Steve: I've only run it on Linux).

To build a Docker image, execute the following command: docker-compose build

### Linux Containers

To run the `webgoatnet` Container image, execute one of the following commands:

1. Development: docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

2. QA: docker-compose -f docker-compose.yml -f docker-compose.qa.yml up -d

3. Production (this disables Assess and enables Protect): docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

WebGoat.NET should be accessible at http://ip_address:5004.


### Stopping the Docker container

To stop the `webgoat.net` container, execute the following command in the same directory as your docker-compose files: docker-compose stop 

### 2. Building with Jenkins
Included is a sample Jenkinsfile that can be used as a Jenkins Pipeline to build and run the application. 
