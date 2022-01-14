#import module
import bpy
import bmesh
import mathutils
from mathutils import Vector
import numpy as np

#define the name of target objects
cam = bpy.data.objects['Camera'] 
obj = bpy.data.objects['room']
#get all vertices of target object in global coordinates
mWorld = obj.matrix_world
vertsInWorld = [mWorld @ (v.co) for v in obj.data.vertices]    
vertices = vertsInWorld

#mesh of object 'room'
bm = bmesh.new()
bm.from_mesh(obj.data)


#read covered indices from the optimization algorithm
#vertices_sol = np.loadtxt('D:\\Computational Mechanics\\Software lab\\vertices_solution_50.txt')
vertices_sol = np.loadtxt('D:\\Computational Mechanics\\Software lab\\vertices_solution_55.txt')
for i in range(len(vertices_sol)):
    vertices_sol[i] = vertices_sol[i] - 1

#use set-minus function to get uncovered vertices
#verticesList is a list for all vertices of object
verticesList = []
for i in range(len(vertices)):
    verticesList.append(i)
#transfer lists into sets to use minus function
verticesSet=set(verticesList)
solutionSet=set(vertices_sol)
#get the set for uncovered vertices and transfer it into a list
unvisibleSet=verticesSet-solutionSet
unvisibleList=list(unvisibleSet)

#delete the vertices which haven't been covered in the scan plan
for i in range(len(unvisibleList)):
    N = unvisibleList[i]
    #renew the lookup table, becase it changes when a vertice is deleted
    bm.verts.ensure_lookup_table()
    v = bm.verts[N-i]
    bm.verts.remove(v)
# Write the mesh back
bm.to_mesh(obj.data)