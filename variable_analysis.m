list_of_variable_files = dir('*_analysis.mat');
for k = 1:length(list_of_variable_files);
    load(list_of_variable_files(k).name);
    droso_vars(k) = droso;
    killer_vars(k) = killer;
    clear droso killer
end
droso_array = struct2cell(droso_vars);
killer_array = struct2cell(killer_vars);
%% cell array
% cellarray(1, :, x) = mean_speed
% cellarray(2, :, x) = variance_speed
% cellarray(3, :, x) = max_speed
% cellarray(4, :, x) = mean_acceleration
% cellarray(5, :, x) = variance_acceleration
% cellarray(6, :, x) = max_acceleration
%%
