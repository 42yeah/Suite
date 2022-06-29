//
// Created by 42yea on 2022/6/22.
//

#ifndef SUITE_BVH_CUH
#define SUITE_BVH_CUH

#include <iostream>
#include <variant>
#include "modules/model/BBox.cuh"
#include "modules/model/Scene.cuh"
#include "modules/geoquery/Triangle.cuh"


class BVH {
public:
    struct Node {
        Node();

        Node(int start, int size, int l, int r, BBox bbox);

        int start, size, l, r;
        BBox bbox;
    };

    /// construct bounding volume hierarchy (BVH) for a scene.<br>
    ///
    /// procedure: <br>
    /// 1. initialize buckets <br>
    /// 2. for each primitive in node: <br>
    ///  2.1. compute its bucket <br>
    ///  2.2. bucket enclose that primitive <br>
    ///  2.3. bucket primitive count++ <br>
    /// 3. for each partition: <br>
    ///   3.1. evaluate cost (heuristic SAH), keep track of lowest cost partition <br>
    /// 4. recurse on lowest cost partition found (or make leaf).
    /// \param scene input scene
    /// \param n_buckets number of buckets
    explicit BVH(const Scene &scene, int n_buckets);

    const std::vector<Node> &get_nodes() const;

    BVH(const BVH &) = delete;

    BVH(BVH &&) = default;

private:
    std::vector<Triangle> primitives;
    std::vector<Node> nodes;
};


#endif //SUITE_BVH_CUH
