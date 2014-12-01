function listOfFolderNames = sfold(start_path, end_string, number_of_characters)

listOfFolderNames = {};
allSubFolders = genpath(start_path);
remain = allSubFolders;
complete = [''];
flip_end_string = fliplr(end_string)
while true % Demo code adapted from the help file.
[folderToAdd, remain] = strtok(remain, ';');
if isempty(folderToAdd), 
    break; 
end
flipList = fliplr(folderToAdd);
try
    testChars = flipList(1:number_of_characters);
catch
    continue
end
if strcmp(testChars,flip_end_string) == 0
    continue
end
disp(sprintf('%s', folderToAdd))
listOfFolderNames = [listOfFolderNames folderToAdd];
end

listOfFolderNames = cell2struct(listOfFolderNames,'name',1);

end