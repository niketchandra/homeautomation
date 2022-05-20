
read -p "Enter Org Name: " org
read -p "Enter Repo Name: " repo
export GHEC_TOKEN=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

export GENRATE_DATA={\"repositories\":[\"${repo}\"]}
CURRENT_DATE=`TZ=UTC date +%Y%m%d`

BASEURL="https://api.github.com/repos/$org/$repo"
FILENAME=$org-$repo-$CURRENT_DATE.csv

#----------------------------Search-Repo---------------------------
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL > tem_exist.txt
exist=`grep -wc "node_id" tem_exist.txt`
echo $exist
if [ $exist -ne "0"  ]

then
rm tem_exist.txt
#---------------------------branches--------------------------------

curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/branches >> tem_branch.txt
BRANCH=`grep -wc "name" tem_branch.txt`
echo 'Total Branch Found: '$BRANCH
if [ $BRANCH == "0" ]
then
    echo "No Branch found"
    rm tem_branch.txt
else
  echo "----------------------------------------------" 
echo "---------------------- Total Branches Found: "${BRANCH}" -----------------" >> $FILENAME
echo "----------------------------------------------" 
echo "UPDATE BRANCHES"
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/branches >> $org-$repo-BRANCH.txt
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/branches | grep -e '"name": ".*"' -e '"protection":{".*"' >> $FILENAME
sleep 3s
echo "----------------------------------------------" >> $FILENAME
echo -e "\n" >> $FILENAME
rm tem_branch.txt
fi

#---------------------------Protected-Branches--------------------------------#

curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/branches | grep -e '"name": "*"' -e '"protected": true' >> tem_pbranch.txt
PBRANCH=`grep -wc "true" tem_pbranch.txt`
echo 'Total Protected Branch Found: '$PBRANCH

if [ $PBRANCH == "0" ]
then
    echo "No Branch found"
    rm tem_branch.txt
else
 echo "----------------------------------------------" 
echo "--------------------- Total Protected Branches Found: "${PBRANCH}" -----------------" >> $FILENAME
echo "----------------------------------------------" 
echo "UPDATE PROTECTED BRANCHES"
grep -B 1 "true" tem_pbranch.txt >> $FILENAME
grep -B 1 "true" tem_pbranch.txt > bname.txt
grep "name" bname.txt | cut -d ':' -f 2 > names.txt
grep -o '".*"' names.txt | sed 's/"//g' > newvalues.txt

file="newvalues.txt"
while IFS= read -r line
do
        printf 'curl -X GET -H "Authorization: token '${GHEC_TOKEN}'" -H "Accept: application/vnd.github.v3+json" '$BASEURL'/branches/%s/protection >> '$org-$repo-ProtectedBranch.txt' \nsleep 3s\n' >> command.sh "$line"
done <"$file"
sudo bash command.sh
echo "----------------------------------------------" >> $FILENAME
echo -e "\n" >> $FILENAME
rm bname.txt
rm names.txt
rm newvalues.txt
rm command.sh
fi
rm tem_pbranch.txt

#---------------------------collaborators--------------------------------

curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/collaborators | grep -e '"login": ".*"' >> tem_collaborators.txt
collaborators=`grep -wc "login" tem_collaborators.txt`
echo 'Total collaborators Found: '$collaborators
if [ $collaborators == "0" ]
then
    echo "No collaborators found"
    rm tem_collaborators.txt
else
  echo "----------------------------------------------" 
echo "--------------------- Total collaborators Found: "${collaborators}" -----------------" >> $FILENAME
echo "----------------------------------------------" 
echo "UPDATE collaborators"
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/collaborators >> $org-$repo-collaborators.txt
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/collaborators | grep -e '"login": ".*"' -e '"role_name": ".*"' >> $FILENAME
sleep 3s
echo "----------------------------------------------" >> $FILENAME
echo -e "\n" >> $FILENAME
rm tem_collaborators.txt
fi

#---------------------------assignees--------------------------------

curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/assignees | grep -e '"login": ".*"' >> tem_assignees.txt
assignees=`grep -wc "login" tem_assignees.txt`
echo 'Total assignees Found: '$assignees
if [ $assignees == "0" ]
then
    echo "No assignees found"
    rm tem_assignees.txt
else
  echo "----------------------------------------------" 
echo "--------------------- Total assignees Found: "${assignees}" -----------------" >> $FILENAME
echo "----------------------------------------------" 
echo "UPDATE assignees"
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/assignees >> $org-$repo-assignees.txt
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/assignees | grep -e '"login": ".*"' -e '"type": ".*"' >> $FILENAME
sleep 3s
echo "----------------------------------------------" >> $FILENAME
echo -e "\n" >> $FILENAME
rm tem_assignees.txt
fi

#---------------------------hooks--------------------------------

curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/hooks | grep -e '"test_url": ".*"' >> tem_hooks.txt
hooks=`grep -wc "test_url" tem_hooks.txt`
echo 'Total hooks Found: '$hooks
if [ $hooks == "0" ]
then
    echo "No hooks found"
    rm tem_hooks.txt
else
  echo "----------------------------------------------" 
echo "--------------------- Total Webhooks Found: "${hooks}" -----------------" >> $FILENAME
echo "----------------------------------------------" 
echo "UPDATE WEBHOOKS"
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/hooks >> $org-$repo-webhooks.txt
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/hooks | grep -e '"url": ".*"' -e '"test_url": ".*"' >> $FILENAME
sleep 3s
echo "----------------------------------------------" >> $FILENAME
echo -e "\n" >> $FILENAME
rm tem_hooks.txt
fi

#---------------------------issues--------------------------------

curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/issues | grep -e '"name": ".*"' >> tem_issues.txt
issues=`grep -wc "name" tem_issues.txt`
echo 'Total issues Found: '$issues
if [ $issues == "0" ]
then
    echo "No issues found"
    rm tem_issues.txt
else
  echo "----------------------------------------------" 
echo "--------------------- Total issues Found: "${issues}" -----------------" >> $FILENAME
echo "----------------------------------------------" 
echo "UPDATE issues"
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/issues >> $org-$repo-issues.txt
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/issues | grep -e '"name": ".*"' -e '"state": ".*"' >> $FILENAME
sleep 3s
echo "----------------------------------------------" >> $FILENAME
echo -e "\n" >> $FILENAME
rm tem_issues.txt
fi

#---------------------------keys--------------------------------

curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/keys >> tem_keys.txt
keys=`grep -wc "name" tem_keys.txt`
echo 'Total keys Found: '$keys
if [ $keys == "0" ]
then
    echo "No keys found"
    rm tem_keys.txt
else
  echo "----------------------------------------------" 
echo "--------------------- Total keys Found: "${keys}" -----------------" >> $FILENAME
echo "----------------------------------------------" 
echo "UPDATE keys"
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/keys >> $org-$repo-keys.txt
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/keys >> $FILENAME
sleep 3s
echo "----------------------------------------------" >> $FILENAME
echo -e "\n" >> $FILENAME
rm tem_keys.txt
fi

#---------------------------forks--------------------------------
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/forks | grep -e '"name": ".*"' >> tem_forks.txt
forks=`grep -wc "name" tem_forks.txt`
echo 'Total Forks Found: '$forks
if [ $forks == "0" ]
then
    echo "No forks found"
    rm tem_forks.txt
else
  echo "----------------------------------------------" 
echo "--------------------- Total forks Found: "${forks}" -----------------" >> $FILENAME
echo "----------------------------------------------" 
echo "UPDATE forks"
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/forks >> $org-$repo-forks.txt
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/forks | grep -e '"name": ".*"' >> $FILENAME
sleep 3s
echo "----------------------------------------------" >> $FILENAME
echo -e "\n" >> $FILENAME
rm tem_forks.txt
fi

#---------------------------Pages--------------------------------

curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/pages >> tem_pages.txt
pages=`grep -wc "status" tem_pages.txt`
echo 'Total Pages Found: '$pages
if [ $pages == "0" ]
then
    echo "No Pages found"
    rm tem_pages.txt
else
  echo "----------------------------------------------" 
echo "---------------------T otal pages Found: "${pages}" -----------------" >> $FILENAME
echo "----------------------------------------------" 
echo "UPDATE pages"
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/pages >> $org-$repo-pages.txt
curl -X GET -H "Authorization: token ${GHEC_TOKEN}" -H "Accept: application/vnd.github.v3+json" $BASEURL/pages | grep -e '"name": ".*"' >> $FILENAME
sleep 3s
echo "----------------------------------------------" >> $FILENAME
echo -e "\n" >> $FILENAME
rm tem_pages.txt
fi

#---------------------------DATA COMPRESSING--------------------------------

echo "Compressing Information"
tar -czvf $org-$repo-$CURRENT_DATE.tar *.txt
rm *.txt
echo "DONE --> your information is saved into file: " $FILENAME 
echo "For more details extract file: " $org-$repo-$CURRENT_DATE.tar


#---------------------------------------------------------------------------
#---------------------------S3 Uploading------------------------------------


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

aws s3 mv $org-$repo-$CURRENT_DATE.tar.gz  $s3url
aws s3 mv $org-$repo-$CURRENT_DATE.tar  $s3url
aws s3 mv $FILENAME  $s3url

aws s3 ls $s3url

echo -e  "\nPLEASE CHECK YOUR FILE IN THE LIST ABOVE\n" 

else 
	echo -e "S3 Uploading process skipped by user\n"
	echo "Your Repo is available on your current directory"
fi
echo "THANKS, HAVE A NICE DAY"

#--------------------------------------------------------------------#

else 
rm tem_exist.txt
echo "Repo not found, Please Try Again"
 fi
