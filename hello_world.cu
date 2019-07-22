#include<stdio.h>

__global__ void hello_world() {
    // printf("Hello World from Cuda\n");
    // printf("threadIdx.x: %d, threadIdx.y: %d, threadIdx.z\n", threadIdx.x, threadIdx.y, threadIdx.z);
    printf("threadIdx.x: %d, threadIdx.y: %d, threadIdx.z: %d <-> blockIdx.x: %d, blockIdx.y: %d, blockIdx.z: %d \n", threadIdx.x, threadIdx.y, threadIdx.z, blockIdx.x, blockIdx.y, blockIdx.z);
    
}

int main() {
    dim3 grid(4, 1, 1);
    dim3 block(2, 1, 1);


    hello_world<<<block, grid>>>();


    cudaDeviceSynchronize();

    cudaDeviceReset();

    return 0;
}