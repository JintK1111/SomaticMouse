clc;clear;
% Load the data from the output text file
fileID = fopen('DN705.txt', 'r');
scores = fscanf(fileID, '%d');
fclose(fileID);

% Filter out 0 scores
nonZeroScores = scores;

% Count occurrences of each score
scoreCounts = histcounts(nonZeroScores, 'BinMethod', 'integers');

% Calculate percentages for all 3n values from -150 to 150
allValues = -75:3:50;
percentages = zeros(length(allValues), 1);

for i = 1:length(allValues)
    score = allValues(i);
    percentages(i) = sum(nonZeroScores == score) / length(nonZeroScores) * 100;
end

% Display percentages
disp('Percentages for 3n values from -150 to 150:');
disp('Score   Percentage');
disp([allValues', percentages]);

combinedData = [allValues', percentages];
csvwrite('combined_data.csv', combinedData);

% Summarize the percentages
totalPercent = sum(percentages);
disp(['Total percentage for 3n values: ', num2str(totalPercent)]);
% Specify the path to the output file
output_file_path = 'path/to/output_file.txt';  % Replace with the actual path

% Draw histogram
figure;
histogram(nonZeroScores, 'BinMethod', 'integers');
xlabel('Score');
ylabel('Frequency');
title('Score Distribution');

