#!/bin/bash

cd /app/
/terraform plan
/terraform destroy -auto-approve \
-input=false