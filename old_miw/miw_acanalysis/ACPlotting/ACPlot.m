function [ output_args ] = ACPlot( AC , AC2, AC3, AC4 )
%ACPLOT Summary of this function goes here
%   Detailed explanation goes here

subplot(1,2,1)
hold off;
semilogx(AC(:,1),AC(:,2))

subplot(1,2,2)
hold off;
semilogx(AC(:,1),AC(:,3))

if nargin > 1
    subplot(1,2,1)
    hold all;
    semilogx(AC2(:,1),AC2(:,2))
    
    subplot(1,2,2)
    hold all;
    semilogx(AC2(:,1),AC2(:,3))
    if nargin > 2
        subplot(1,2,1)
        hold all;
        semilogx(AC3(:,1),AC3(:,2))
        
        subplot(1,2,2)
        hold all;
        semilogx(AC3(:,1),AC3(:,3))
    end
    if nargin > 3
        subplot(1,2,1)
        hold all;
        semilogx(AC4(:,1),AC4(:,2))
        
        subplot(1,2,2)
        hold all;
        semilogx(AC4(:,1),AC4(:,3))
    end
end

end

