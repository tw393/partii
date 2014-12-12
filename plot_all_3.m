
listOfFolderNames = {};
start_path = inputdlg('Root?');
start_path = start_path{1};
allSubFolders = genpath(start_path);
remain = allSubFolders;
complete = [''];
count = 1;
h2 = waitbar(0, 'Plotting...', 'Visible', 'off');
set(findall(h2,'type','text'),'Interpreter','none');
set(h2,'Position', [550 377.25 340 56.25])

listOfFolderNames = sfold(start_path, 'calib');
run_length = 0;

for q = 1:length(listOfFolderNames);
    cd(listOfFolderNames(q).name);
    exist_file = dir('KillerTraj*.mat');
    exist_file2 = dir('*_3D_*.mat');
    if isempty(exist_file) == 0;
        if isempty(exist_file2) == 1
            run_length = run_length + 1;
        end
    end
end

for k = 1:length(listOfFolderNames)
    cd(listOfFolderNames(k).name)
    currentFly = pwd();
    coords_file = dir('coords*.mat');
    
    try 
        load(coords_file.name)
    catch
        fprintf(1, 'pass %d: no coords file found.\n\n', k);
        continue
    end
    currentWorkFolder = pwd();
    existingFiles = dir('*_3D_*');
    if exist('KillerTrajDroso.mat','file') == 0
        
        continue
    end
    if isempty(existingFiles) == 1
        if isempty(coords.head_start)
            KillerStart = str2double(coords.takeoff);
        else
            KillerStart = str2double(coords.head_start);
        end
        KillerCatch = str2double(coords.catch);
        str = sprintf('plotting trajectory in %s\n', listOfFolderNames(k).name);
        waitbar(count / run_length,h2, str)
        set(h2,'visible','on');
        Killer2_TrajPlot02_tom(currentFly,KillerStart,KillerCatch)
        count = count + 1;
    end
    
    clear currentWorkFolder
end 
close(h2)
h = msgbox(complete,'Done:');