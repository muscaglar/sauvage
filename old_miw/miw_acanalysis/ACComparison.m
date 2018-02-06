%Comparrison Of all 3 models

ACReal = ACLoad;
ACSpice = ACSpiceLoad;

%AC = ParallelSimulate( 10e9, 5e-12, 5000 );
AC = ParallelSimulate( 300e6, 5e-12, 5000 );
%AC = SeriesSimulate( 10e3, 100e-12, 5000 );

subplot(2,1,1);
%Plot the magnitude
hold off;
plot(ACSpice(:,1),ACSpice(:,2),'b')
hold on;
plot(ACReal(:,1),ACReal(:,2),'r')
plot(AC(:,1),AC(:,2),'k')

subplot(2,1,2);
%Plot the Phase
hold off;
plot(ACSpice(:,1),ACSpice(:,3),'b')
hold on;
plot(ACReal(:,1),ACReal(:,3),'r')
plot(AC(:,1),AC(:,3),'k')