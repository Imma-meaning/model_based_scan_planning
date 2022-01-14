# Model Based Scan Planning  
This project makes an optimized scanning plan for a certain structure. First import the model of the structure into a BIM software, generate candidate scanning points and check the visibility of the indices in the model's mesh for each candidate point. Then use an optimization algorithm to minimize the number of scanning points and meanwhile keep the acquracy and completeness of the scanning results. Last import visualize the results of a scanning plan in BIM software for a certain scanning requirement.  
This project contains three parts: folder *model_codes_blender* contains the model and codes for options in software Blender, folder *optimization_algorithm* contains the codes written in software matlab and folder *results* contains the files saving results for each step.  
## 1 Model verification and visibility check  
### 1.1 Software environment   
Blender 2.93.1  
### 1.2 Candidates generation  
Run the script *generate_candidate_points.py* in file *room_pvs.blend* in the folder *model_codes_blender* to generate 28 candidate scanning points according to the givin positions.  
Delete the candidate spheres for default.
### 1.3 Visibility check  
Run the script *visibility_check.py* in file *room_pvs.blend* in the folder *model_codes_blender* to check the visibility of vertices of the target strucuture *room* to each candidate scanning points.  
#### 1.3.1 Architecture for *visibility_check.py*  
1) import relevant modules  
2) define name of target object  
3) get all vertices and their positions in global coordinate systems  
4) define a bvh tree struct for target object  
5) define positions of candidate scanning points.  
6) use *ray_cast* function from bvh tree to check the visibility for each vertice with respect to each candidate scanning points and write the results into files.  
#### 1.3.2 Results output  
1) export the location of candidate scanning points into file *candidates_location.txt*, which is in folder *results*  
2) export the PVS(potential visible set, stores visibility for vertices and candidate points) into file *vertices_viisble.txt*, which is in folder *results*  
## 2 Optimization algorithm  
The codes in folder *optimization_algorithm* uses greedy best-first algorithm to minimize the number of scanning points, which could meanwhile reach the scanning requirements, get the covered vertices for the optimized scanning plan and calculate some parameters for the plan.  
### 2.1 Softeware environment  
Matlab 2021b  
### 2.2 Codes architecture  
1) *main_scan_planning.m*: the main process of the optimization  
2) *build_struct.m*: build the struct *scan* for further options  
3) *set_data.m*: set values to parameters defined in struct *scan*, import data from *NumberofVerticesAndRequiredAcquiredRate.mat*, *candidates_location.txt* and *vertices_visible.txt* in folder *optimization_algorithm*.  
4) *greedy_best_first.m*: the main process of greedy best-first algorithm. First find the candidate point that covers the most number of vertices and then add other candidate points to solution set one by one, due to the increased number of covered vertices for each candidate point.  
5) *Acquired.m*: calculate the acquired rate for a certain set of covered vertices  
6) *data_overlap.m*: calculate the data-overlap status for a scanning plan  
7) *set_sol_points.m*: set the positions of scanning points in the solution scanning plan  
8) *print_results.m*: print the results of the optimization algorithm to console and files      
### 2.3 Results  
1) export the positions of scanning points in the solution scanning plan to file *solutions_location.txt* in folder *optimization_algorithm*  
2) export the covered vertices of a certain optimized scanning plan to file *vertices_solution.txt* in folder *optimization_algorithm*  
3) save the data for covered vertices under required acquired rate for 50% and 55% relatively in file *vertices_solution_50.txt* and *vertices_solution_55.txt* in folder *results*  
## 3 Results illustration  
### 3.1 Software environment  
Blender 2.93.1  
### 3.2 Point cloud illustration  
Run script *result_point_cloud_50.py* in file *room_point_cloud_50.blend* and script *result_point_cloud_55.py* in file *room_point_cloud_55.blend* to get the point cloud obtained from the certain scanning plan and the mesh made up by the covered vertices. (all files in folder *model_codes_blender*)  
#### 3.2.1 Codes architecture  
1) import relevant modules  
2) define name of target object, vertices in global coordinate system and bmesh of target object  
3) load covered incides *vertices_solution_50.txt* or *vertices_solution_55.txt* from folder *results*  
4) tranfer lists for covered and all vertices into set, use the minus function of set to obtain the set of unvisible vertices and transfer the set into a list  
5) delete the unvisible vertices in bmesh  
