%print results and evaluations of the optimization algorithm
function[scan] = print_results(scan)
% if this method could successfully get a scanning plan, then print the
% results of the plan, including number of scanning points of the solution
% set and their positions, acquired rate, data-overlap status and
% computation time.
if scan.acquired_rate >= scan.required_acquired
    %print results to console
    fprintf('the number of scanning points of this plan is %d\n',scan.sol_number);
    fprintf('positions for scanning points in the solution set are\n');
    fprintf('x:');disp(scan.location_sol(1,:));
    fprintf('y:');disp(scan.location_sol(2,:));
    fprintf('the acquired rate of this plan is %f\n',scan.acquired_rate);
    fprintf('the data overlap status of this plan is %f\n',scan.overlap_status);
    fprintf('the computation time of the optimization algorithm is %f\n',scan.compute_time);
    %save positions of scanning points in the plan to text file
    sol_position = fopen('solutions_location.txt','w');
    fprintf(sol_position,'%d %d\r\n',scan.location_sol);
    fclose(sol_position);
    %save vertices covered in the scanning plan to text file
    sol_vertices = fopen('vertices_solution.txt','w');
    fprintf(sol_vertices,'%d\r\n',scan.vertices_sol);
    fclose(sol_vertices);
%if not, print that this method has failed to console
else
    fprintf('the computation time of the optimization algorithm is %f\n',scan.compute_time);
    fprintf('the acquired rate of this plan is %f\n',scan.acquired_rate);
    fprintf('which could not meet the value of required acquired rate\n');
    fprintf('this method has failed with the current candidate points and optimization algorithm\n');
end
end