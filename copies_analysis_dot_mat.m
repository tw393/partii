list = sfold('D:\', 'calib', 5);
for k = 1:length(list);
    cd(list(k).name)
    file_to_copy = dir('distance_analysis.mat');
    if isempty(file_to_copy) == 1;
        continue
    end
    %% name file
    str2 = pwd();
    str2 = strrep(str2, '\', '-');
    q = strfind(str2, 'Fly');
    w = strfind(str2, '_calib');
    substr1 = str2(q:q + 4);
    if strcmp(str2(w - 1), 'w') == 1;
        substr2 = str2(w - 3:w + 5);
    elseif strcmp(str2(w - 1), 'd') == 1;
        substr2 = str2(w - 3:w + 5);
    else
        substr2 = str2(w - 1:w + 5);
    end
    %% copy file
    new_name = sprintf('%s_%s_distance_analysis.mat', substr1, substr2);
    copyfile(file_to_copy.name, ['F:/analysis/analysis_data/' new_name]);
    clearvars('-except', 'k', 'list');
end