function J = pauwes_param(parm);

dt=10^-4;
N=8/dt;  
open PVWIND.slx;
set_param('PVWIND/kp','Value','parm(1)');
set_param('PVWIND/ki','Value','parm(2)');


options = simset('SrcWorkspace','current');
S = sim('PVWIND',[],options);



t = out.Time;
r1 = out.Data(:,1);
y1 = out.Data(:,2);
r2 = out.Data(:,3);
y2 = out.Data(:,4);
r3 = out.Data(:,5);
y3 = out.Data(:,6);
r4 = out.Data(:,7);
y4 = out.Data(:,8);


assignin('base','r1',r1);
assignin('base','y1',y1);
assignin('base','r2',r2);
assignin('base','y2',y2);
assignin('base','r3',r3);
assignin('base','y3',y3);
assignin('base','r4',r4);
assignin('base','y4',y4);

N=length(t);
% %%%mean squared error
J = 1/N*sum(8*(r1(:)-y1(:)).^2+5*(r2(:)-y2(:)).^2+2*(r3(:)-y3(:)).^2+3*(r4(:)-y4(:)).^2);

% integral absolute error
%J = sum(abs(r(:)-y(:)))

% integral squared error
%J = sum(abs(r(:)-y(:)).^2)


% integral absolute time error
%J = sum(t.*abs(r(:)-y(:))) 


%minimize error and control effort
% E = 1/N*sum((r(:)-y(:)).^2)  
% U = 1/N*sum(u(:).^2)
% J = E + U