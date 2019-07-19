# include <stdio.h>

__global__ void cube(float *d_in, float *d_out) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    float f = d_in[idx];
    d_out[idx] = f * f *f;
}

int main() {
    const int ARRAY_SIZE = 4000;
    const int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

    float h_in[ARRAY_SIZE];
    for(int i=0; i < ARRAY_SIZE; i++) {
        h_in[i] = float(i);
    }
    float h_out[ARRAY_SIZE];

    // declare memory pointers
    float * d_in;
    float * d_out;

    // allocating memory for GPU variables
    cudaMalloc((void **) &d_in, ARRAY_BYTES);
    cudaMalloc((void **) &d_out, ARRAY_BYTES);

    cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);
    
    cube<<<4, 1000>>>(d_in, d_out);

    cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

    for(int i=0; i < ARRAY_SIZE; i++) {
        printf("%f", h_out[i]);
        printf(((i%4) != 3) ? "\t" : "\n");
    }

    cudaFree(d_in);
    cudaFree(d_out);

    return 0;
}