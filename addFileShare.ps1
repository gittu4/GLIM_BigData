# persist credentials of file share to trusted list
cmdkey /add:<fileShareName>.file.core.windows.net /user:<fileShareName> /pass:<passCode>

#connect to the file share
net use z: \\labdiag870.file.core.windows.net\ubuntu-ssrs
