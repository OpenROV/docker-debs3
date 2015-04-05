docker-debs3
---
This is a basic debian image with debs3 and the gnupg files needed for signing the debian packages.
debs3 is a light weight command-line for managing a Debian repository hosted on Amazon S3.

Latest is pinned at the version 7.1 ([commit 26bf2096207af0bf2779556dd03af70197850fa7](https://github.com/BrianAdams/deb-s3/commit/26bf2096207af0bf2779556dd03af70197850fa7)) of a fork.

Assuming you have installed the AWS CLI, the AWS keys can be loaded in to environmental variables using
`. $AWS_CREDENTIAL_FILE`

*delete a particular package*
```
docker run -t --rm -e HOME=/root -e AWS_ACCESS_KEY_ID=$AWSAccessKeyId -e AWS_SECRET_ACCESS_KEY=$AWSSecretKey openrov/debs3 delete <package name> --arch <architecture> --bucket <S3 bucket> --codename <stable/testing/development etc> --component= <component> --versions <list of versions to remove>
```
*sign a debian package*
```
docker run -t -rm \
	-v ($pwd)/gnupg/:/root/.gnupg \
	-v $OUTPUT_DIR/packages:/tmp/packages \
	-v ${GPG_PASSPHRASE_FILE}:/root/passphrase.txt \
	-e HOME=/root \
    --entrypoint dpkg-sig openrov/debs3 \
	   -k $KEYID \
	   -g "--passphrase-file /root/passphrase.txt" \
	   -s openrov \
		/tmp/packages/<package_file(s)>.deb

```
