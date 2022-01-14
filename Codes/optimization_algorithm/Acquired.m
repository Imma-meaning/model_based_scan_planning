%compute the acquired rate for a certain set of vertices
function[acquired_rate_] = Acquired(scan,set)
acquired_rate_ = 0.0;
%check whether a certain vertice is covered in this set
for i = 1:scan.num_vertices
    if set(i)
        acquired_rate_ = acquired_rate_ + 1;
    end
end   
%acquired rate is the coverage of covered vertices in solution plan in all
%vertices in the target object
acquired_rate_ = acquired_rate_/scan.num_vertices;
end