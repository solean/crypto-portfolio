#!/bin/bash

cd client/
npm run build
cd ../api
ruby main.rb
