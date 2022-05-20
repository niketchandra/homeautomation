
read -p "Enter Org Name: " org
read -p "Enter Repo Name: " repo
export GHEC_TOKEN=xxx

export GENRATE_DATA={\"repositories\":[\"${repo}\"]}
CURRENT_DATE=`TZ=UTC date +%Y%m%d`

curl -H "Authorization: token ${GHEC_TOKEN}" -X POST -H "Accept: application/vnd.github.v3+json" -d ${GENRATE_DATA} https://api.github.com/orgs/${org}/migrations > value 

migration_id=$(sed '2!d' value  | sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')

sleep 3s

curl -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" https://api.github.com/orgs/$org/migrations/$migration_id |grep -E '"state": ".*"' > status

if grep -o "exported" status; then data="exported"; else data="pending"; fi

#echo $data

until [ "$data" == "exported"  ];

do
echo -e "\nGATHERING INFORMATION\n"

curl -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" https://api.github.com/orgs/$org/migrations/$migration_id | grep -E '"state": ".*"'

sleep 30s

sudo curl -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" -L -o ${org}-${repo}-$CURRENT_DATE.tar.gz https://api.github.com/orgs/$org/migrations/$migration_id/archive


sleep 10s
curl -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" https://api.github.com/orgs/$org/migrations/$migration_id | grep -E '"state": ".*"' > status

if grep -o "exported" status; 
then data="exported" 
	echo -e "\nPLEASE CHECK FILE SIZE HERE >>> " $(du -sh $org-$repo-$CURRENT_DATE.tar.gz)
	echo -e "\nIMPOERTANT NOTE:\n IF YOU SEE FILE SIZE 4.0K, THEN ABORT THE SCRIPT USING ctrl+c and RERUN THE SCRIPT\n"
        echo -e  "ALL SET TO UPLOAD TO AWS S3"
else data="pending" echo -e "\nPLEASE BE PATIENT, IT IS TAKING LITTLE LONGER THEN EXPECTED, RE-TRYING \n"; 
fi

done

echo -e "Tarball is downloded on your local system\n"

read -p "Do you want to Upload Repo on AWS S3 repo (y|n) : " response

echo $response

if [ "$response" == yes -o "$response" == y ]
then

echo "S3 Uploading process start"

echo -e  "Please Enter AWS KEY, AWS SECRET, TOKEN";
echo -e "\nAWS SECRET and AWS TOKEN will not be visible in-front of the screen, do right click to paste then press enter\n"

read -p "Enter AWS key: " key
read -sp "Enter Secret: " secret
read -sp "Enter Temp. Token: " token

export AWS_ACCESS_KEY_ID="${key}"
export AWS_SECRET_ACCESS_KEY="${secret}"
export AWS_SESSION_TOKEN="${token}"

s3url="s3://github-repository-archive-us-east-1"

aws s3 mv ${org}-${repo}-$CURRENT_DATE.tar.gz  $s3url

aws s3 ls $s3url

echo -e  "\nPLEASE CHECK YOUR FILE IN THE LIST ABOVE\n" 

else 
	echo -e "S3 Uploading process skipped by user\n"
	echo "Your Repo is available on your current directory"
fi

read -p "Do you want to Delete Repo from Github (y|n) : " Deleteit

if [ "$Deleteit" == yes -o "$Deleteit" == y ]
then
curl -X DELETE -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GHEC_TOKEN}" https://api.github.com/repos/$org/$repo;
echo "Your repo is deleted successfully";
else
echo "Thank you! your repo is migrated successfully";
fi


echo "THANKS, HAVE A NICE DAY"
