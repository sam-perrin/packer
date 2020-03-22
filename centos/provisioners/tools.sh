#!/bin/sh -ex
yum -y install ${ANSIBLE:-ansible}
yum -y install ${PYTHON_PIP:-python-pip}
yum -y install python-devel
yum -y groupinstall 'development tools'
pip install --upgrade pip 
pip install ${TESTINFRA:-testinfra}
