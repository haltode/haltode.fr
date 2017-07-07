#!/bin/sh

echo -n "Title: "
read title
echo -n "Link: "
read link
echo -n "Description: "
read description

date_rss=`date --rfc-2822`

echo -e "\nRSS feed: \n"
echo -e "<item>"
echo -e "   <title>$title</title>"
echo -e "   <link>$link</link>"
echo -e "   <guid>$link</guid>"
echo -e "   <pubDate>$date_rss</pubDate>"
echo -e "   <description>$description</description>"
echo -e "</item>"
