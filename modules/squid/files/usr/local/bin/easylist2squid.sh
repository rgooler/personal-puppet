#!/bin/bash
curl -q 'https://easylist-downloads.adblockplus.org/easylist_noadult.txt' 2>/dev/null | sed -f '/etc/squid3/lists/easylist2squid.sed' 2>&1 > '/etc/squid3/lists/easylist.txt'
