#include<stdio.h>

#define NUM_BLOCKS 15
#define BLOCK_WIDTH 1

__global__ void hello() {
    printf("Hello world! I am a thread block %d\n", blockIdx.x);
}

int main(int argc, char **argv) {
    // Launch the kernal
    hello<<<NUM_BLOCKS, BLOCK_WIDTH>>>();

    // force the printf()s to flush
    cudaDeviceSynchronize();

    printf("that is all\n");

    return 0;
}