function listOfFolderNames = getSubFolders()

listOfFolderNames = {};
start_path = 'F:\';
allSubFolders = genpath(start_path);
remain = allSubFolders;
complete = [''];

count = 1;

while true % Demo code adapted from the help file.
[folderToAdd, remain] = strtok(remain, ';');
if isempty(folderToAdd), 
    break; 
end
flipList = fliplr(folderToAdd);
try
    testChars = flipList(1:5);
catch
    continue
end
if strcmp(testChars,'bilac') == 0
    continue
end
disp(sprintf('%s', folderToAdd))
listOfFolderNames = [listOfFolderNames folderToAdd];
end

listOfFolderNames = cell2struct(listOfFolderNames,'name',1);

end