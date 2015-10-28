#!/bin/bash -x
for v in $CF_API $CF_USERNAME $CF_PASSWORD $CF_APPS_DOMAIN; do 
	if [[ -z $v ]] ; then
		>&2 echo "$v must be set!"
	fi
done

cf api $CF_API --skip-ssl-validation
cf auth $CF_USERNAME $CF_PASSWORD
cf create-org scripttests
cf create-space tests -o scripttests
cf target -o scripttests -s tests 

git clone https://github.com/pivotal-customer0/cf-hello-world-sample-apps

cd cf-hello-world-sample-apps

for d in php python node ruby static; do
	(cd $d && cf push $d -m 256m)
	if [[ $? != 0 ]]; then
		>&2 echo "Failed to push $d to $CF_API"
		exit 1
	fi

	curl $d.$CF_APPS_DOMAIN
 	if [[ $? != 0 ]]; then
		>&2 echo "Failed find $d at $d.$CF_APPS_DOMAIN"
		exit 1
	fi
done

cd ..
cf delete-org scripttests -f
rm -rf cf-hello-world-sample-apps

