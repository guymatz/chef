#!/usr/bin/env bash
/usr/bin/env ssh -o "StrictHostKeyChecking=no" -i "/home/converter/.ssh/encoder-deploy" $1 $2
