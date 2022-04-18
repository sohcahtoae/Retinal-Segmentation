function[vess] = match_filtered(img,sigma,yLengthForMF, numOfDirections)
% Retinal vessel extraction by matched filter
%
% Inputs:
% img - input imgage
% sigma - scale value
% yLengthForMF - length of neighborhood along y-
% axis of MF
% numOfDirections - number of orientations
%
% Output:
% vess - vessels extracted

if isa(img, 'double')~=1
 img = double(img);
end

[rows, cols] = size(img);
MatchFilterRes(rows, cols, numOfDirections) = 0;
for i = 0:numOfDirections-1
matchFilterKernel = match_filter_kernel_generate(sigma, yLengthForMF, pi/numOfDirections*i);
 MatchFilterRes(:,:,i+1) = conv2(img, matchFilterKernel, 'same');
end
[maxMatchFilterRes] = max(MatchFilterRes, [], 3);
vess = maxMatchFilterRes;
