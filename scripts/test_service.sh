#!/bin/bash
#
#Copyright Ziggurat Corp. 2017 All Rights Reserved.
#
#SPDX-License-Identifier: Apache-2.0
#

# Detecting whether can import the header file to render colorful cli output
if [ -f ./header.sh ]; then
 source ./header.sh
elif [ -f scripts/header.sh ]; then
 source scripts/header.sh
else
 alias echo_r="echo"
 alias echo_g="echo"
 alias echo_b="echo"
fi

CHANNEL_NAME="$1"
: ${CHANNEL_NAME:="mychannel"}
: ${TIMEOUT:="60"}
COUNTER=0
MAX_RETRY=5

USERNAME1=evans
CC_NAME=service
VERSION=1.0
ORDERER_CA=/opt/gopath/src/github.com/inklabsfoundation/inkchain/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo_b "Chaincode Path : " $CC_PATH
echo_b "Channel name : " $CHANNEL_NAME

verifyResult () {
    if [ $1 -ne 0 ] ; then
        echo_b "!!!!!!!!!!!!!!! "$2" !!!!!!!!!!!!!!!!"
        echo_r "================== ERROR !!! FAILED to execute MVE =================="
        echo
        exit 1
    fi
}

registerUser(){
    echo_b "pls wait 5 secs..."
    sleep 5
    peer chaincode invoke -o orderer.example.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"Args":["registerUser","evans","I am a golang developer"]}' -i "1000000000" -z bc4bcb06a0793961aec4ee377796e050561b6a84852deccea5ad4583bb31eebe >log.txt
    res=$?
    cat log.txt
    verifyResult $res "Register user has Failed."
    echo_g "===================== Register user success ======================= "
    echo
}

removeUser(){
    echo_b "pls wait 5 secs..."
    sleep 5
    peer chaincode invoke -o orderer.example.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"Args":["removeUser","evans"]}' -i "1000000000" -z bc4bcb06a0793961aec4ee377796e050561b6a84852deccea5ad4583bb31eebe >log.txt
    res=$?
    cat log.txt
    verifyResult $res "Register user has Failed."
    echo_g "===================== Remove user success ======================= "
    echo
}

queryUser () {
    echo_b "Attempting to Query user info "
    sleep 3
    peer chaincode query -C mychannel -n ${CC_NAME} -c '{"Args":["queryUser","'${USERNAME1}'"]}' >log.txt
    res=$?
    cat log.txt
    verifyResult $res "query user evans Failed."
}

registerService(){
    echo_b "pls wait 5 secs..."
    sleep 5
    peer chaincode invoke -o orderer.example.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"Args":["registerService","testService","knowledge","This is a test service demo","evans","http://127.0.0.1","10"]}' -i "1000000000" -z bc4bcb06a0793961aec4ee377796e050561b6a84852deccea5ad4583bb31eebe >log.txt
    res=$?
    cat log.txt
    verifyResult $res "Register service has Failed."
    echo_g "===================== Register service success ======================= "
    echo
}

queryService () {
    echo_b "Attempting to Query user info "
    sleep 3
    peer chaincode query -C mychannel -n ${CC_NAME} -c '{"Args":["queryService","testService"]}' >log.txt
    res=$?
    cat log.txt
    verifyResult $res "query testService service Failed."
}

invalidateService(){
    echo_b "pls wait 5 secs..."
    sleep 5
    peer chaincode invoke -o orderer.example.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"Args":["invalidateService","testService"]}' -i "1000000000" -z bc4bcb06a0793961aec4ee377796e050561b6a84852deccea5ad4583bb31eebe >log.txt
    res=$?
    cat log.txt
    verifyResult $res "Register service has Failed."
    echo_g "===================== Register service success ======================= "
    echo
}

publishService(){
    echo_b "pls wait 5 secs..."
    sleep 5
    peer chaincode invoke -o orderer.example.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"Args":["publishService","testService"]}' -i "1000000000" -z bc4bcb06a0793961aec4ee377796e050561b6a84852deccea5ad4583bb31eebe >log.txt
    res=$?
    cat log.txt
    verifyResult $res "Register service has Failed."
    echo_g "===================== Register service success ======================= "
    echo
}

editService(){
    echo_b "pls wait 5 secs..."
    sleep 5
    peer chaincode invoke -o orderer.example.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"Args":["editService","testService","Description","This is new description"]}' -i "1000000000" -z bc4bcb06a0793961aec4ee377796e050561b6a84852deccea5ad4583bb31eebe >log.txt
    res=$?
    cat log.txt
    verifyResult $res "Register service has Failed."
    echo_g "===================== edit service success ======================= "
    echo
}

createMashup(){
    echo_b "pls wait 5 secs..."
    sleep 5
    peer chaincode invoke -o orderer.example.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"Args":["createMashup","testMashup","knowledge","This is new mashup description","10","testService"]}' -i "1000000000" -z bc4bcb06a0793961aec4ee377796e050561b6a84852deccea5ad4583bb31eebe >log.txt
    res=$?
    cat log.txt
    verifyResult $res "Register marshup has Failed."
    echo_g "===================== create mashup success ======================= "
    echo
}

queryMashup () {
    echo_b "Attempting to Query marshup "
    sleep 3
    peer chaincode query -C mychannel -n ${CC_NAME} -c '{"Args":["queryService","testMashup"]}' >log.txt
    res=$?
    cat log.txt
    verifyResult $res "query testMarshup service Failed."
}

queryServiceByUser(){
    echo_b "Attempting to Query service by user "
    sleep 3
    peer chaincode query -C mychannel -n ${CC_NAME} -c '{"Args":["queryServiceByUser","evans"]}' >log.txt
    res=$?
    cat log.txt
    verifyResult $res "query service by user Failed."
}

callService(){
    echo_b "pls wait 5 secs..."
    sleep 5
    peer chaincode invoke -o orderer.example.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"Args":["callService","testService","1"]}' -i "1000000000" -z bc4bcb06a0793961aec4ee377796e050561b6a84852deccea5ad4583bb31eebe >log.txt
    res=$?
    cat log.txt
    verifyResult $res "Call service has Failed."
    echo_g "===================== calll service success ======================= "
    echo
}

getCallTime(){
    echo_b "Attempting to Query call time info "
    sleep 3
    peer chaincode query -C mychannel -n ${CC_NAME} -c '{"Args":["getCallTime","testService","evans"]}' >log.txt
    res=$?
    cat log.txt
    verifyResult $res "query call time info Failed."
}

reduceCallTime(){
    echo_b "pls wait 5 secs..."
    sleep 5
    peer chaincode invoke -o orderer.example.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"Args":["reduceCallTime","testService","evans","1"]}' -i "1000000000" -z bc4bcb06a0793961aec4ee377796e050561b6a84852deccea5ad4583bb31eebe >log.txt
    res=$?
    cat log.txt
    verifyResult $res "Reduce call time has Failed."
    echo_g "===================== reduce call time success ======================= "
    echo
}

echo "======================register user======================="
registerUser

echo "======================query user======================"
sleep 3
queryUser

echo "======================remove user======================"
removeUser

echo "======================register user again======================="
registerUser

echo "======================register service======================="
registerService

echo "======================query service======================="
sleep 3
queryService

echo "======================invalidate service======================="
invalidateService

echo "======================query service======================="
sleep 3
queryService

echo "======================publish service======================="
publishService

echo "======================query service======================="
sleep 3
queryService

echo "======================query service======================="
#editService

echo "======================query service======================="
sleep 3
queryService

echo "======================create mashup======================"
createMashup

echo "======================query mashup======================"
sleep 3
queryMashup

echo "======================query service by user======================"
sleep 3
queryServiceByUser

echo "======================call service======================"
callService

echo "======================call service======================"
getCallTime

echo "======================reduce call time======================"
reduceCallTime