# #
# # Tests a microservice.
# #
# # Environment variables:
# #
# #   NAME - The name of the microservice to test.
# #   CONTAINER_NAME - The container's name.
# #
# # Usage:
# #
# #       ./scripts/cicd/test.sh
# #

# set -u # or set -o nounset
# : "$NAME"
# : "$CONTAINER_NAME"

# envsubst < ./compose/docker-compose-$NAME-dev.yml | docker compose -f - --project-directory . up -d
# until docker exec $CONTAINER_NAME curl -f http://localhost:80/health; do
#   echo "Waiting for the service to be ready..."
#   sleep 5
# done
# docker exec $CONTAINER_NAME dotnet test
# TEST_EXIT_CODE=$?

# # Copy screenshots from Web container to host
# if [[ ${CONTAINER_NAME,,} == "web" ]]; then
#   docker cp $CONTAINER_NAME:/screenshots ./screenshots
# fi

# envsubst < ./compose/docker-compose-$NAME-dev.yml | docker compose -f - --project-directory . down
# exit $TEST_EXIT_CODE





#
# Tests a microservice.
#
# Environment variables:
#
#   NAME - The name of the microservice to test.
#   CONTAINER_NAME - The container's name.
#
# Usage:
#
#       ./scripts/cicd/test.sh
#

set -u # or set -o nounset
: "$NAME"
: "$CONTAINER_NAME"

MAX_RETRIES=300   # 300 * 5s = 1500 seconds (25 minutes)
SLEEP_SECONDS=5
COUNTER=0
FAILED_HEALTH=0
TEST_EXIT_CODE=0

envsubst < ./compose/docker-compose-$NAME-dev.yml | docker compose -f - --project-directory . up -d
until docker exec $CONTAINER_NAME curl -f http://localhost:80/health; do
  echo "Waiting for the service to be ready..."
  sleep 5
  COUNTER=$((COUNTER + 1))
  if [ "$COUNTER" -ge "$MAX_RETRIES" ]; then
    echo "Service did not become ready after $((MAX_RETRIES * SLEEP_SECONDS)) seconds."
    FAILED_HEALTH=1
    break
  fi
done

if [ "$FAILED_HEALTH" -eq 0 ]; then
  docker exec $CONTAINER_NAME dotnet test
  TEST_EXIT_CODE=$?
else
  TEST_EXIT_CODE=1  # mark as failed due to timeout
fi

# Copy screenshots from Web container to host
if [[ ${CONTAINER_NAME,,} == "web" ]]; then
  docker cp $CONTAINER_NAME:/screenshots ./screenshots
fi

envsubst < ./compose/docker-compose-$NAME-dev.yml | docker compose -f - --project-directory . down --rmi all --volumes --remove-orphans
exit $TEST_EXIT_CODE