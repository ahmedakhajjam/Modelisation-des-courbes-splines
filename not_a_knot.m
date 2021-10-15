%PFE MASTER-AHMED AKHAJJAM
%2020/2021
function spline=conditions_limites_libre(cox,coy);
% saisie des points pas lesquels la spline doit passer
P=[ 0 1.5;
   1 2;
   2 1;
   3 0.5;
   4 4;
   5 3;
   6 1;
   7 1];
%P=[cox coy];
spline.coord=P;
% nombre de points
n=length(P);
% initialisation de la matrice de passage points/points de contrôle
spline.M=zeros(n+2,n+2);
% corps de la matrice
k=1;
for i=2:n+1
spline.M(i,k)=1;
spline.M(i,k+1)=4;
spline.M(i,k+2)=1;
k=k+1;
end
% extension du vecteur de points
u=[ 0 0;
   0 1.5;
   1 2;
   2 1;
   3 0.5;
   4 4;
   5 3;
   6 1;
   7 1;
    0 0];
% conditions limites de bord libre
spline.M(1,1)=-1;
spline.M(1,2)=4; 
spline.M(1,3)=-6;
spline.M(1,4)=4;
spline.M(1,5)=-1;
%
spline.M(n+2,n-2)=-1;
spline.M(n+2,n-1)=4;
spline.M(n+2,n)=-6; 
spline.M(n+2,n+1)=4;
spline.M(n+2,n+2)=-1;
% matrice des points de contrôle
spline.Q=zeros(n+2,2);
spline.Q=6*inv(spline.M)*u;
% tracé des points et des points de données
figure(1);
hold on;
plot(P(:,1),P(:,2),'ko','linewidth',1.5);
xlabel('x');ylabel('y');
% tracé des points de contrôle
figure(1);
 hold on;
 plot(spline.Q(:,1),spline.Q(:,2),'ro-','linewidth',1.5);
% paramètre intrinsèque t
spline.A=[-1 3 -3 1;3 -6 3 0;-3 0 3 0;1 4 1 0];
% tracé de la spline
k=1;
for i=1:n-1 % itération sur les éléments
for t=[0:0.01:1] % échantillonage choisi
x=1/6*[t^3 t^2 t 1]*spline.A*[spline.Q(i,1);spline.Q(i+1,1);spline.Q(i+2,1);spline.Q(i+3,1)];
y=1/6*[t^3 t^2 t 1]*spline.A*[spline.Q(i,2);spline.Q(i+1,2);spline.Q(i+2,2);spline.Q(i+3,2)];
X(:,k)=x;
Y(:,k)=y;
k=k+1;
end
end
figure(1);
hold on;
plot(X,Y,'-b','linewidth',1.5);
grid on
box on
xlabel('x ')
ylabel('y ')
legend('points de données','points de controle','courbe spline')