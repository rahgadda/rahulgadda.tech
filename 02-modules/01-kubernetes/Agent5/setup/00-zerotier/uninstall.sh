#!/bin/bash

sudo systemctl stop zerotier-one
systemctl daemon-reload
yum remove -y zerotier-one