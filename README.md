# Welcome to Parts Manager PLM
Parts Management done right, this is fork of the taack-plm system. It includes alot of features and function that could not be included in that system. It made with the intent of a fully functional multi user PLM sytem

The freecad work bench and server and no longer compatible with taack-plm 

See the freecad work bench here

https://github.com/redshift2/part-manager-plm_for_freecad

# Server installation (Linux/Mac)
o
This system is composed of 6 sub modules

**Main server module**   https://github.com/redshift2/PM_module_intranet

**PLM module**           https://github.com/redshift2/Part-Manager_PLM

**User manager module**  https://github.com/redshift2/PM_module_user_management

**Global Workspace Manager** https://github.com/redshift2/PM_module_workspace 

**Material Library** https://github.com/redshift2/PM_module_materials

**Server Admin** https://github.com/redshift2/PM_module_server-admin

**Advanced 3d Viewer** https://github.com/redshift2/PM_module_advanced_3d_viewer

There is also remote worker module that can be installed remote or local servers
https://github.com/redshift2/Part-Manager_Remote_worker

## Build From Source
Download the build script for this repo
run the script
```bash
sh build_plm.sh
```
after that you should have a server.0-6.jar in your directory. From there you can decide to run the server locally or build the docker container

## Bare Metal Installation

Download the server
```bash
$ wget https://github.com/redshift2/Part-Manager_PLM/releases/download/v4.1/server-0.6.jar
```

Check Java version > 25:
```bash
$ java -fullversion
openjdk full version "25.0.1"
```

Launch it:
```bash
$ java -jar server-0.6.jar
```


## Docker
This assumes that you have a working docker installation, see this web page for docker installation https://docs.docker.com/engine/install/

Download the ***docker-compose.yml*** file or copy it from below and adjust the paths and port to suit your needs
```yaml
services:
  base:
    build:
      context: .
      dockerfile_inline: |
        FROM eclipse-temurin:25
        RUN mkdir /opt/app
        RUN mkdir /database
        RUN touch /usr/bin/dot
        RUN touch /usr/bin/convert
        RUN chmod +x /usr/bin/dot
        RUN chmod +x /usr/bin/convert
        COPY server-0.6.jar /opt/app
        CMD ["sh", "-c", "java -Dgrails.env=production -DdataSource.url='jdbc:h2:/database/taack.db;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE' -Dgrails.controllers.upload.maxFileSize=$${MAX_UPLOAD_SIZE} -Dgrails.controllers.upload.maxRequestSize=$${MAX_UPLOAD_SIZE} -Dgrails.serverURL=$${HOST_URL}} -jar /opt/app/server-0.6.jar"] 

    container_name: taack-plm
    restart: unless-stopped
    ports:
      - 9442:9442
    environment:
      MAX_UPLOAD_SIZE: 1073741824  #set the maximum upload file size in bytes (This is set to 1gb)
      HOST_URL: http://<server ip>:<port>   #set the server domain name. Port is not required if using a reverse proxy
                                            #examples https://plm.server.org http://plmserver.org:9442 or 192.168.1.20:9442
      SERVER_ADMIN_JOB_STORAGE: /jobs
      SERVER_ADMIN_SCRIPT_STORAGE: /scripts
      PLM_PREVIEW_STORAGE: /plm-previews
      PM_OIDC_PUBLIC_URL: "https://your.oauth.serveprovider.org"  #replace with your provider
      PM_OIDC_SECRET_KEY: "xxxx"  # to get your secret key run 
                                  # openssl rand -base64 32

    volumes:
      - ./partsmanager-plm/database:/database
      - ./partsmanager-plm/vault:/root/intranetFilesDev
      - ./partsmanager-plm/jobs:/jobs
      - ./partsmanager-plm/scripts:/scripts
      - ./partsmanager-plm/plm-previews:/plm-previews

```

Download the server to the same location as the docker-compose.yml file
```bash
$ wget https://github.com/redshift2/Part-Manager_PLM/releases/download/v4.1/server-0.6.jar
```
Build the docker image
```bash
$ sudo docker compose build
```

Deloy the container 
```bash
$ sudo docker compose up -d
```


# You are done
access the server [http://localhost:9442/](http://localhost:9442/), connect with `admin` / `ChangeIt` credentials.


<img width="1890" height="540" alt="image" src="https://github.com/user-attachments/assets/c6b2bd74-0dd9-4d0b-aef4-1f0a5018df29" />


<img width="1915" height="866" alt="image" src="https://github.com/user-attachments/assets/5c6cea78-662a-4e31-971b-228c0c52b515" />

<img width="1915" height="866" alt="image" src="https://github.com/user-attachments/assets/d840bdba-4f6b-4a96-ac08-d8ba3e086f17" />

<img width="1915" height="866" alt="image" src="https://github.com/user-attachments/assets/22764b9f-87ae-4c98-be1c-07ee9cfc6618" />

<img width="1915" height="866" alt="image" src="https://github.com/user-attachments/assets/bc11a937-6ac8-4d04-b7d1-4cc73e9809f5" />

<img width="1913" height="963" alt="image" src="https://github.com/user-attachments/assets/8d7342ce-891b-45dd-b58d-a624ae4f04b0" />
