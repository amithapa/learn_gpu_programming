#include<stdio.h>


__global__ void print_indexs() {
    printf("threadIdx.x: %d, threadIdx.y: %d, threadIdx.z: %d, blockIdx.x: %d, blockIdx.y: %d, blockIdx.z: %d, blockDim.x: %d, blockDim.y: %d, blockDim.z: %d, gridDim.x: %d, gridDim.y: %d, gridDim.z: %d\n",
    threadIdx.x, threadIdx.y, threadIdx.z, blockIdx.x, blockIdx.y, blockIdx.z, blockDim.x, blockDim.y, blockDim.z, gridDim.x, gridDim.y, gridDim.z);
}

int main() {
    int nx = 16;
    int ny = 16;
    int nz = 16;

    dim3 block(8,8,8);
    dim3 grid(nx/block.x, ny/block.y, nz/block.z);
    print_indexs<<<grid, block>>>();
    cudaDeviceSynchronize();
    cudaDeviceReset();

    return 0;
}