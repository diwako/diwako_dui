#define LINE(var, idcValue) \
class Line##var : Line1 {\
    idc = idcValue;\
    x = QUOTE(PX(0.15 + 2.5 * (var - 1)));\
}

#define BEARING(var,textVar,textSize, idcValue) \
class Bearing##var : Bearing1 {\
    idc = idcValue;\
    sizeEx = QUOTE(PY(textSize));\
    x = QUOTE(PX(-0.25 + 7.5 * (var - 1)));\
    text = textVar;\
}

class RscControlsGroupNoScrollbars;
class RscPicture;
class RscText;
class RscTitles {
    class GVAR(Compass) {
        idd = -1;
        duration = 1e10;
        onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Compass),_this select 0)];);
        class Controls {
            class CtrlGroup : RscControlsGroupNoScrollbars {
                idc = 7000;
                x = QUOTE(0.5 - PX(46.25));
                y = QUOTE(PY(103) + safeZoneY);
                w = QUOTE(PX(92.5));
                h = QUOTE(PY(5));

                class Controls {
                    class Needle : RscPicture {
                        idc = 7001;
                        text = "\a3\ui_f\data\map\markers\military\triangle_ca.paa";
                        angle = 180;
                        x = QUOTE(PX(46.25 - 1));
                        y = QUOTE(PY(1.6));
                        w = QUOTE(PX(2));
                        h = QUOTE(PY(1));
                    };
                    class CtrlGroup : RscControlsGroupNoScrollbars {
                        idc = 7100;
                        x = 0;
                        y = 0;
                        w = QUOTE(PX(272.5)); // 360° + 185°
                        h = QUOTE(PY(5));

                        class Controls {
                            class Line1 : RscPicture {
                                idc = 7101;
                                text = "#(argb,8,8,3)color(1,1,1,1)";
                                x = QUOTE(PX(0.15));
                                y = QUOTE(PY(0.6));
                                w = QUOTE(PX(2.2));
                                h = QUOTE(PY(0.3));
                            };
                            LINE(2,7102);
                            LINE(3,7103);
                            LINE(4,7104);
                            LINE(5,7105);
                            LINE(6,7106);
                            LINE(7,7107);
                            LINE(8,7108);
                            LINE(9,7109);
                            LINE(10,7110);
                            LINE(11,7111);
                            LINE(12,7112);
                            LINE(13,7113);
                            LINE(14,7114);
                            LINE(15,7115);
                            LINE(16,7116);
                            LINE(17,7117);
                            LINE(18,7118);
                            LINE(19,7119);
                            LINE(20,7120);
                            LINE(21,7121);
                            LINE(22,7122);
                            LINE(23,7123);
                            LINE(24,7124);
                            LINE(25,7125);
                            LINE(26,7126);
                            LINE(27,7127);
                            LINE(28,7128);
                            LINE(29,7129);
                            LINE(30,7130);
                            LINE(31,7131);
                            LINE(32,7132);
                            LINE(33,7133);
                            LINE(34,7134);
                            LINE(35,7135);
                            LINE(36,7136);
                            LINE(37,7137);
                            LINE(38,7138);
                            LINE(39,7139);
                            LINE(40,7140);
                            LINE(41,7141);
                            LINE(42,7142);
                            LINE(43,7143);
                            LINE(44,7144);
                            LINE(45,7145);
                            LINE(46,7146);
                            LINE(47,7147);
                            LINE(48,7148);
                            LINE(49,7149);
                            LINE(50,7150);
                            LINE(51,7151);
                            LINE(52,7152);
                            LINE(53,7153);
                            LINE(54,7154);
                            LINE(55,7155);
                            LINE(56,7156);
                            LINE(57,7157);
                            LINE(58,7158);
                            LINE(59,7159);
                            LINE(60,7160);
                            LINE(61,7161);
                            LINE(62,7162);
                            LINE(63,7163);
                            LINE(64,7164);
                            LINE(65,7165);
                            LINE(66,7166);
                            LINE(67,7167);
                            LINE(68,7168);
                            LINE(69,7169);
                            LINE(70,7170);
                            LINE(71,7171);
                            LINE(72,7172);
                            LINE(73,7173);
                            LINE(74,7174);
                            LINE(75,7175);
                            LINE(76,7176);
                            LINE(77,7177);
                            LINE(78,7178);
                            LINE(79,7179);
                            LINE(80,7180);
                            LINE(81,7181);
                            LINE(82,7182);
                            LINE(83,7183);
                            LINE(84,7184);
                            LINE(85,7185);
                            LINE(86,7186);
                            LINE(87,7187);
                            LINE(88,7188);
                            LINE(89,7189);
                            LINE(90,7190);
                            LINE(91,7191);
                            LINE(92,7192);
                            LINE(93,7193);
                            LINE(94,7194);
                            LINE(95,7195);
                            LINE(96,7196);
                            LINE(97,7197);
                            LINE(98,7198);
                            LINE(99,7199);
                            LINE(100,7200);
                            LINE(101,7201);
                            LINE(102,7202);
                            LINE(103,7203);
                            LINE(104,7204);
                            LINE(105,7205);
                            LINE(106,7206);
                            LINE(107,7207);
                            LINE(108,7208);
                            LINE(109,7209);
                            class Bearing1 : RscText {
                                idc = 7301;
                                text = "W";
                                font = "PuristaMedium";
                                sizeEx = QUOTE(PY(2.4));
                                style = 0x02;
                                colorBackground[] = {0,0,0,0};
                                colorText[] = {1,1,1,1};
                                shadow = 0;
                                x = QUOTE(PX(-0.25));
                                y = QUOTE(PY(2));
                                w = QUOTE(PX(3));
                                h = QUOTE(PY(1.5));
                            };
                            BEARING(2,"285",1.8,7302);
                            BEARING(3,"300",1.8,7303);
                            BEARING(4,"NW",2.4,7304);
                            BEARING(5,"330",1.8,7305);
                            BEARING(6,"345",1.8,7306);
                            BEARING(7,"N",2.4,7307);
                            BEARING(8,"015",1.8,7308);
                            BEARING(9,"030",1.8,7309);
                            BEARING(10,"NE",2.4,7310);
                            BEARING(11,"060",1.8,7311);
                            BEARING(12,"075",1.8,7312);
                            BEARING(13,"E",2.4,7313);
                            BEARING(14,"105",1.8,7314);
                            BEARING(15,"120",1.8,7315);
                            BEARING(16,"SE",2.4,7316);
                            BEARING(17,"150",1.8,7317);
                            BEARING(18,"165",1.8,7318);
                            BEARING(19,"S",2.4,7319);
                            BEARING(20,"195",1.8,7320);
                            BEARING(21,"210",1.8,7321);
                            BEARING(22,"SW",2.4,7322);
                            BEARING(23,"240",1.8,7323);
                            BEARING(24,"255",1.8,7324);
                            BEARING(25,"W",2.4,7325);
                            BEARING(26,"285",1.8,7326);
                            BEARING(27,"300",1.8,7327);
                            BEARING(28,"NW",2.4,7328);
                            BEARING(29,"330",1.8,7329);
                            BEARING(30,"345",1.8,7330);
                            BEARING(31,"N",2.4,7331);
                            BEARING(32,"015",1.8,7332);
                            BEARING(33,"030",1.8,7333);
                            BEARING(34,"NO",2.4,7334);
                            BEARING(35,"060",1.8,7335);
                            BEARING(36,"075",1.8,7336);
                            BEARING(37,"O",2.4,7337);
                        };
                    };
                };
            };
        };
    };

};
