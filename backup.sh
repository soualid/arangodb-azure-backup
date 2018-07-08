#!/bin/bash
set -euo pipefail
baseDirectory=/data/backups
suffix=`date +%Y%m%d-%H%M`-$ARANGODB_DATABASE
outputDirectory=$baseDirectory/dump-$suffix
outputFilename=backup-$suffix.tar.gz
outputFile=$baseDirectory/$outputFilename
outputDirectory=$baseDirectory/dump-$suffix
echo Starting dump to $outputDirectory
arangodump --server.database $ARANGODB_DATABASE --server.endpoint $ARANGODB_ENDPOINT --server.username $ARANGODB_USERNAME --server.password $ARANGODB_PASSWORD --output-directory $outputDirectory
echo Starting compression to $outputFile
tar cvfz $outputFile $outputDirectory
echo Starting transfert to Azure storage
azure storage blob upload $outputFile $AZURE_CONTAINER $outputFilename -a $AZURE_ACCOUNT_NAME -k $AZURE_ACCOUNT_KEY
echo Cleaning up
echo rm -rf $outputFile
rm -rf $outputFile
echo rm -rf $outputDirectory
rm -rf $outputDirectory
echo Finished
