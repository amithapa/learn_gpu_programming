#include<stdio.h>
#define ARRAY_SIZE 16

__global__ void print_index_and_data(int * data) {
    int tid = threadIdx.y  * blockDim.x + threadIdx.x;

    int number_of_threads_in_block = blockDim.x * blockDim.y;

    int block_offeset = blockIdx.x * number_of_threads_in_block;

    int number_of_threads_in_row = number_of_threads_in_block * gridDim.x; 
    
    int row_offset = number_of_threads_in_row * blockIdx.y;
    int gid = tid + block_offeset + row_offset;
    
    printf("tid: %d, block_offset: (%d * %d = %d), row_offset  (%d * %d = %d) = %d\n", tid, number_of_threads_in_block, blockIdx.x, block_offeset, number_of_threads_in_row, blockIdx.y, row_offset, gid);

    printf("threadIdx.x: %d, threadIdx.y: %d, blockDim.x: %d, tid: %d, gid: %d, blockIdx.x: %d,, blockIdx.y: %d,, blockDim.x: %d,, blockDim.y: %d, gridDim.x: %d, gridDim.y: %d, data: %d\n", 
    threadIdx.x, threadIdx.y, blockDim.x, tid, gid, blockIdx.x, blockIdx.y, blockDim.x, blockDim.y, gridDim.x, gridDim.y, data[gid]);
}

int main() {

    int array_size_bytes = sizeof(int) * ARRAY_SIZE;
    int h_data[ARRAY_SIZE]; 
    for(int i=0; i<ARRAY_SIZE; i++) {
        h_data[i] =i;
        printf("%d ", h_data[i]);
    }

    printf("\n\n");

    dim3 block(2, 2);
    dim3 grid(2, 2);

    int * d_data;
    cudaMalloc((void**)&d_data, array_size_bytes);

    cudaMemcpy(d_data, h_data, array_size_bytes, cudaMemcpyHostToDevice);
    print_index_and_data<<<grid, block>>>(d_data);

    
    cudaDeviceSynchronize();
    cudaDeviceReset();
    

    return 0;
}