%% plots speeds of droso and predator against frame number
% assumes that all fly data is kept in individual calibration
% folders named \x_calib
line_width = 2;
response = responsegui('what to plot', 'All subfolders', 'This folder only');
if strcmp(response, 'This folder only') == 1;
    list = struct('name', pwd());
else
    query = {'root folder', 'string that subfolders end in'};
    answer = inputdlg(query);
    number_of_characters = length(answer{2,1});
    list = sfold(answer{1,1}, answer{2,1}, number_of_characters);%first argument is root folder 
% of fly data; second argument is the characters used to 
% identify each data-containing subfolder
end

%% loads variables to plot
for k = 1:length(list);
    
    cd(list(k).name);
    clearvars('-except', 'list', 'line_width', 'k', 'file_to_load');

    file_to_load = which('distance_analysis.mat');
    try
        load(file_to_load);
    catch message
        fprintf(1, '%s\n', message.message);
        continue
    end
    if  exist('SpEeD_droso', 'var') == 0;
        continue
    end
    str1 = list(1).name(1:end);
    exist_list = dir('*speed_holco_versus_droso.*');
    if isempty(exist_list) == 0;
        continue
    end

        
%% create figure
figure('MenuBar','none');
hold on;
set(gcf, 'Visible', 'off');
p1 = plot(SpEeD_droso, 'LineWidth', line_width, 'Color', 'r');
p2 = plot(SpEeD_killer, 'LineWidth', line_width, 'Color', 'b');
xlabel({'Frame number'}, 'FontSize', 12, 'FontWeight', 'bold')
ylabel({'Speed of object', '(mm/s)'}, 'FontSize', 12, 'FontWeight', 'bold')
title('Graph of speeds of predator and prey', 'FontSize', 12, 'FontWeight', 'bold')
legend('Speed of prey', 'Speed of predator', 'location', 'southeast')
set(gca, 'TickDir', 'out')
% ax = gca;
% [xaf, yaf] = ds2nfu([xa1, xa2], [ya1, ya2]);



set(gcf, 'Visible', 'on');
%% gets substrings to name figures
str2 = list(k).name;
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

pngstr1 = sprintf('%s_%s_speed.png', substr1, substr2);
figstr1 = sprintf('%s_%s_speed.fig', substr1, substr2);
saveas(gcf, ['F:\analysis\' pngstr1], 'png');
saveas(gcf, ['F:\analysis\' figstr1], 'fig');
clf
close(gcf);
%% save some variables about the speeds
mean_speed_droso = mean(SpEeD_droso);
mean_speed_killer = mean(SpEeD_killer);
variance_speed_droso = var(SpEeD_droso);
variance_speed_killer = var(SpEeD_killer);
max_speed_droso = max(SpEeD_droso);
max_speed_killer = max(SpEeD_killer);
%% saves the figures using format FlyXX_x_calib_speed
try save('mean_analysis.mat', 'mean_speed_droso', 'mean_speed_killer', 'variance_speed_droso', 'variance_speed_killer', 'max_speed_droso', 'max_speed_killer');
catch message2
    fprintf(1, '%s', message.message);
    clearvars('-except', 'list', 'line_width', 'k');
end
end