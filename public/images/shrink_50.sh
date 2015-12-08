#!/bin/bash

for i in *.jpg
do
	echo "Resizing ${i} -> ${i%.jpg}_25per.jpg"
	convert ${i} -resize 25% ${i%.jpg}_25per.jpg
done

