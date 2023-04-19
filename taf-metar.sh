#!/bin/bash

# Prompt user for ICAO code
read -p "Enter the ICAO code of the airport: " airport

# Retrieve TAF data from aviationweather.gov API
taf_url="https://aviationweather.gov/adds/dataserver_current/httpparam?dataSource=tafs&requestType=retrieve&format=xml&hoursBeforeNow=4&mostRecentForEachStation=true&stationString=$airport"
taf=$(curl -s "$taf_url" | grep -oP '(?<=<raw_text>)[^<]+')

# Retrieve METAR data from aviationweather.gov API
metar_url="https://aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&format=xml&hoursBeforeNow=4&mostRecentForEachStation=true&stationString=$airport"
metar=$(curl -s "$metar_url" | grep -oP '(?<=<raw_text>)[^<]+')

# Create directory based on user's input
read -p "Enter the directory name to save the files in: " directory
mkdir -p "$directory"

# Create filename based on user's input
read -p "Enter the filename to save the data in: " filename

# Save TAF and METAR data to file
echo "$taf" > "$directory/$filename.taf.txt"
echo "$metar" > "$directory/$filename.metar.txt"

# Output success message
echo "TAF and METAR data saved to $directory/$filename.taf.txt and $directory/$filename.metar.txt"
