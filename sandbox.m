%% add standard error calculations to the distance_analysis
%files contained in F:/analysis/analysis_data
list = dir('*_distance_analysis.mat');
current = 0;
for k = 1:length(list);
    load(list(k).name)
    if length(SpEeD_droso) < current
        disp('skipped')
        continue
    end
    current = length(SpEeD_droso)
    clearvars('-except', 'k', 'list', 'droso_speed_matrix', 'current')
end
