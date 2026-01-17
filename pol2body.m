function body = pol2body(uhel,vzdalenost,param)
%Funkce pro výpočet bodů podle úhlu a vzdálenosti

if vzdalenost>=0 && vzdalenost<param.r_bull_small % Inner bulls eye
    body=50;
    return;
end
if vzdalenost>=0.635 && vzdalenost<param.r_bull_small % Outer bulls eye
    body=25;
    return;
end
if uhel>=0 && uhel<9 % Segment 6 - prvni pulka
    body=6;
end
if uhel>=9 && uhel<18+9 % Segment 13
    body=13;
end
if uhel>=18+9 && uhel<2*18+9 % Segment 4
    body=4;
end
if uhel>=2*18+9 && uhel<3*18+9 % Segment 18
    body=18;
end
if uhel>=3*18+9 && uhel<4*18+9 % Segment 1
    body=1;
end
if uhel>=4*18+9 && uhel<5*18+9 % Segment 20
    body=20;
end
if uhel>=5*18+9 && uhel<6*18+9 % Segment 5
    body=5;
end
if uhel>=6*18+9 && uhel<7*18+9 % Segment 12
    body=12;
end
if uhel>=7*18+9 && uhel<8*18+9 % Segment 9
    body=9;
end
if uhel>=8*18+9 && uhel<9*18+9 % Segment 14
    body=14;
end
if uhel>=9*18+9 && uhel<10*18+9 % Segment 11
    body=11;
end
if uhel>=10*18+9 && uhel<11*18+9 % Segment 8
    body=8;
end
if uhel>=11*18+9 && uhel<12*18+9 % Segment 16
    body=16;
end
if uhel>=12*18+9 && uhel<13*18+9 % Segment 7
    body=7;
end
if uhel>=13*18+9 && uhel<14*18+9 % Segment 19
    body=19;
end
if uhel>=14*18+9 && uhel<15*18+9 % Segment 3
    body=3;
end
if uhel>=15*18+9 && uhel<16*18+9 % Segment 17
    body=17;
end
if uhel>=16*18+9 && uhel<17*18+9 % Segment 2
    body=2;
end
if (uhel>=17*18+9&&uhel<18*18+9) % Segment 15
    body=15;
end
if (uhel>=18*18+9&&uhel<19*18+9) % Segment 10
    body=10;
end
if (uhel>=19*18+9&&uhel<=360) % Segment 6 - druha pulka
    body=6;
end
if vzdalenost>param.r_double_out %Hod mimo bodovanou zonu
    body=0;
end
if (vzdalenost>param.r_triple_in && vzdalenost<param.r_triple_out) %Tripple pole - hozený segment se ztrojnasobí
    body=body*3;
end
if (vzdalenost>param.r_double_in && vzdalenost<param.r_double_out) %Double - hozený segment se zdojnasobi
    body=body*2;
end