#!/bin/bash
for i in {2..6};
do
	cd "s2e$i";
	location=$(curl -s "https://puhutv.com/api/slug/fi-ci-$i-bolum-izle" | jq -r ".data.media_analytic_settings.subCategory" | cut -d ',' -f2);
	echo $location;
	yol="https://vcdn-puhutv.akamaized.net/$location/hls/1080p/chunklist.m3u8?hdntl=exp=1515524268~acl=/*~data=hdntl~hmac=3a964e9a5ad902458cb315849a1bca4cac2efa3abdbf975f406149010e4009e7"
	echo $yol;
	curl -s $yol -H 'Host: vcdn-puhutv.akamaized.net' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: https://puhutv.com/fi-ci-$i-bolum-izle' -H 'Origin: https://puhutv.com' -H 'Connection: keep-alive' | grep chunklist |tee result;
	id=1;
	for j in $(cat result);
		do
			video="https://vcdn-puhutv.akamaized.net/$location/hls/1080p/$j";
			echo "s2e$i\-$id";
			curl -s $video -H 'Host: vcdn-puhutv.akamaized.net' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: https://puhutv.com/fi-ci-$i-bolum-izle' -H 'Origin: https://puhutv.com' -H 'Connection: keep-alive' -o $id.ts;
			((id++));
		done;
	cd "..";
done;

