#!/bin/bash

echo "Network Interfaces"
ip addr show

echo
echo "Routing Table"
ip route show

echo
echo "Pinging Google DNS"
ping -c 4 8.8.8.8
