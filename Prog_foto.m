% Programa para a cadeira de Fotogrametria Terrestre
% Ano lectivo 2009/2010
% Leonor Andrade Vila Lobos n�33292

echo off
clear all
clc
format short g

% Abrir o ficheiro
fid = fopen ('Prog_foto.txt', 'w');

% 1� PARTE
% Determinar os oito par�metros da transforma��o perspectiva entre o plano 
% objecto "p�tio do C8" e o plano imagem "C8-20M"

% Dimens�o real dos quadrados (m)
d = 0.88;

% Dimens�o do pixel da imagem (m)
p = 5e-6;

% Coordenadas imagem dos 4 pontos n�o colineares
x1 = 690*p;
y1 = 1172*p;
x2 = 2488*p;
y2 = 1734*p;
x3 = 1497*p;
y3 = 840*p;
x4 = 2475*p;
y4 = 849*p;

% Coordenadas objecto dos 4 pontos n�o colineares
X1 = 3*d;
Y1 = 2*d;
X2 = 13*d;
Y2 = 1*d;
X3 = 6*d;
Y3 = 7*d;
X4 = 12*d;
Y4 = 9*d;

% Matriz dos coeficientes dos par�metros e termo independente
%      e0    e1  e2    f0    f1  f2  g1  g2  ti
P = [-X1*x1  x1   0  -X1*y1  y1   0   1   0  X1
     -Y1*x1   0  x1  -Y1*y1   0  y1   0   1  Y1
     -X2*x2  x2   0  -X2*y2  y2   0   1   0  X2
     -Y2*x2   0  x2  -Y2*y2   0  y2   0   1  Y2
     -X3*x3  x3   0  -X3*y3  y3   0   1   0  X3
     -Y3*x3   0  x3  -Y3*y3   0  y3   0   1  Y3
     -X4*x4  x4   0  -X4*y4  y4   0   1   0  X4
     -Y4*x4   0  x4  -Y4*y4   0  y4   0   1  Y4];
 
% Resolu��o da matriz P
P = rref(P);

% 2� PARTE
% Determinar as coordenadas objecto de v�rios pontos novos

% Coordenadas imagem dos novos pontos
x_A = 910*p;
y_A = 1353*p;
x_B = 1864*p;
y_B = 1090*p;
x_C = 1797*p;
y_C = 440*p;
x_D = 2768*p;
y_D = 1067*p;
x_E = 831*p;
y_E = 727*p;
x_F = 2097*p;
y_F = 1496*p;

% Vectores com as coordenadas imagem dos novos pontos
x = [x_A; x_B; x_C; x_D; x_E; x_F];
y = [y_A; y_B; y_C; y_D; y_E; y_F];

% Oito par�metros de transforma��o
e0 = P(1,9);
e1 = P(2,9);
e2 = P(3,9);
f0 = P(4,9);
f1 = P(5,9);
f2 = P(6,9);
g1 = P(7,9);
g2 = P(8,9);

% Imprimir para o ficheiro
fprintf (fid, '\nCoordenadas objecto dos pontos:\n\n');

% Ciclo e f�rmulas de transforma��o
for i = 1:6
    
   X(i) = (e1*x(i)+f1*y(i)+g1)/(e0*x(i)+f0*y(i)+1);
   Y(i) = (e2*x(i)+f2*y(i)+g2)/(e0*x(i)+f0*y(i)+1);
   
   % Formato das coordenadas a imprimir
   fprintf (fid, '%6.3f %6.3f\n', X(i), Y(i));
   
end

% Fechar o ficheiro
st = fclose (fid);