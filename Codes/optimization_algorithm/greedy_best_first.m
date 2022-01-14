%*************************************************************************
%Use greedy best-first algorithm to minimize number of scanning points.
%First step is to choose the candidate location which covers the most
%vertices of the model to the solution set, then add other candidates one
%by one, until the acquired rate reaches the required value.
%*************************************************************************
function[scan]=greedy_best_first(scan)

%start timing
t0=cputime;

%the number of vertices that one candidate point could cover
num_visible = zeros(scan.num_candidates,1);
for i = 1:scan.num_candidates
    trans = (scan.pvs(i,:)~=0);
    num_visible(i) = sum(trans)-1;
end

%find the candidate point that covers most number of vertices
%if there are 2 or more candidate cover maximal number of vertices, just
%set the first one to be the best_first_point
[~,best_first_point] = max(num_visible);
%set this point into the solution set
scan.sol_set(best_first_point) = best_first_point;
scan.sol_number = scan.sol_number+1;
%set covered indices into solution
x = scan.pvs(best_first_point,:);
%delete the last column which stores the index for relevant scanning point
scan.vertices_sol=x;scan.vertices_sol(:,[size(x,2)])=[];
%calculate current acquired rate
scan.acquired_rate = Acquired(scan,scan.vertices_sol);
%delete the data of points already in the solution from the pvs for
%calculation of next loop
rest_pvs=scan.pvs;rest_pvs([best_first_point],:)=[];
%%
%add other candidates to solution one by one for maximal 27 times, loop
%breaks when the acquired rate reaches the required value
for i = 1:scan.num_candidates-1
    %loop ends when reaching the requirement
    if scan.acquired_rate >= scan.required_acquired
        break;
    end
    %calculate increased number of indices to current solution for each
    %scanning point still in the candidate set
    increments = zeros(size(rest_pvs,1),1);
    for j = 1:size(rest_pvs,1)
        inters = rest_pvs(j,:);
        inters(find(inters==0)) = [];
        %check which of the rest points could increase the most indices to
        %the solution
        for k = 1:size(inters,2)-1
            if scan.vertices_sol(inters(k))==0
                increments(j) = increments(j) + 1;
            end
        end
    end
    %scanning point with index 'best' is the next point added to solution
    [~,best] = max(increments);
    %set this point into the solution set
    %best is the index for scanning point in the current pvs and best_index
    %is the index for scanning point in the original set
    best_index = rest_pvs(best,scan.num_vertices+1);
    scan.sol_set(best_index) = best_index;
    scan.sol_number = scan.sol_number+1;
    %set the covered indices into solution
    for m = 1:num_visible(best_index)
        transition= rest_pvs(best,:);
        %transition stores the vertices covered by point 'best'
        transition(find(transition==0)) = [];
        %set the vertices covered by point 'best' into solution
        for n = 1:size(transition,2)-1
            scan.vertices_sol(transition(n)) = transition(n);
        end
    end
    %delete the data of points already in the solution from the pvs for
    %calculation of next loop, i.e. renew the rest_pvs
    mediate=rest_pvs;mediate([best],:)=[];
    rest_pvs = mediate;
    %calculate the current acquired rate
    scan.acquired_rate = Acquired(scan,scan.vertices_sol);
end
%% results
%set positions of scanning points into the solution scanning plan
[scan] = set_sol_points(scan);

%calculate data overlap status of the scanning plan
[scan] = data_overlap(scan); 

%end timing
scan.compute_time = cputime - t0;

%print results
[scan] = print_results(scan);

end