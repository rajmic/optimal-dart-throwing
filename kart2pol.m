function [vzd, uhel] = kart2pol(x,y)
% kartezske na polarni
% uhel 0 odpovida prave casti horizontalni osy

vzd = sqrt(x*x + y*y);
uhel = atan2(y, x) * 180 / pi; %vraci hodnoty z intervalu -180 az 180
if (uhel < 0)
    uhel = uhel + 360; %po teto uprave jsou uhly od 0 do 360
end