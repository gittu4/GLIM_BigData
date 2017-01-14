# persist credentials of file share to trusted list
cmdkey /add:labdiag870.file.core.windows.net /user:labdiag870 /pass:8gnUh5/KtErq3sBF8wE+gRQllAaRGxGO74oiKtna2uTht+bTfmIYr3outuAiHSg0TY+oZBce3lNH/N0qct+M+A==

#connect to the file share
net use z: \\labdiag870.file.core.windows.net\ubuntu-ssrs

#use bcp to create format file in XML
bcp [table_name] format nul -f [format_file_name.fmt] -c -T 
bcp Students.Performance.School format nul -f [C:\school.fmt] -S sqlcw18.database.windows.net -U SQLuser@sqlcw18.database.windows.net -P AzureTrial@18 -c -T

bcp Students.Performance.School in C:\school.txt -S sqlcw18.database.windows.net -U SQLuser@sqlcw18.database.windows.net -P AzureTrial@18  -F 2 -q -c -t  ','
bcp Students.Performance.School in C:\student-por_balanced.txt -S sqlcw18.database.windows.net -U SQLuser@sqlcw18.database.windows.net -P AzureTrial@18  -F 2 -q -c -t  ','