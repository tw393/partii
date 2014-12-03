%% creates Matrix Ms and Ma containing speed and acceleration calculations
%files contained in F:/analysis/analysis_data
list = dir('*_distance_analysis.mat');
%% collate data about speed into one matrix
for k = 1:length(list);
    load(list(k).name)
    try
    Ma(k,1:length(Acceleration_plain_droso)) = Acceleration_plain_droso;
    Ms(k,1:length(SpEeD_droso)) = SpEeD_droso;
    catch message
        fprintf(1,'%s\n',message.message)
        continue
    end
    clearvars('-except', 'k', 'list', 'M')
end

%% create logical index for calculating the mean ignoring zeros
% because different flys are different lengths of frame number
% and therefore have trailing zeros in a 718 long matrix
logMs = logical(Ms);
%% creates a matrix where       (1,k) = mean of speeds of all flies at frame k
%                               (2,k) = standard deviation of speeds of all flies at frame k
%                               (3,k) = standard error ...
%                               (4,k) = sum of flies used ...
                            
for k = 1:length(Ms);
    slogical_column = logMs(:,k);
    smean_column = mean(Ms(slogical_column,k));
    sstd_column = std(Ms(slogical_column,k));
    ssum_column = sum(logMs(:,k));
    sparams_perframe(1,k) = smean_column;
    sparams_perframe(2,k) = sstd_column;
    sparams_perframe(3,k) = sstd_column / sqrt(ssum_column);
    sparams_perframe(4,k) = ssum_column;
end
for k = 1:length(Ma);
    alogical_column = logMa(:,k);
    amean_column = mean(Ma(alogical_column,k));
    astd_column = std(Ma(alogical_column,k));
    asum_column = sum(logMa(:,k));
    aparams_perframe(1,k) = amean_column;
    aparams_perframe(2,k) = astd_column;
    aparams_perframe(3,k) = astd_column / sqrt(asum_column);
    aparams_perframe(4,k) = asum_column;
end
clearvars('-except', 'logMa', 'logMs', 'Ma', 'Ms', 'sparams_perframe', 'aparams_perframe);
save('standard_error_matrices.mat', 'sparams_perframe', 'aparams_perframe');
