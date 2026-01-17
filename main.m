% Program doporučí bod pro míření při šipkách pro maximální bodový zisk
% Vstupem jsou hody konkrétního uživatele (či simulovaná data)
% Tato data se proloží Gaussovou 2D pravděpodobnostní funkcí (metodou maximální věrohodnosti)
% a na základě tohoto modelu se konvolucí s terčem určí mapa očekávaných
% bodových zisků. Program najde maximální hodnotu a její souřadnice, neboli místo, kam mířit.

% 2026 Pavel Rajmic (VUT v Brně), Pavlína Jelínková (Gymnázium Vídeňská, Brno)
% Vniklo v rámci řešení SOČ

close all
clear all

%% Nastaveni
GRID = 201;  %liche cislo, aby prostredni vzorek vysel vzdycky doprostred terce
sirka_zobrazeni = 20;  %pro graf, v centimetrech

%% Načtení hodů z .txt souboru
% prvni sloupec...horizontalni souradnice (x) v centimetrech
% druhy sloupec...vertikalni souradnice (y) v centimetrech

% hody = nactihody("hody-Jelinkova.txt");
hody = nactihody("hody-Horis.txt");
% hody = nactihody("hody-umely_dobry.txt");
% hody = nactihody("hody-umely_vychyleny.txt");

n = size(hody,1);

%% Načtení parametrů terče
load parametry_terce.mat
param_terce.r_bull_big = r_bull_big;
param_terce.r_bull_small = r_bull_small;
param_terce.r_double_in = r_double_in;
param_terce.r_double_out = r_double_out;
param_terce.r_triple_in = r_triple_in;
param_terce.r_triple_out = r_triple_out;

%% Odhad parametrů gaussovky
mi = sum(hody)/n;
d = hody - mi;
Sigma(1,1) = sum(d(:,1).^2)/n;
Sigma(1,2) = sum(d(:,1).*d(:,2))/n;
Sigma(2,1) = Sigma(1,2);
Sigma(2,2) = sum(d(:,2).^2)/n;

invSigma = inv(Sigma);
detSigma = det(Sigma);

%% Vykreslení hodů a proložené gaussovky
vykresliGausse(mi,invSigma,detSigma,sirka_zobrazeni)
vykresliTerc(param_terce)
% hody
plot3(hody(:,1), hody(:,2), zeros(n,1), 'k.', 'MarkerSize', 10);
set(gca,'XLim',[-sirka_zobrazeni sirka_zobrazeni])
set(gca,'YLim',[-sirka_zobrazeni sirka_zobrazeni])

%% Alokace, inicializace proměnných pro výpočty

%vzorkování terče
terc = zeros(GRID,GRID); %indexy pak budou probíhat 1 až GRID
for cnt_x = 0:(GRID-1) 
    for cnt_y = 0:(GRID-1)
        souradnice_x = ...
            -param_terce.r_double_out + 2*param_terce.r_double_out*cnt_x/(GRID-1);
        souradnice_y = ...
            -param_terce.r_double_out + 2*param_terce.r_double_out*cnt_y/(GRID-1);
        [vzd, uhel] = kart2pol(souradnice_x, souradnice_y);
        terc(cnt_x+1,cnt_y+1) = pol2body(uhel,vzd,param_terce);
    end
end
terc = rot90(flipud(terc),-1); %srovnani smeru indexace obrazku s kartezskou geometrii terce
%graficka kontrola:
figure
do = param_terce.r_double_out;
imagesc('XData',linspace(-do,do,GRID),'YData',linspace(-do,do,GRID),'CData',terc)
colorbar
axis equal tight
title(['Terč vzorkovaný na síti ' num2str(GRID) ' krát ' num2str(GRID) ' bodů'])
xlabel('x [cm]')
ylabel('y [cm]')

%vzorkování gaussovky
g = zeros(GRID,GRID); %indexy pak budou probíhat 1 až GRID
for cnt_x = 0:(GRID-1) 
    for cnt_y = 0:(GRID-1)
        souradnice_x = ...
            -param_terce.r_double_out + 2*param_terce.r_double_out*cnt_x/(GRID-1);
        souradnice_y = ...
            -param_terce.r_double_out + 2*param_terce.r_double_out*cnt_y/(GRID-1);
        g(cnt_x+1,cnt_y+1) = gauss2d([souradnice_x, souradnice_y],mi,invSigma,detSigma);
    end
end
soucet_vzorku_gauss = sum(g,"all");  %cislo, kterym je pak potreba normalizovat mapu (zajisti, ze celkova pravdepodobnost bude 1)

g = rot90(flipud(g),-1); %srovnani smeru indexace obrazku s kartezskou geometrii terce
%graficka kontrola:
figure
imagesc('XData',linspace(-do,do,GRID),'YData',linspace(-do,do,GRID),'CData',g)
colorbar
axis equal tight
title(['Gaussovo rozdělení vzorkované na síti ' num2str(GRID) ' krát ' num2str(GRID) ' bodů'])
xlabel('x [cm]')
ylabel('y [cm]')

%% Výpočet mapy očekávaných bodových zisků
% pro každý bod z gridu se spočítá, kolik bodů by statisticky získal hráč, kdyby tam mířil
mapa = zeros(GRID,GRID);
mapa = conv2(terc,g,'same')/soucet_vzorku_gauss;
figure
% imagesc(mapa)
imagesc('XData',linspace(-do,do,GRID),'YData',linspace(-do,do,GRID),'CData',mapa)
colorbar
axis equal tight
title(['Očekávaný bodový zisk při míření na bod z mapy'])
hold on 
vykresliTerc(param_terce)

%% Nalezení maxima
mapa_pro_max = flipud(mapa);
[maximum, index_maxima] = max(mapa_pro_max,[],"all","linear");
maximum
%prevod indexu maxima na indexy v navzorkovanem terci
index_maxima_x = mod(index_maxima,GRID); %jede po sloupcich
if index_maxima_x == 0
    index_maxima_x = GRID;
end
index_maxima_y = ceil(index_maxima/GRID);
%kontrola
% maximum == mapa_pro_max(index_maxima_x,index_maxima_y)

%% Převod indexu maxima na polohu v terči + zobrazení
[maximum_x_cm,maximum_y_cm] = index2cm([index_maxima_x index_maxima_y],GRID,param_terce.r_double_out)
plot(maximum_x_cm,maximum_y_cm,'r+','LineWidth',2)
