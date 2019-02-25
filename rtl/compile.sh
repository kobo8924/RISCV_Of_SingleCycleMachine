#!/bin/sh

cd .. && ./run_msim.sh -R && cd ./rtl
cd .. && ./run_msim.sh -c && cd ./rtl

