# Speaker Recognition

My master thesis about text-independent speaker identification closed-set. 

Below are the methods:
1) Recording data of 5 people read 1000 words (novel).
2) Segmentation and cleaning recording data.
3) Normalize data using min-max normalization to get the same amplitude range for all speakers.
4) Combine all speakers data and divide to be 5 segments randomly.
5) Extract data using mfcc algorithm.
6) Train and test 5 segments data alternately (k-fold cross validation method) using Gaussian Mixture Model and Vector Quantization.
7) Evaluate and compare result.

Gaussian Mixture Model yielded the best result based on data of 5 speakers.
