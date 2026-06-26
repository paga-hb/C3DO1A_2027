# #
# # Publishes a Docker image.
# #
# # Environment variables:
# #
# #   AZURE_CONTAINER_REGISTRY_HOSTNAME - The hostname of your container registry.
# #   AZURE_CONTAINER_REGISTRY_USERNAME - User name for your container registry.
# #   AZURE_CONTAINER_REGISTRY_PASSWORD - Password for your container registry.
# #   IMAGE_NAME - The name of the image.
# #   IMAGE_VERSION - The image's version number (tag).
# #
# # Usage:
# #
# #       ./scripts/cicd/push-image.sh
# #

# set -u # or set -o nounset
# : "$AZURE_CONTAINER_REGISTRY_HOSTNAME"
# : "$AZURE_CONTAINER_REGISTRY_USERNAME"
# : "$AZURE_CONTAINER_REGISTRY_PASSWORD"
# : "$IMAGE_NAME"
# : "$IMAGE_VERSION"

# echo $AZURE_CONTAINER_REGISTRY_PASSWORD | docker login $AZURE_CONTAINER_REGISTRY_HOSTNAME --username $AZURE_CONTAINER_REGISTRY_USERNAME --password-stdin
# docker push $AZURE_CONTAINER_REGISTRY_HOSTNAME/$IMAGE_NAME:$IMAGE_VERSION





#
# Publishes a Docker image.
#
# Environment variables:
#
#   CONTAINER_REGISTRY_IP - The IP address of the Gitea container registry.
#   CONTAINER_REGISTRY_PORT - The Port of the Gitea container registry.
#   CONTAINER_REGISTRY_ORGANIZATION - The Gitea organization.
#   CONTAINER_REGISTRY_REPOSITORY - The Gitea repository.
#   CONTAINER_REGISTRY_USERNAME - The Gitea username.
#   CONTAINER_REGISTRY_PASSWORD - The Gitea password.
#   IMAGE_NAME - The name of the image.
#   IMAGE_VERSION - The image's version number (tag).
#
#   AZURE_CONTAINER_REGISTRY_HOSTNAME - The hostname of your container registry.
#   AZURE_CONTAINER_REGISTRY_USERNAME - User name for your container registry.
#   AZURE_CONTAINER_REGISTRY_PASSWORD - Password for your container registry.
#   IMAGE_NAME - The name of the image.
#   IMAGE_VERSION - The image's version number (tag).
#
# Usage:
#
#       ./scripts/cicd/push-image.sh
#

# : "$AZURE_CONTAINER_REGISTRY_HOSTNAME"
# : "$AZURE_CONTAINER_REGISTRY_USERNAME"
# : "$AZURE_CONTAINER_REGISTRY_PASSWORD"
# : "$IMAGE_NAME"
# : "$IMAGE_VERSION"

set -u # or set -o nounset
: "$CONTAINER_REGISTRY_IP"
: "$CONTAINER_REGISTRY_PORT"
: "$CONTAINER_REGISTRY_ORGANIZATION"
: "$CONTAINER_REGISTRY_REPOSITORY"
: "$CONTAINER_REGISTRY_USERNAME"
: "$CONTAINER_REGISTRY_PASSWORD"
: "$IMAGE_NAME"
: "$IMAGE_VERSION"

# echo $AZURE_CONTAINER_REGISTRY_PASSWORD | docker login $AZURE_CONTAINER_REGISTRY_HOSTNAME --username $AZURE_CONTAINER_REGISTRY_USERNAME --password-stdin
# docker push $AZURE_CONTAINER_REGISTRY_HOSTNAME/$IMAGE_NAME:$IMAGE_VERSION

#"172.30.30.202:3000"
# sudo mkdir -p /etc/docker
# sudo tee /etc/docker/daemon.json >/dev/null << 'EOF'
# {
#   "insecure-registries": [    
#     "$GITEA_CONTAINER_REGISTRY_IP:$GITEA_CONTAINER_REGISTRY_PORT"
#   ]
# }
# EOF
# sudo systemctl restart docker

echo $CONTAINER_REGISTRY_PASSWORD | docker login $CONTAINER_REGISTRY_IP:$CONTAINER_REGISTRY_PORT --username $CONTAINER_REGISTRY_USERNAME --password-stdin
#docker push $GITEA_CONTAINER_REGISTRY_IP:$GITEA_CONTAINER_REGISTRY_PORT/$GITEA_ORGANIZATION/$GITEA_REPO/$IMAGE_NAME:$IMAGE_VERSION
docker push $CONTAINER_REGISTRY_IP:$CONTAINER_REGISTRY_PORT/$CONTAINER_REGISTRY_ORGANIZATION/$CONTAINER_REGISTRY_REPOSITORY/$IMAGE_NAME:$IMAGE_VERSION
