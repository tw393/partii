%% add standard error calculations to the distance_analysis
%files contained in F:/analysis/analysis_data
list = dir('*_distance_analysis.mat');
M = zeros(35,718); %718 is the length of the longest video in frames
killer_mean_std_per_frame = zeros(4,718); % this matrix will contain the 
% data we pull from the individual *distance_analysis.mat files
%% collate data about speed into one matrix
for k = 1:length(list);
    load(list(k).name)
    try
    M(k,1:length(SpEeD_killer)) = SpEeD_killer;
    catch message
        fprintf(1,'%s\n',message.message)
        continue
    end
    clearvars('-except', 'k', 'list', 'M')
end

%% create logical index for calculating the mean ignoring zeros
% because different flys are different lengths of frame number
% and therefore have trailing zeros in a 718 long matrix
logM = logical(M);
%% creates a matrix where       (1,k) = mean of speeds of all flies at frame k
%                               (2,k) = standard deviation of speeds of all flies at frame k
%                               (3,k) = standard error ...
%                               (4,k) = sum of flies used ...
                            
for k = 1:length(M);
    logical_column = logM(:,k);
    mean_column = mean(M(logical_column,k));
    std_column = std(M(logical_column,k));
    sum_column = sum(logM(:,k));
    killer_mean_std_per_frame(1,k) = mean_column;
    killer_mean_std_per_frame(2,k) = std_column;
    killer_mean_std_per_frame(3,k) = std_column / sqrt(sum_column);
    killer_mean_std_per_frame(4,k) = sum_column;
end
clearvars('-except', 'logM', 'M', 'killer_mean_std_per_frame');