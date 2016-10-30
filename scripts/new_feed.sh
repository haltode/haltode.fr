#!/bin/sh

echo -n "Title: "
read title
echo -n "Link: "
read link
echo -n "Description: "
read description

date_rss=`date --rfc-2822`
date_atom=`date --iso-8601=seconds`

echo -e "\nRSS feed: \n"
echo -e "<item>"
echo -e "   <title>$title</title>"
echo -e "   <link>$link</link>"
echo -e "   <guid>$link</guid>"
echo -e "   <pubDate>$date_rss</pubDate>"
echo -e "   <description>$description</description>"
echo -e "</item>"

echo -e "\nAtom feed: \n"
echo -e "<entry>"
echo -e "   <title>$title</title>"
echo -e "   <link href=\"$link\" rel=\"alternate\"></link>"
echo -e "   <updated>$date_atom</updated>"
echo -e "   <id>$link</id>"
echo -e "   <author>"
echo -e "      <name>napnac</name>"
echo -e "   </author>"
echo -e "   <summary type=\"html\">$description</summary>"
echo -e "</entry>"
