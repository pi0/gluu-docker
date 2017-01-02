# Gluu Docker Image
**NOTE: This is just a Work-In-Progress snapshot and should be used by caution**

## Preface
Altough Gluu has officialy Docker Edition Workflows it is too complex and has many requirements.  

## Dist descriptions

### CE (community-edition)
This distro simply uses official Ubuntu installion steps and then *jailbreaks* package container into original container.  
This reduces totoal image size & makes it much easier to maintain and setup..

### Scratch
Build scripts to make scratch images directly from rootfs.

### DE (docker-edition) 
DE based images for ubuntu 16.04 as are not officially released yet.
