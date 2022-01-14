#
"""
 Software Lab 2021, Group 8, Model Based Scan-planning 
 Jia,Mengying
 This code uses ray_cast function from class BVHTree in bpy to check the visibily 
 for a vertice to a certain position and gets the index for all visibe vertices with
 respect to 28 candidate scanning points in different positions, which will be used
 for further optimization of the candidate scanning points
 """
#import module
import bpy
import numpy as np
import mathutils
from mathutils import Vector
from mathutils.bvhtree import BVHTree

#get vertices in the object model 'room'
def VerticesInWorld_Object( obj ):
    #transformation matrix from local coordinate system defined on the object 
    #to global coordinate system
    mWorld = obj.matrix_world
    #global coordinates of all vertices in the model
    vertsInWorld = [mWorld @ (v.co) for v in obj.data.vertices]     
    return vertsInWorld

#use BVH tree structures for further visibility check using ray casts on geometry.
def BVHTree_Object( obj ):
    #transformation matrix from local coordinate system defined on the object 
    #to global coordinate system
    mWorld = obj.matrix_world
    #global coordinates of all vertices in the model
    vertsInWorld = [mWorld @ (v.co) for v in obj.data.vertices]
    #get the bounding volume hierarchy tree for further ray_cast function
    bvh = BVHTree.FromPolygons( vertsInWorld, [p.vertices for p in obj.data.polygons] )    
    return bvh

#deselect all polygons, edges and vertices for default
def DeselectMeshElements( obj ):
    for p in obj.data.polygons:
        p.select = False
    for e in obj.data.edges:
        e.select = False
    for w in obj.data.vertices:
        w.select = False
        
#define objects' name        
cam = bpy.data.objects['Camera'] 
obj = bpy.data.objects['room']
#deselect polygons, edges and vertices for default
DeselectMeshElements( obj )
#get global coordinates for all vertices in model
vertices = VerticesInWorld_Object( obj )
#define a bvh tree structure for further visibility check
bvh = BVHTree_Object( obj )

#open files to store data
vertices_visible = open("D:\\Computational Mechanics\\Software Lab\\vertices_visible.txt", 'w')
candidates_location = open("D:\\Computational Mechanics\\Software Lab\\candidates_location.txt", 'w')
#print  number polygons, edges and vertices in the mesh to console
print("number of vertices:",len(obj.data.vertices))
print("number of edges:",len(obj.data.edges))
print("number of polygons:",len(obj.data.polygons))
#define the position of candidate scanning points
cam_position_0=np.array([-5,-2,1,5,8,11,14])
cam_position_1=np.array([-1,2,5,8])
#visibily check of edges for each candidate scanning point
#set x,y,z components for each candidate scanning position
cam.location[2]=0
for k in range(len(cam_position_0)):
    cam.location[0]=cam_position_0[k]
    for l in range(len(cam_position_1)):
        cam.location[1]=cam_position_1[l]
        #save camera position to txt file
        candidates_location.write(str(cam_position_0[k]))
        candidates_location.write('\n')
        candidates_location.write(str(cam_position_1[l]))
        candidates_location.write('\n')
        #check each vertice's visibility for the current camera position
        for num in range (len(vertices)):
            A = vertices[num]
            #deselect the vertices by default
            obj.data.vertices[num].select = False
            """
            using the ray_cast function from class BVHTree for visibility check
            input parameters are origin position and normalized direction vector of the ray
            return values are center location, normal vector, index and 
            distance from origin to center of the first polygon the ray hits
            all return values will be none if there is no hit
            """
            location_A, normal_A, index_A, distance_A = bvh.ray_cast(cam.location,(A-cam.location).normalized())
            #define the limit according to required LOA of the point cloud
            limit=0.05
            #the vertice is visible when there's no hit
            if not location_A:
                obj.data.vertices[num].select = True
                #write data for index of visible vertices to txt files
                vertices_visible.write(str(num+1))
                vertices_visible.write('\n')
            #If the vertice is close to the polygon that the ray hits first, we assume the vertice is the hit and still visible
            elif (A - location_A).length <= limit:
                obj.data.vertices[num].select = True
                #write data for index of visible vertices to txt files
                vertices_visible.write(str(num+1))
                vertices_visible.write('\n')
            else:
                vertices_visible.write(str(0))
                vertices_visible.write('\n')
                    
#close files
candidates_location.close()
vertices_visible.close()


