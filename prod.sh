#!/bin/bash
aws s3 sync _site/ s3://karlcordes.com --region us-west-2
