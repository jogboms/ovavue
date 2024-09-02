#!/bin/sh

WORKING_DIRECTORY=$(pwd)/android
ZIP_FILENAME=keys.zip

# --batch to prevent interactive command
# --yes to assume "yes" for questions
gpg --quiet --batch --yes --decrypt --passphrase="$ANDROID_KEYS_SECRET_PASSPHRASE" \
    --output $WORKING_DIRECTORY/$ZIP_FILENAME $WORKING_DIRECTORY/$ZIP_FILENAME.gpg \
    && cd $WORKING_DIRECTORY \
    && jar xvf $ZIP_FILENAME \
    && cd -
