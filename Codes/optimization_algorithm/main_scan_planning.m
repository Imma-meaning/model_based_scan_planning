%**************************************************************************
%Software Lab 2021, Group 8, Model Based Scan-planning
%Mengying Jia, January 2022
%These codes use greedy best-first algorithem for minimizing the number of
%candidate scanning positions. The results of the algorithm is to get the
%number of scanning points of the scanning plan and their positions, the
%acquired rate of indices of whole target object in BIM software and
%meanwhile check the computation time of the optimization algorithm and
%data-overlap status.
%**************************************************************************

% close figures, command window and clear memory
close all;clc;clear;

% build structure 'scan'
[scan] = build_struct;
fprintf('struct for "scan" built\n')

% fill some fields of 'scan' with data from software Unity results
[scan] = set_data(scan);
fprintf('data for the struct set\n')

%minimize the number of scanning points
%use greedy best-first algorithm
[scan]=greedy_best_first(scan);
fprintf('greedy best-first algorithm completed\n');






