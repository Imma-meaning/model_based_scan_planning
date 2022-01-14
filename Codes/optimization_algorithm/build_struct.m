%build struct 'scan'
%% define following variables in struct 'scan'
%**************************************************************************
%num_vertices:number of vertices of target object in BIM software Blender
%location_candidates:location of candidate scanning points
%num_candidates: number of candidate scanning points
%pvs:potential visible set, saving visibility for vertices to different
%canddate scanning points
%vertices_sol: vertices covered in the solution plan
%sol_set: indexes for scanning positions in the solution plan
%sol_number: number of scanning points in solution plan
%acquired_rate: number of covered vertices in the scanning solution/number
%of all vertices of target object
%overlap_status: average scanned times for covered vertices in the solution
%required_acquired: target acquired rate for final scanning solution
%compute_time: computation time for optimization algorithm
%**************************************************************************
%%
function[scan]=build_struct()

scan=struct('num_vertices',[],'location_candidates',[],'num_candidates',[],...
            'pvs',[],'vertices_sol',[],'sol_set',[],'sol_number',[],...
            'location_sol',[],'acquired_rate',[],'overlap_status',[],...
            'required_acquired',[],'compute_time',[]...
            );       
end