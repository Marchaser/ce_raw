clear;
csvfolder = 'D:\data\cex';
lTOTC1 = csvread([csvfolder '\lTOTC1_projection.csv'],1,0);
lTOTC2 = csvread([csvfolder '\lTOTC2_projection.csv'],1,0);
lTOTC = csvread([csvfolder '\lTOTC_projection.csv'],1,0);
lrPCE = csvread([csvfolder '\lrPCE_projection.csv'],1,0);

point_lTOTC1 = lTOTC1(:,1);
sd_lTOTC1 = lTOTC1(:,2);
point_lTOTC2 = lTOTC2(:,1);
sd_lTOTC2 = lTOTC2(:,2);
point_lTOTC = lTOTC(:,1);
sd_lTOTC = lTOTC(:,2);
point_lrPCE = lrPCE(:,1);
sd_lrPCE = lrPCE(:,2);

quarter = 1:length(lTOTC1(:,1));

figBench = figure; clf; hold on;
plot(quarter,point_lTOTC1,'w');
plot(quarter,point_lTOTC1+sd_lTOTC1,'w');
plot(quarter,point_lTOTC1-sd_lTOTC1,'w');
plot(quarter,point_lTOTC2,'w');
plot(quarter,point_lTOTC2+sd_lTOTC2,'w');
plot(quarter,point_lTOTC2-sd_lTOTC2,'w');
plot(quarter,point_lTOTC,'w');
plot(quarter,point_lTOTC+sd_lTOTC,'w');
plot(quarter,point_lTOTC-sd_lTOTC,'w');
plot(quarter,point_lrPCE,'w');
plot(quarter,point_lrPCE+sd_lrPCE,'w');
plot(quarter,point_lrPCE-sd_lrPCE,'w');
axesBench = gca;

figure;clf;hold on;
% plot(quarter, point, 'k-');
% plot(quarter, pointPlusSd,'b--');
% plot(quarter, pointMinusSd,'b--');
copyaxes(axesBench,gca);
confplot(quarter,point_lTOTC1,sd_lTOTC1);
hXLabel = xlabel('Quarters');
hYLabel= ylabel('');
hTitle= title('');
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel hYLabel], ...
    'FontName'   , 'AvantGarde');
set([hXLabel hYLabel]  , ...
    'FontSize'   , 18          );
set( hTitle                    , ...
    'FontSize'   , 18          , ...
    'FontWeight' , 'bold'      );
set(gca, ...
  'Box'         , 'off'     , ...
  'FontSize'    , 18, ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );

figure;clf;hold on;
% plot(quarter, point, 'k-');
% plot(quarter, pointPlusSd,'b--');
% plot(quarter, pointMinusSd,'b--');
copyaxes(axesBench,gca);
confplot(quarter,point_lTOTC2,sd_lTOTC2);
hXLabel = xlabel('Quarters');
hYLabel= ylabel('');
hTitle= title('');
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel hYLabel], ...
    'FontName'   , 'AvantGarde');
set([hXLabel hYLabel]  , ...
    'FontSize'   , 18          );
set( hTitle                    , ...
    'FontSize'   , 18          , ...
    'FontWeight' , 'bold'      );
set(gca, ...
  'Box'         , 'off'     , ...
  'FontSize'    , 18, ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );

figure;clf;hold on;
% plot(quarter, point, 'k-');
% plot(quarter, pointPlusSd,'b--');
% plot(quarter, pointMinusSd,'b--');
copyaxes(axesBench,gca);
confplot(quarter,point_lTOTC,sd_lTOTC);
hXLabel = xlabel('Quarters');
hYLabel= ylabel('');
hTitle= title('');
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel hYLabel], ...
    'FontName'   , 'AvantGarde');
set([hXLabel hYLabel]  , ...
    'FontSize'   , 18          );
set( hTitle                    , ...
    'FontSize'   , 18          , ...
    'FontWeight' , 'bold'      );
set(gca, ...
  'Box'         , 'off'     , ...
  'FontSize'    , 18, ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );

figure;clf;hold on;
% plot(quarter, point, 'k-');
% plot(quarter, pointPlusSd,'b--');
% plot(quarter, pointMinusSd,'b--');
copyaxes(axesBench,gca);
confplot(quarter,point_lrPCE,sd_lrPCE);
hXLabel = xlabel('Quarters');
hYLabel= ylabel('');
hTitle= title('');
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel hYLabel], ...
    'FontName'   , 'AvantGarde');
set([hXLabel hYLabel]  , ...
    'FontSize'   , 18          );
set( hTitle                    , ...
    'FontSize'   , 18          , ...
    'FontWeight' , 'bold'      );
set(gca, ...
  'Box'         , 'off'     , ...
  'FontSize'    , 18, ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );