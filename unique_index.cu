#include<stdio.h>
#define ARRAY_SIZE 16

__global__ void unique_idx_calc_threadIdx(int * input) {
    int tid = threadIdx.x+blockIdx.x*blockDim.x;
    printf("threadIdx.x: %d, blockIdx.x: %d, blockDim.x: %d, value: %d\n", tid, blockIdx.x, blockDim.x, input[tid]);
}

__global__ void unique_gid_calc(int * input) {
    int tid = threadIdx.x;
    int offset = blockDim.x * blockIdx.x;
    int gid = tid + offset;
    printf("threadIdx.x: %d, blockIdx.x: %d, gid.x: %d, value: %d\n", tid, blockIdx.x, gid, input[gid]);
}
int main() {

    int ARRAY_BYTES = ARRAY_SIZE * sizeof(int);

    int h_data[] = {23, 9, 7, 14, 27, 4, 3, 11, 10, 13, 61, 42, 50, 67, 83, 22};
    for(int i=0; i<ARRAY_SIZE; i++) {
        printf("%d ", h_data[i]);
    }
    printf("\n \n");
    int * d_data;
    cudaMalloc((void**)&d_data, ARRAY_BYTES);
    cudaMemcpy(d_data, h_data, ARRAY_BYTES, cudaMemcpyHostToDevice);

    dim3 grid(4);
    dim3 block(4);

    // unique_idx_calc_threadIdx<<<grid,block>>>(d_data);
    unique_gid_calc<<<grid,block>>>(d_data);
    cudaDeviceSynchronize();
    cudaDeviceReset();

    return 0;
}