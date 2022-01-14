%set positions of scanning points into the solution scanning plan
function[scan] = set_sol_points(scan)
positions = scan.sol_set;
%find index for scanning points in solution plan
positions(find(positions==0)) = [];
%set the position value of solution points into struct
for i = 1:scan.sol_number
    scan.location_sol(1,i) = scan.location_candidates(1,positions(i));
    scan.location_sol(2,i) = scan.location_candidates(2,positions(i));
end
end