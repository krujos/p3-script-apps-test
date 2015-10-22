#OS Dependencies 
This repo depends on the following being in $PATH
  * bash
  * git 
  * cf cli

#Configuration 
The tools contained in this repo require the following environment variables to be set
  * CF_API api endpoint for testing (e.g. api.run.pivotal.io)
  * CF_USERNAME username to login with 
  * CF_PASSWORD password for above user
  * CF_APPS_DOMAIN url for the apps domain (e. cfapps.io)

#Requrements 
  This script will atempt to create an org an space to perform it's testing in. Ensure
that CF_USER has sufficent permissions to perform these tasks.
  



