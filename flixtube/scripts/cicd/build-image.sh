# #
# # Builds a Docker image.
# #
# # Environment variables:
# #
# #   AZURE_CONTAINER_REGISTRY_HOSTNAME - The hostname of your container registry.
# #   IMAGE_NAME - The name of the image to build.
# #   IMAGE_VERSION - The version number to tag the images with.
# #   MICROSERVICE_DIRECTORY - The directory from which to build the image.
# #
# # Usage:
# #
# #       ./scripts/cicd/build-image.sh
# #

# set -u # or set -o nounset
# : "$AZURE_CONTAINER_REGISTRY_HOSTNAME"
# : "$IMAGE_NAME"
# : "$IMAGE_VERSION"
# : "$MICROSERVICE_DIRECTORY"

# docker build -t $AZURE_CONTAINER_REGISTRY_HOSTNAME/$IMAGE_NAME:$IMAGE_VERSION --file ./$MICROSERVICE_DIRECTORY/Dockerfile-prod ./$MICROSERVICE_DIRECTORY






#
# Builds a Docker image.
#
# Environment variables:
#
#   CONTAINER_REGISTRY__IP - The IP address of the Gitea container registry.
#   CONTAINER_REGISTRY__PORT - The Port of the Gitea container registry.
#   CONTAINER_REGISTRY_ORGANIZATION - The Gitea organization.
#   CONTAINER_REGISTRY_REPOSITORY - The Gitea repository.
#   CONTAINER_REGISTRY_USERNAME - The Gitea username
#   CONTAINER_REGISTRY_PASSWORD - The Gitea password
#   IMAGE_NAME - The name of the image to build.
#   IMAGE_VERSION - The version number to tag the images with.
#   MICROSERVICE_DIRECTORY - The directory from which to build the image.
#
#   AZURE_CONTAINER_REGISTRY_HOSTNAME - The hostname of your container registry.
#   IMAGE_NAME - The name of the image to build.
#   IMAGE_VERSION - The version number to tag the images with.
#   MICROSERVICE_DIRECTORY - The directory from which to build the image.
#
# Usage:
#
#       ./scripts/cicd/build-image.sh
#

# : "$AZURE_CONTAINER_REGISTRY_HOSTNAME"
# : "$IMAGE_NAME"
# : "$IMAGE_VERSION"
# : "$MICROSERVICE_DIRECTORY"

set -u # or set -o nounset
: "$CONTAINER_REGISTRY_IP"
: "$CONTAINER_REGISTRY_PORT"
: "$CONTAINER_REGISTRY_ORGANIZATION"
: "$CONTAINER_REGISTRY_REPOSITORY"
: "$CONTAINER_REGISTRY_USERNAME"
: "$CONTAINER_REGISTRY_PASSWORD"
: "$IMAGE_NAME"
: "$IMAGE_VERSION"
: "$MICROSERVICE_DIRECTORY"

#docker build -t $AZURE_CONTAINER_REGISTRY_HOSTNAME/$IMAGE_NAME:$IMAGE_VERSION --file ./$MICROSERVICE_DIRECTORY/Dockerfile-prod ./$MICROSERVICE_DIRECTORY
# docker build -t $GITEA_CONTAINER_REGISTRY_IP:$GITEA_CONTAINER_REGISTRY_PORT/$GITEA_ORGANIZATION/$IMAGE_NAME:$IMAGE_VERSION --file ./$MICROSERVICE_DIRECTORY/Dockerfile-prod ./$MICROSERVICE_DIRECTORY
docker build -t $CONTAINER_REGISTRY_IP:$CONTAINER_REGISTRY_PORT/$CONTAINER_REGISTRY_ORGANIZATION/$CONTAINER_REGISTRY_REPOSITORY/$IMAGE_NAME:$IMAGE_VERSION --file ./$MICROSERVICE_DIRECTORY/Dockerfile-prod ./$MICROSERVICE_DIRECTORY