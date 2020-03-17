
mkdir -p ca/server
sleep 1s
mkdir -p ca/client/admin
sleep 2s


##################################################################
################# configuring the environment ####################
##################################################################
docker-compose -f org3CA.yaml up -d
sleep 4s
cp ./ca/server/crypto/ca-cert.pem ./ca/client/admin/tls-ca-cert.pem
sleep 2s



export FABRIC_CA_CLIENT_HOME=./ca/client/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=tls-ca-cert.pem
sleep 2s
#########################################################################
######If the path of the environment variable                      ######
######FABRIC_CA_CLIENT_TLS_CERTFILES is not an absolute path,      ######
######it will be parsed as relative to the client’s home directory ######
#########################################################################
fabric-ca-client enroll -d -u https://rca-org3-admin:rca-org3-adminpw@0.0.0.0:7056
echo "                                                                 "
echo "#################################################################"
echo "################ CA-Admin enrolled ##############################"
echo "#################################################################"
echo "                                                                 "


fabric-ca-client register -d --id.name admin1-org3 --id.secret org3dminPW --id.type client -u https://0.0.0.0:7086

fabric-ca-client register -d --id.name peer1-org3 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7056
sleep 2s
echo "                                                                 "
echo "#################################################################"
echo "################  peer1-org2 registered #########################"
echo "#################################################################"
echo "                                                                 "
fabric-ca-client register -d --id.name peer2-org3 --id.secret peer2PW --id.type peer -u https://0.0.0.0:7056
sleep 2s
echo "                                                                 "
echo "#################################################################"
echo "################  peer2-org2 registered #########################"
echo "#################################################################"
echo "                                                                 "
fabric-ca-client register -d --id.name admin-org3 --id.secret org3AdminPW --id.type client -u https://0.0.0.0:7056
sleep 2s
echo "                                                                 "
echo "#################################################################"
echo "################  admin-org2 registered #########################"
echo "#################################################################"
echo "                                                                 "
fabric-ca-client register -d --id.name user-org3 --id.secret org3UserPW --id.type user -u https://0.0.0.0:7056
sleep 2s
echo "                                                                 "
echo "#################################################################"
echo "################  user-org2 registered #########################"
echo "#################################################################"
echo "                                                                 "
