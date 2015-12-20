clear all
clc
close all
clear memory
input_dir = 'F:\hiral\BE PROJECT\PCA\PCA_based Face Recognition System\TrainDatabase';
input = 'F:\hiral\BE PROJECT\PCA\PCA_based Face Recognition System\TestDatabase';
image_dims = [64 64];
 
filenames = dir(fullfile(input_dir, '*.jpg'));
num_images = numel(filenames);
images = [];
for num = 1:num_images
    filename = fullfile(input_dir, filenames(num).name);
    img = imread(filename);
    img = rgb2gray(img);
    img = imresize(img,image_dims);
    if num == 1
        images = zeros(prod(image_dims), num_images);
    end
    images(:, num) = img(:);
end

% steps 1 and 2: find the mean image and the mean-shifted input images
mean_face = mean(images, 2);
shifted_images = images - repmat(mean_face, 1, num_images);

% steps 3 and 4: calculate the ordered eigenvectors and eigenvalues
[evectors, score, evalues] = princomp(images');

% step 5: only retain the top 'num_eigenfaces' eigenvectors (i.e. the principal components)
num_eigenfaces = 20;
evectors = evectors(:, 1:num_eigenfaces);
 
% step 6: project the images into the subspace to generate the feature vectors
features = evectors' * shifted_images;

prompt = {'Enter test image name:'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines= 1;
def = {'1'};
TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
dbfilenames = dir(fullfile(input, '*.jpg'));
num_imagesdb = numel(dbfilenames);
count = 1;
for num = 1:num_imagesdb
    filename = fullfile(input, dbfilenames(num).name);
inimg = imread(filename);
input_image = rgb2gray(inimg);
input_image = imresize(input_image,image_dims);

% step 7: calculate the similarity of the input to each training image
in = input_image(:);
in=double(in)-mean_face;
feature_vec = evectors' * in;
similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:num_images);

% step 8:  find the image with the highest similarity score
[match_score, match_ix] = max(similarity_score);
match_ix = int2str(match_ix);


if(match_ix == char(TestImage))
    match(count) = num;
    count = count + 1;
end
end

figure;
for i=1: 1: length(match)
    subplot(3,3,i);
    filename = fullfile(input, dbfilenames(match(i)).name);
    img = imread(filename);
    imshow(img);
end