#!/bin/sh

# Create Rabbitmq user
( rabbitmqctl wait --timeout 60 $RABBITMQ_PID_FILE ; \
rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD 123456>/dev/null ; \
rabbitmqctl set_user_tags $RABBITMQ_USER administrator ; \
rabbitmqctl sudo rabbitmqctl add_vhost One ; \
rabbitmqctl sudo rabbitmqctl add_vhost Two ; \
rabbitmqctl set_permissions --vhost / $RABBITMQ_USER  ".*" ".*" ".*" ; \
rabbitmqctl set_permissions --vhost One $RABBITMQ_USER  ".*" ".*" ".*" ; \

rabbitmqctl add_user $RABBITMQ_USER_Two $RABBITMQ_PASSWORD 123456>/dev/null ; \
rabbitmqctl set_user_tags $RABBITMQ_USER administrator ; \
rabbitmqctl set_permissions --vhost / $RABBITMQ_USER_Two  ".*" ".*" ".*" ; \
rabbitmqctl set_permissions --vhost Two $RABBITMQ_USER_Two  ".*" ".*" ".*" ; \

echo "*** User '$RABBITMQ_USER' with password '$RABBITMQ_PASSWORD' completed. ***" ; \
echo "*** User '$RABBITMQ_USER_Two' with password '$RABBITMQ_PASSWORD' completed. ***" ; \
echo "*** Log in the WebUI at port 15672 (example: http:/localhost:15672) ***") &

# $@ is used to pass arguments to the rabbitmq-server command.
# For example if you use it like this: docker run -d rabbitmq arg1 arg2,
# it will be as you run in the container rabbitmq-server arg1 arg2
rabbitmq-server $@