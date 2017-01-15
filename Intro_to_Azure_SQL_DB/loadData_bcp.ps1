#use bcp to load data into the tables in the Students Database
bcp Database.Schema.Table in <DriveLetter>:\<fileName>.txt -S <serverName>.database.windows.net -U <userName>@<serverName>.database.windows.net -P <password>  -F 1 -q -c -t  ','
