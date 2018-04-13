# Arango DB azure backup

A simple utility to backup and ArangoDB database to Azure storage.

Usage:

```
docker run tat2bu/arangodb-azure-backup \
  -v /host/backup/directory:/data/backups \
  -e ARANGODB_ENDPOINT=tcp://db.example.com:8529 \
  -e ARANGODB_USERNAME=root \
  -e ARANGODB_PASSWORD='example' \
  -e AZURE_CONTAINER=example \
  -e AZURE_ACCOUNT_NAME=example \
  -e AZURE_ACCOUNT_KEY='xxx'
```