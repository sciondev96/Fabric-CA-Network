docker rm -f {ca-tls,rca-org0,rca-org1,rca-org2,rca-org3}

cd org0
sudo rm -rf */

cd ../org1
sudo rm -rf */

cd ../org2
sudo rm -rf */

cd ../org3
sudo rm -rf */

cd ../TLS-CA
sudo rm -rf */

echo "Setting up ca-tls"
echo
echo

./tlsCA-setup.sh

sleep 5

echo "Generating Org1 certificates"
echo
echo

cd ../org1
./setupOrg1CA.sh
./setup-peer1.sh
./setup-peer2.sh
./setup-admin.sh
./setup-org1-msp.sh

cp ../configorg1.yaml ./msp/config.yaml
mv ./peers/peer1/tls-msp/keystore/*_sk ./peers/peer1/tls-msp/keystore/key.pem
mv ./peers/peer2/tls-msp/keystore/*_sk ./peers/peer2/tls-msp/keystore/key.pem

sleep 5

echo "Generating Org2 certificates"
echo 
echo 

cd ../org2
./setupOrg2CA.sh
./setup-peer1.sh
./setup-peer2.sh
./setup-admin.sh
./setup-org2-msp.sh

cp ../configorg2.yaml ./msp/config.yaml
mv ./peers/peer1/tls-msp/keystore/*_sk ./peers/peer1/tls-msp/keystore/key.pem
mv ./peers/peer2/tls-msp/keystore/*_sk ./peers/peer2/tls-msp/keystore/key.pem

sleep 5

echo "Generating Org3 certificates"
echo 
echo 

cd ../org3
./setupOrg3CA.sh
./setup-peer1.sh
./setup-peer2.sh
./setup-admin.sh
./setup-org3-msp.sh

cp ../configorg3.yaml ./msp/config.yaml
mv ./peers/peer1/tls-msp/keystore/*_sk ./peers/peer1/tls-msp/keystore/key.pem
mv ./peers/peer2/tls-msp/keystore/*_sk ./peers/peer2/tls-msp/keystore/key.pem

sleep 5

echo "Generating Org0-Orderer certificates"
echo
echo 

cd ../org0
./setupOrg0CA.sh
./setup-orderer.sh
./setup-admin.sh
./setup-org0-msp.sh

mv ./orderer/tls-msp/keystore/*_sk ./orderer/tls-msp/keystore/key.pem

sleep 5

cd ../org1/peers/peer1/assets
mkdir chaincode
cd chaincode
cp -R ../../../../../sacc ./
cd ../../../../../

echo "Starting generation of genesis block"
echo
echo 

cd ./cmd
./genesis.sh

