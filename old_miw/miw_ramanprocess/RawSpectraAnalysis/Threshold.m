function [ output ] = Threshold( input , value, Mode )
%UNTITLED16 Summary of this function goes here
%   Mode
%  1 = just positive
%  2 = either side
%  3 = just negative   - note need to give a negative value
l = max(size(input));

if nargin < 3
    Mode = 1 ;
end
switch Mode
    case 1
            for i = 1:l
               if(input(i) < value)
                   output(i) = 0;
               else
                   output(i) = input(i);
               end
            end
    case 2
        value = abs(value);
        for i = 1:l
           if(input(i) > value || input(i) < (-1*value))
               output(i) = input(i);
           else
               output(i) = 0;
           end
        end
    case 3
       for i = 1:l
           if(input(i) > value)
               output(i) = 0;
           else
               output(i) = input(i);
           end
        end
    otherwise
        warning('no type for thresholding');
        output = input;

end

