#!/bin/sh

. ./config

echo ">> Making everything go bye-bye!"
kind delete clusters "${KIND_CLUSTER}"
