function [x,y] = index2cm(index,GRID,polosirka)
% Prevadi index z gridu na fyzickou polohu v teci
% index ...... dvojrozmerny vektor
% GRID ....... pocet vzrokovacich bodu
% polosirka... pulka sirky analyzovaneho rozsahu [cm]

lambda = (GRID-index(2))/(GRID-1);
x = lambda*(-polosirka) + (1-lambda)*polosirka;

lambda = 1-(GRID-index(1))/(GRID-1);
y = lambda*(-polosirka) + (1-lambda)*polosirka;
