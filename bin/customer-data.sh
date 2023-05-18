#!/bin/bash

# clean
./bin/clean.sh

# common
cp ./common/providers.tf.json ./workspace/

# data
cp -r ./data/customer-data/* ./workspace/

# engine
cp ./engine/vpc.tf ./workspace
cp ./engine/nat.tf ./workspace
cp ./engine/subnet.tf ./workspace
cp ./engine/transit_gateway_attachment.tf ./workspace
cp ./engine/routetables.tf ./workspace
cp ./engine/internetgateway.tf ./workspace
cp ./engine/eip.tf ./workspace


cp ./data/customer-data/variables.tf ./workspace

