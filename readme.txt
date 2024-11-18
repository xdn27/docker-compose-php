Porting PHP executable from docker to host
Make file bin/php

#!/bin/bash
docker run --rm -v $(pwd):/var/www/html --network host docker-local-phplocal php "$@"

Run
chmod +x bin/php

Check
bin/php -v


Install caddy root CE in host
Run scripts/update_cert_fedora.sh
Run scripts/update_cert_ubuntu.sh


Update host file
Run scripts/update_hosts.sh
