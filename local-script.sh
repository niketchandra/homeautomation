
#!/bin/bash

read -p "Enter Org Name: " org
read -p "Enter Repo Name: " repo
export GHEC_TOKEN=xxx
URL_COMMAND=curl -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json"

echo $URL_COMMAND

#echo "curl -H "Authorization: token ${GHEC_TOKEN}" -X POST -H "Accept: application/vnd.github.v3+json" -d'{"lock_repositories":true,"repositories":["$org/$repo"]}'  https://api.github.com/orgs/${org}/migrations"

#data={"lock_repositories":true,"repositories":["$repo"]}

export GENRATE_DATA={\"repositories\":[\"${repo}\"]}

echo $GENRATE_DATA


touch new_id

sudo curl -H "Authorization: token ${GHEC_TOKEN}" -X POST -H "Accept: application/vnd.github.v3+json" -d ${GENRATE_DATA} https://api.github.com/orgs/${org}/migrations > new_id

echo "step 2"

newid=$(sed '2!d' new_id  | sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')


MIGRATION_URL="https://api.github.com/orgs/3mcloud/migrations/$newid"

echo $MIGRATION_URL


echo "step 3"

sudo $URL_COMMAND https://api.github.com/orgs/$org/migrations/$newid > status2

echo "step 4"

echo "sudo $URL_COMMAND $MIGRATION_URL/archive -L -o ${org}-${repo}.tar.gz"

sudo $URL_COMMAND $MIGRATION_URL/archive -L -o ${org}-${repo}.tar.gz

echo "Exporting Data"


until [ "exported" == "$data" ]

do
touch new
curl -s -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.wyandotte-preview+json" https://api.github.com/orgs/$org/migrations/$newid | grep -E '"state": ".*"' > new

       if grep -o "exported" new; then data="exported"; else data="pending"; fi
        sleep 15s

done

echo "Status: Exported"


read -p "Do you want to delete repo (y|n) : " response

echo $response



if [ "$response" == yes -o "$response" == y ]
then
curl -X DELETE -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GHEC_TOKEN}" https://api.github.com/repos/$org/$repo;
echo "Your repo is deleted successfully";
else
echo "Thank you! your repo is migrated successfully";
fi


#                  if [ $response=y ]
#then
#       echo "Your repo is deleted successfully"
#       #curl -X DELETE -H "Accept: application/vnd.github.v3+json"  https://api.github.com/repos/$org/$repo;
#       else #[ $response=n -o $response=No -o $response=NO -o $response=N ];
#       echo "Thank you! your repo is migrated successfully"
#fi
