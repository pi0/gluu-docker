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

