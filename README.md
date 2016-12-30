[![Docker Repository on Quay](https://quay.io/repository/gluu/gluu/status "Docker Repository on Quay")](https://quay.io/repository/gluu/gluu)
# Gluu Docker Image
**NOTE: This is just a Work-In-Progress snapshot and should be used by caution**

## Preface
Altough Gluu has officialy Docker Edition Workflows it is too complex and requires many requirements.  
This distro simply uses official Ubuntu installion steps and then *Jailbreaks* package container into original container.  
This reduces totoal image size & makes it much easier to maintain and setup...  

## Onbuild image
Distribution currently requires onbuild image as setup process and container changes are so complex.
To get started fist pull base image:
```bash 
# Pull from docker hub
docker pull pooya/gluu

# Or if you prefer quay...
docker pull quay.io/gluu/gluu
```
