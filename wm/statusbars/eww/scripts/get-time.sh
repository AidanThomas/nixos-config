#!/run/current-system/sw/bin/bash 

date +{\"hour\":\"%H\"\,\"minute\":\"%M\"\,\"date\":\"%a\ %_d\ %b\"} | jq
