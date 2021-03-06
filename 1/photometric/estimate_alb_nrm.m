function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, ~] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|


warning('off');
for h_ = 1:h
    for w_ = 1:w
        i = reshape(image_stack(h_, w_, :), 1, []);
        I = diag(i);
        
        %disp(size(scriptV))
        %disp(size(transpose(i)))
        
        if shadow_trick == false
            g = mldivide(scriptV, transpose(i));
        end
        
        if shadow_trick == true
            g = mldivide(I*scriptV, I*transpose(i));
        end


        albedo(h_, w_, :) =  norm(g,2);
        normal(h_, w_, :) = g / norm(g,2);
    end
end


% =========================================================================

end

