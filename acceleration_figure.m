%% plots acceleration of droso and predator against frame number
run_as = 'subfolders'; %simple runs in one folder, subfolders
%takes more options and plots for all data subfolders

line_width = 2;
%%
switch run_as
    case 'subfolders'
        response = responsegui('what to plot', 'All subfolders', 'This folder only');
        if strcmp(response, 'This folder only') == 1;
            list = struct('name', pwd());
        else
            if strcmp(run_as, 'simple') == 1;
                answer = {pwd, ''};
            else
                query = {'root folder', 'string that subfolders end in'};
                answer = inputdlg(query);
                %first argument is root folder
                % of fly data; second argument is the characters used to
                % identify each data-containing subfolder
            end
        end
        number_of_characters = length(answer{2,1});
        list = sfold(answer{1,1}, answer{2,1}, number_of_characters);
    case 'simple'
        list.name = pwd();
end
%%
for k = 1:length(list);
    
    cd(list(k).name);
    clearvars('-except', 'list', 'line_width', 'k', 'file_to_load', 'answer');

    file_to_load = which('distance_analysis.mat');
    try
        load(file_to_load);
    catch message
        fprintf(1, '%s\n', message.message);
        continue
    end
    if  exist('Acceleration_plain_droso', 'var') == 0;
        continue
    end
    str1 = list(1).name(1:end);
    exist_list = dir('*acceleration.*');
    if isempty(exist_list) == 0;
        continue
    end

        
%% create figure
figure('MenuBar','none');
hold on;
set(gcf, 'Visible', 'off');
p1 = plot(Acceleration_plain_droso, 'LineWidth', line_width, 'Color', 'r');
p2 = plot(Acceleration_plain_killer, 'LineWidth', line_width, 'Color', 'b');
xlabel({'Frame number'}, 'FontSize', 12, 'FontWeight', 'bold')
ylabel({'Acceleration of object', '(mm/s^2)'}, 'FontSize', 12, 'FontWeight', 'bold')
title('Graph of accelerations of predator and prey', 'FontSize', 12, 'FontWeight', 'bold')
legend('Acceleration of prey', 'Acceleration of predator', 'location', 'northeast')
set(gca, 'TickDir', 'out')
% ax = gca;
% [xaf, yaf] = ds2nfu([xa1, xa2], [ya1, ya2]);



set(gcf, 'Visible', 'on');
%% gets substrings to name figures
str2 = list(k).name;
str2 = strrep(str2, '\', '-');
q = strfind(str2, 'Fly');
w = strfind(str2, answer{2,1});
substr1 = str2(q:q + 4);
if strcmp(str2(w - 2), 'w') == 1;
    substr2 = str2(w - 4:w + 4);
elseif strcmp(str2(w - 2), 'd') == 1;
    substr2 = str2(w - 4:w + 4);
else
    substr2 = str2(w - 2:w + 4);
end

pngstr1 = sprintf('%s_%s_acceleration.png', substr1, substr2);
figstr1 = sprintf('%s_%s_acceleration.fig', substr1, substr2);
saveas(gcf, ['F:\analysis\' pngstr1], 'png');
saveas(gcf, ['F:\analysis\' figstr1], 'fig');
saveas(gcf, pngstr1, 'png');
saveas(gcf, figstr1, 'fig');
clf
close(gcf);
%% save some variables about the accelerations
droso.mean_speed = mean(SpEeD_droso);
killer.mean_speed = mean(SpEeD_killer);
droso.variance_speed = var(SpEeD_droso);
killer.variance_speed = var(SpEeD_killer);
droso.max_speed = max(SpEeD_droso);
killer.max_speed = max(SpEeD_killer);
droso.mean_acceleration = mean(Acceleration_plain_droso);
killer.mean_acceleration = mean(Acceleration_plain_killer);
droso.variance_acceleration = var(Acceleration_plain_droso);
killer.variance_acceleration = var(Acceleration_plain_killer);
droso.max_acceleration = max(Acceleration_plain_droso);
killer.max_acceleration = max(Acceleration_plain_killer);
%% saves the figures using format FlyXX_x_calib_speed
try save('analysis.mat', 'droso', 'killer');
catch message2
    fprintf(1, '%s', message2.message);
    clearvars('-except', 'list', 'line_width', 'k');
end
end