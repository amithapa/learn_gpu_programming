#include<stdio.h>
#define ARRAY_SIZE 16

__global__ void print_index_and_data(int * data) {
    int tid = threadIdx.x;
    int block_offeset = blockIdx.x * blockDim.x;
    int row_offset = blockDim.x * gridDim.x * blockIdx.y;
    int gid = tid + block_offeset + row_offset;
    // printf("threadIdx.x: %d, offeset: %d, gid: %d, blockIdx.x: %d, blockDim.x: %d, gridDim.x: %d, data: %d\n", tid, gid, offeset, blockIdx.x, blockDim.x, gridDim.x, data[gid]);
    //printf("threadIdx.x: %d, gid: %d, blockIdx.x: %d, blockIdx.y: %d, blockDim.x: %d, blockDim.y: %d, gridDim.x: %d, data: %d\n", tid, gid, blockIdx.x, blockIdx.y, blockDim.x, blockDim.y, gridDim.x, data[gid]);
    printf("%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t%d\t%d\n", tid, gid, blockIdx.x, blockIdx.y, blockDim.x, blockDim.y, gridDim.x, data[gid]);
}

int main() {
    // int nx = 16;
    // int ny = 16;

    int array_size_bytes = sizeof(int) * ARRAY_SIZE;
    // int h_data[ARRAY_SIZE] = {23, 9, 7, 14, 27, 4, 3, 11, 10, 13, 61, 42, 50, 67, 83, 22};
    int h_data[ARRAY_SIZE]; 
    for(int i=0; i<ARRAY_SIZE; i++) {
        h_data[i] =i;
        printf("%d ", h_data[i]);
    }

    printf("\n\n");

    dim3 block(4);
    dim3 grid(2, 2);

    int * d_data;
    cudaMalloc((void**)&d_data, array_size_bytes);

    cudaMemcpy(d_data, h_data, array_size_bytes, cudaMemcpyHostToDevice);
    printf("threadIdx.x\tgid\tblockIdx.x\tblockIdx.y\tblockDim.x\tblockDim.y\tgridDim.x\tdata\n");
    print_index_and_data<<<grid, block>>>(d_data);
    // print_index_and_data<<<4, 4>>>(d_data);
    
    cudaDeviceSynchronize();
    cudaDeviceReset();
    

    return 0;
}