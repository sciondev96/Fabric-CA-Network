mkdir -p ca/server
sleep 2
mkdir -p ca/client/admin
sleep 2
echo
echo "Configuring the environment"
echo

docker-compose -f org1CA.yaml up -d
sleep 4

cp ./ca/server/crypto/ca-cert.pem ./ca/client/admin/tls-ca-cert.pem
echo "Copied"
echo "#############################################"
sleep 2

export FABRIC_CA_CLIENT_HOME=./ca/client/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=tls-ca-cert.pem
sleep 2

fabric-ca-client enroll -d -u https://rca-org1-admin:rca-org1-adminpw@0.0.0.0:7054
sleep 2

fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7054
sleep 2

fabric-ca-client register -d --id.name peer2-org1 --id.secret peer2PW --id.type peer -u https://0.0.0.0:7054
sleep 2

fabric-ca-client register -d --id.name admin-org1 --id.secret org1AdminPW --id.type client -u https://0.0.0.0:7054
sleep 2

fabric-ca-client register -d --id.name user-org1 --id.secret org1UserPW --id.type user -u https://0.0.0.0:7054
sleep 2
