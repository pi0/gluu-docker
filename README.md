<p align="center"><img src="https://www.gluu.org/wp-content/themes/gluu/images/gl.png"></p>

# Gluu C.E Docker

## Quick Start

```bash
# clone repo
git clone https://github.com/pi0/gluu-docker sso
cd sso

# edit env file
[ ! -f env ] && cp -rv env.example env
$EDITOR env 

# Setup
docker-compose run --rm ldap setup

# Compose up!
docker-compose up -d

# View default password
cat data/gluu_install/setup.properties|grep ldapPass=
```

## Important Notes
Only the standard components (identity, oxauth, ldap) are currently supported and available. Please refer to the docker-compose file for details. 

You currently *MUST* provide your own SSL terminating endpoint, i.e. a reverse proxy relaying requests to the gluu proxy.

```
SSL termination endpoint (443) => gluu proxy (80) => Identity Server with invalid cert (443)
```
