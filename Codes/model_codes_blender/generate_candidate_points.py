#import module
import bpy
import numpy as np
import mathutils
from mathutils import Vector

#define the coordinate x and y for each candidate scanning point
cam_position_0=np.array([-5,-2,1,5,8,11,14])
cam_position_1=np.array([-1,2,5,8])

#generate candidates 
for k in range(len(cam_position_0)):
    for l in range(len(cam_position_1)):
        #create a candidate scanning point
        bpy.ops.mesh.primitive_ico_sphere_add()
        so = bpy.context.active_object
        #define the location for current candidate point
        so.location[0]=cam_position_0[k]
        so.location[1]=cam_position_1[l]
        so.location[2]=0
        #define the scale for current candidate point
        so.scale[0]=0.2
        so.scale[1]=0.2
        so.scale[2]=0.2
        

