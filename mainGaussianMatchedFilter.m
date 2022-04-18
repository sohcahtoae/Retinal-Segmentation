img = imread('Test_Images\20_test.tif');
img = img(:,:,2);
% Mask for the fundus image generation
level = graythresh(img) - 0.06;
mask = im2bw(img,level);
gTruth = imread('Test_manualtiff\20_manual1.tif');
se = strel('disk',4);
mask=imerode(mask,se);
%MatchFilterWithGaussDerivative(image, sigma, yLength, numOfDirections, mask, c_value, threshold value_for_regionprop)
thick_vess = MatchFilterWithGaussDerivative(img, 1.5, 9, 12, mask, 2.3, 30);
%figure, imshow(thick_vess)
thin_vess = MatchFilterWithGaussDerivative(img, 1, 4, 12, mask, 2.3,30);
%figure, imshow(thin_vess)
vess = thick_vess | thin_vess;
%figure, imshow(vess)
[tpr, fpr, acc] = performance(vess, mask, gTruth);
subplot(2,2,1),imshow(gTruth),title('Ground truth'); hold on
subplot(2,2,2),imshow(thick_vess),title('Thick Vessel'); hold on
subplot(2,2,3),imshow(thin_vess),title('Thin Vessel');hold on
subplot(2,2,4),imshow(vess),title('vess');hold off
text(-1700,700,sprintf('True positive rate = %f',tpr))
text(-1000,700,sprintf('False positive rate = %f',fpr))
text(-300,700,sprintf('Accuracy = %f',acc))
