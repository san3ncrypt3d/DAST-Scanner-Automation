#/!bin/bash

domain="$1"

timestamp=$(date '+%s');

if [ -z "$domain" ]; then
    echo -e "Enter a valid URL.\r"
    exit 1
fi

/opt/zaproxy/zap.sh -quickurl "$domain" -newsession "$timestamp" -cmd;



Title="DAST Report"
By="san3ncrypt3d"
For="xx"
Scan_Date=$(date -d @$timestamp)
Report_Date=$(date -d @$timestamp)
Scan_Ver="1"
Report_Ver="1"
Description="DAST Automated scan by ZAP"
file_tmp=$(echo "$1" | awk -F/ '{print $3}' | awk -F. '{print $1}')
file="$file_tmp$timestamp"

/opt/zaproxy/zap.sh -export_report "$HOME"/"$file".xhtml -source_info "$Title;$By;$For;$Scan_Date;$Report_Date;$Scan_Ver;$Report_Ver;$Description" -alert_severity "t;t;t;t" -alert_details "t;t;t;t;t;t;t;t;t;t" -session "$timestamp.session" -cmd

wkhtmltopdf "$HOME"/"$file".xhtml "$HOME"/"$file".pdf
pandoc -o "$HOME"/"$file".docx "$HOME"/"$file".xhtml
