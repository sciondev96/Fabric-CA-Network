
#################################################################
###############       msp-org3 setup               ##############
#################################################################


mkdir -p msp/admincerts
mkdir  msp/cacerts
mkdir  msp/tlscacerts
mkdir  msp/users

sleep 2s
cp ./ca/server/crypto/ca-cert.pem ./msp/cacerts/org3-ca-cert.pem

cp ../TLS-CA/server/crypto/ca-cert.pem ./msp/tlscacerts/tls-ca-cert.pem


cp ./admin/msp/signcerts/cert.pem  ./msp/admincerts/org3-admin-cert.pem
