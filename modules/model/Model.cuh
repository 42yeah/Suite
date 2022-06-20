//
// Created by 42yea on 21/06/2022.
//

#ifndef SUITE_MODEL_H
#define SUITE_MODEL_H

#include <iostream>
#include <vector>
#include "Vertex.cuh"


class Model {
public:
    Model() {  }

    explicit Model(std::string path);

private:
    std::vector<Vertex> vertices;
};


#endif // SUITE_MODEL_H
