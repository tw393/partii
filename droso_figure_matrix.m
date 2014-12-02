%% add standard error calculations to the distance_analysis
%files contained in F:/analysis/analysis_data
list = dir('*_distance_analysis.mat');
M = zeros(27,718);
droso_mean_std_per_frame = zeros(3,718);

for k = 1:length(list);
    load(list(k).name)
    try
    M(k,1:length(SpEeD_droso)) = SpEeD_droso
    catch message
        fprintf(1,'%s',message.message)
        continue
    end
    clearvars('-except', 'k', 'list', 'M')
end

%% create logical index for calculating the mean ignoring zeros
% because different flys are different lengths of frame number
logM = logical(M);
%%
%% creates a matrix where       (1,k) = mean of speeds of all flies at frame k
%                               (2,k) = standard deviation of speeds of all flies at frame k
%                               (3,k) = standard error ...
%                               (4,k) = sum of flies used ...
                            
for k = 1:length(M);
    logical_column = logM(:,k);
    mean_column = mean(M(logical_column,k));
    std_column = std(M(logical_column,k));
    sum_column = sum(logM(:,k));
    droso_mean_std_per_frame(1,k) = mean_column;
    droso_mean_std_per_frame(2,k) = std_column;
    droso_mean_std_per_frame(3,k) = std_column / sqrt(sum_column);
    droso_mean_std_per_frame(4,k) = sum_column;
end
clearvars('-except', 'logM', 'M', 'mean_std_per_frame');