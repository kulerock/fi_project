#!/bin/bash
for i in {2..6};
do
	cd s2e$i;
	if [ "all.ts"=$(ls|grep all.ts) ];
	then
	rm all.ts;
	fi;
	for j in $(ls | sort -n | grep ts);
	do
		cat $j>>all.ts;
	done;
	ffmpeg -i all.ts -acodec copy -vcodec copy s2e$i.mp4;
	mv s2e$i.mp4 "../";
	cd "..";
done;
