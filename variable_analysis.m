%% constructs a matrix containing movement data of droso and holco
% from analysis.mat files contained in F:\analyis\
%% loads the data from \analysis\
current_folder = pwd();
cd('F:\analysis\analysis_data')
list_of_variable_files = dir('*_analysis.mat');
droso_array = zeros(27,6);
holco_array = zeros(27,6);
%% creates struct containing all the data
for k = 1:length(list_of_variable_files);
    load(list_of_variable_files(k).name);
    try droso_vars(k) = droso;
        holco_vars(k) = killer;
    catch message
        fprintf(1, '%s\n', message.message);
        continue
    end
    clear droso killer
end
%% puts data from struct into a [K x 6] matrix where K is the
% number of different Fly data being analysed
for k = 1:length(list_of_variable_files);
    droso_array(k,1) = droso_vars(k).mean_speed;
    droso_array(k,2) = droso_vars(k).variance_speed;
    droso_array(k,3) = droso_vars(k).max_speed;
    droso_array(k,4) = droso_vars(k).mean_acceleration;
    droso_array(k,5) = droso_vars(k).variance_acceleration;
    droso_array(k,6) = droso_vars(k).max_acceleration;

    holco_array(k,1) = holco_vars(k).mean_speed;
    holco_array(k,2) = holco_vars(k).variance_speed;
    holco_array(k,3) = holco_vars(k).max_speed;
    holco_array(k,4) = holco_vars(k).mean_acceleration;
    holco_array(k,5) = holco_vars(k).variance_acceleration;
    holco_array(k,6) = holco_vars(k).max_acceleration;
end

mean_speed_all_droso = mean(droso_array(:,1));
mean_acceleration_all_droso = mean(droso_array(:,4));
mean_speed_all_holco = mean(holco_array(:,1));
mean_acceleration_all_holco = mean(holco_array(:,4));

cd(current_folder);
clear list_of_variable_files k current+folder droso_vars holco_vars
%% explanation of variable arrays
% array(:,1) = mean_speed
% array(:,2) = variance_speed
% array(:,3) = max_speed
% array(:,4) = mean_acceleration
% array(:,5) = variance_acceleration
% array(:,6) = max_acceleration