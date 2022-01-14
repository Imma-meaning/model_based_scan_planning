% set values to variables of struct 'scan'
function[scan]=set_data(scan)
%read information about target model, candidate scanning points and
%requirement for further optimization calculation

%load number of vertices of the target model and required acquired rate
load('NumberofVerticesAndRequiredAcquiredRate.mat','num_vertices','required_acquired');
%number of vertices of target object in bim software blender
scan.num_vertices = num_vertices;
%target acquired rate of the scanning plan
scan.required_acquired = required_acquired;

%read data about candidate points and the covered vertices 
scan.location_candidates = importdata('candidates_location.txt','r');
%number of candidate scanning points
scan.num_candidates = size(scan.location_candidates,1)/2;
%location of candidate scanning points
scan.location_candidates = reshape(scan.location_candidates,2,scan.num_candidates);

%read potential visible set
scan.pvs = importdata('vertices_visible.txt','r');
scan.pvs = reshape(scan.pvs,scan.num_vertices,scan.num_candidates);
scan.pvs = scan.pvs';
%add a column for index of candidate points for further calculation
pvs_index = 1:28;
pvs_trans = [scan.pvs';pvs_index];
scan.pvs = pvs_trans';

%initialize the solutions and evaluations of the scanning plan
scan.vertices_sol = zeros(scan.num_vertices,1);
scan.sol_set = zeros(scan.num_candidates,1);
scan.sol_number = 0;
scan.location_sol = zeros(2,scan.sol_number);
scan.acquired_rate = 0.0;
scan.overlap_status = 0.0;
scan.compute_time = 0.0;
end