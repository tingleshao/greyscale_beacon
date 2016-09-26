addpath(genpath('gabor_feature'))

img = imread('lenna.jpg');
imshow(img);

u = 5;
v = 8;
m = 39;
n = 39;

gaborArray = gaborFilterBank(5,8,39,39);
[featureVector, gabormag] = gaborFeatures(img,gaborArray,4,4);

numCols = 128;
numRows = 128;
gabormag = gabormag * 255;

X = 1:numCols;
Y = 1:numRows;
[X,Y] = meshgrid(X,Y);
featureSet = cat(3,gabormag,X);
featureSet = cat(3,featureSet,Y);

numPoints = numRows*numCols;
X = reshape(featureSet,numRows*numCols,[]);


coeff = pca(X);
feature2DImage = reshape(X*coeff(:,1),numRows,numCols);
figure
imshow(feature2DImage,[])

L = kmeans(X,5,'Replicates',5);

L = reshape(L,[numRows numCols]);
figure
imshow(label2rgb(L'))