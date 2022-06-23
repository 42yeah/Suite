//
// Created by 42yea on 2022/6/22.
//

#ifndef SUITE_PRIM_CUH
#define SUITE_PRIM_CUH

#include <iostream>
#include <vector>
#include "modules/model/Model.cuh"
#include "modules/model/Vertex.cuh"
#include "modules/model/BBox.cuh"
#include "ui_modules/opengl/ModelGL.cuh"
#include "ui_modules/opengl/ObjectGL.cuh"


std::shared_ptr<ModelGL> gen_triangle();

// TODO: finish gen_bounding_box visualization
ObjectGL gen_bounding_box(const BBox &bbox);


#endif //SUITE_PRIM_CUH
