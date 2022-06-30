//
// Created by 42yea on 29/06/2022.
//

#ifndef SUITE_CUDAPTR_CUH
#define SUITE_CUDAPTR_CUH

#include <iostream>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>


template<typename T>
class CudaPtr {
public:
    explicit CudaPtr(T *what, int n = 1) : cuda_ptr(nullptr), original(what), n(n) {
        cudaMalloc(&cuda_ptr, sizeof(T) * n);
        cudaMemcpy(cuda_ptr, original, sizeof(T) * n, cudaMemcpyHostToDevice);
        count = new int(1);
    }

    ~CudaPtr() {
        if (!cuda_ptr || !original) {
            return;
        }
        count[0]--;
        if (*count == 0) {
            cudaMemcpy(original, cuda_ptr, sizeof(T) * n, cudaMemcpyDeviceToHost);
            cudaFree(cuda_ptr);
        }
    }

    CudaPtr(const CudaPtr &ptr) : cuda_ptr(ptr.cuda_ptr), original(ptr.original), count(count), n(n) {
        count[0]++;
    }

    CudaPtr(CudaPtr &&ptr) noexcept : cuda_ptr(ptr.cuda_ptr), original(ptr.original), count(count), n(n) {
        ptr.cuda_ptr = nullptr;
        ptr.original = nullptr;
    };

    T *get() const {
        return cuda_ptr;
    }

private:
    T *cuda_ptr;
    T *original;
    int *count;
    int n;
};


#endif //SUITE_CUDAPTR_CUH
