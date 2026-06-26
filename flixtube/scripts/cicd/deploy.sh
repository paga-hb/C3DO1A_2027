# #
# # Deploys a microservice to Kubernetes.
# #
# # Assumes the image has already been built and published to the container registry.
# #
# # Environment variables:
# #
# #   AZURE_CONTAINER_REGISTRY_HOSTNAME - The hostname of your container registry.
# #   MICROSERVICE_NAME - The name of the microservice to deploy.
# #   IMAGE_VERSION - The version of the microservice being deployed.
# #   AZURE_STORAGE_ACCOUNT_NAME - The name of your Azure Storage account.
# #   AZURE_STORAGE_ACCOUNT_KEY - The access key for you Azure Storage account.
# #
# # Usage:
# #
# #   ./scripts/cicd/deploy.sh
# #

# set -u # or set -o nounset
# : "$AZURE_CONTAINER_REGISTRY_HOSTNAME"
# : "$MICROSERVICE_NAME"
# : "$IMAGE_NAME"
# : "$IMAGE_VERSION"
# : "$AZURE_STORAGE_ACCOUNT_NAME"
# : "$AZURE_STORAGE_ACCOUNT_KEY"

# envsubst < ./scripts/cicd/${MICROSERVICE_NAME}.yaml | kubectl apply -f -





#
# Deploys a microservice to Kubernetes.
#
# Assumes the image has already been built and published to the container registry.
#
# Environment variables:
#
#   CONTAINER_REGISTRY_IP - The IP address of the Gitea container registry.
#   CONTAINER_REGISTRY_PORT - The Port of the Gitea container registry.
#   CONTAINER_REGISTRY_ORGANIZATION - The Gitea organization.
#   CONTAINER_REGISTRY_PASSWORD - The Gitea password.
#
#   AZURE_CONTAINER_REGISTRY_HOSTNAME - The hostname of your container registry.
#   MICROSERVICE_NAME - The name of the microservice to deploy.
#   IMAGE_VERSION - The version of the microservice being deployed.
#   AZURE_STORAGE_ACCOUNT_NAME - The name of your Azure Storage account.
#   AZURE_STORAGE_ACCOUNT_KEY - The access key for you Azure Storage account.
#
# Usage:
#
#   ./scripts/cicd/deploy.sh
#

# : "$AZURE_CONTAINER_REGISTRY_HOSTNAME"
# : "$MICROSERVICE_NAME"
# : "$IMAGE_NAME"
# : "$IMAGE_VERSION"
# : "$AZURE_STORAGE_ACCOUNT_NAME"
# : "$AZURE_STORAGE_ACCOUNT_KEY"

set -u # or set -o nounset
: "$MICROSERVICE_NAME"

envsubst < ./scripts/cicd/${MICROSERVICE_NAME}.yaml | kubectl apply -f -