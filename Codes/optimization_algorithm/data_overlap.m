%calculate data overlap status of the scanning plan, i. e. the average 
%average value of how many times a vertice is scanned when it's covered in
%scanning plan
function[scan] = data_overlap(scan)
%for each indice i in target object, check whether it is visiblt to
%scanning point j, if j is in the solution plan
for i = 1 : scan.num_vertices
    for j = 1 : size(scan.sol_set,1)
        if scan.sol_set(j)
            if scan.pvs(j,i)
                scan.overlap_status = scan.overlap_status + 1;
            end
        end
    end
end
%data-overlap status:total scanning times /number of vertices covered in the scanning plan
scan.overlap_status = scan.overlap_status/(scan.num_vertices*scan.acquired_rate);
end