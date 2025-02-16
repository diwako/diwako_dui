#define LINE(var) \
class Line##var : Line1 {\
    idc = LINE_IDC_START + var - 1;\
    x = QUOTE(PX(0.15 + 2.5 * (var - 1)));\
}

#define BEARING(var,textVar,textSize) \
class Bearing##var : Bearing1 {\
    idc = BEARING_IDC_START+ var - 1 ;\
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
                idc = CONTAINER_IDC;
                x = QUOTE(GET_POS_X);
                y = QUOTE(GET_POS_Y);
                w = QUOTE(GET_POS_W);
                h = QUOTE(GET_POS_H);

                class Controls {
                    class Needle : RscPicture {
                        idc = NEEDLE_IDC;
                        text = "\a3\ui_f\data\map\markers\military\triangle_ca.paa";
                        angle = 180;
                        x = QUOTE(PX(46.25 - 1));
                        y = QUOTE(PY(1.6));
                        w = QUOTE(PX(2));
                        h = QUOTE(PY(1));
                        colorBackground[] = { "profileNamespace getVariable ['igui_bcg_RGB_R', 0]", "profileNamespace getVariable ['igui_bcg_RGB_G', 0]", "profileNamespace getVariable ['igui_bcg_RGB_B', 0]", 0};
                    };
                    class CtrlGroup : RscControlsGroupNoScrollbars {
                        idc = HOLDER_IDC;
                        x = 0;
                        y = 0;
                        w = QUOTE(PX(272.5)); // 360° + 185°
                        h = QUOTE(PY(5));

                        class Controls {
                            class Line1 : RscPicture {
                                idc = LINE_IDC_START + 1;
                                text = "#(argb,8,8,3)color(1,1,1,1)";
                                x = QUOTE(PX(0.15));
                                y = QUOTE(PY(0.6));
                                w = QUOTE(PX(2.2));
                                h = QUOTE(PY(0.3));
                                colorBackground[] = { "profileNamespace getVariable ['igui_bcg_RGB_R', 0]", "profileNamespace getVariable ['igui_bcg_RGB_G', 0]", "profileNamespace getVariable ['igui_bcg_RGB_B', 0]", 0};
                            };
                            LINE(2);
                            LINE(3);
                            LINE(4);
                            LINE(5);
                            LINE(6);
                            LINE(7);
                            LINE(8);
                            LINE(9);
                            LINE(10);
                            LINE(11);
                            LINE(12);
                            LINE(13);
                            LINE(14);
                            LINE(15);
                            LINE(16);
                            LINE(17);
                            LINE(18);
                            LINE(19);
                            LINE(20);
                            LINE(21);
                            LINE(22);
                            LINE(23);
                            LINE(24);
                            LINE(25);
                            LINE(26);
                            LINE(27);
                            LINE(28);
                            LINE(29);
                            LINE(30);
                            LINE(31);
                            LINE(32);
                            LINE(33);
                            LINE(34);
                            LINE(35);
                            LINE(36);
                            LINE(37);
                            LINE(38);
                            LINE(39);
                            LINE(40);
                            LINE(41);
                            LINE(42);
                            LINE(43);
                            LINE(44);
                            LINE(45);
                            LINE(46);
                            LINE(47);
                            LINE(48);
                            LINE(49);
                            LINE(50);
                            LINE(51);
                            LINE(52);
                            LINE(53);
                            LINE(54);
                            LINE(55);
                            LINE(56);
                            LINE(57);
                            LINE(58);
                            LINE(59);
                            LINE(60);
                            LINE(61);
                            LINE(62);
                            LINE(63);
                            LINE(64);
                            LINE(65);
                            LINE(66);
                            LINE(67);
                            LINE(68);
                            LINE(69);
                            LINE(70);
                            LINE(71);
                            LINE(72);
                            LINE(73);
                            LINE(74);
                            LINE(75);
                            LINE(76);
                            LINE(77);
                            LINE(78);
                            LINE(79);
                            LINE(80);
                            LINE(81);
                            LINE(82);
                            LINE(83);
                            LINE(84);
                            LINE(85);
                            LINE(86);
                            LINE(87);
                            LINE(88);
                            LINE(89);
                            LINE(90);
                            LINE(91);
                            LINE(92);
                            LINE(93);
                            LINE(94);
                            LINE(95);
                            LINE(96);
                            LINE(97);
                            LINE(98);
                            LINE(99);
                            LINE(100);
                            LINE(101);
                            LINE(102);
                            LINE(103);
                            LINE(104);
                            LINE(105);
                            LINE(106);
                            LINE(107);
                            LINE(108);
                            LINE(109);
                            class Bearing1 : RscText {
                                idc = BEARING_IDC_START;
                                text = "W";
                                font = "PuristaMedium";
                                sizeEx = QUOTE(PY(2.4));
                                style = 0x02;
                                colorBackground[] = {0,0,0,0};
                                colorText[] = { "profileNamespace getVariable ['igui_bcg_RGB_R', 0]", "profileNamespace getVariable ['igui_bcg_RGB_G', 0]", "profileNamespace getVariable ['igui_bcg_RGB_B', 0]", 0};
                                shadow = 0;
                                x = QUOTE(PX(-0.25));
                                y = QUOTE(PY(2));
                                w = QUOTE(PX(3));
                                h = QUOTE(PY(1.5));
                            };
                            BEARING(2,"285",1.8);
                            BEARING(3,"300",1.8);
                            BEARING(4,"NW",2.4);
                            BEARING(5,"330",1.8);
                            BEARING(6,"345",1.8);
                            BEARING(7,"N",2.4);
                            BEARING(8,"015",1.8);
                            BEARING(9,"030",1.8);
                            BEARING(10,"NE",2.4);
                            BEARING(11,"060",1.8);
                            BEARING(12,"075",1.8);
                            BEARING(13,"E",2.4);
                            BEARING(14,"105",1.8);
                            BEARING(15,"120",1.8);
                            BEARING(16,"SE",2.4);
                            BEARING(17,"150",1.8);
                            BEARING(18,"165",1.8);
                            BEARING(19,"S",2.4);
                            BEARING(20,"195",1.8);
                            BEARING(21,"210",1.8);
                            BEARING(22,"SW",2.4);
                            BEARING(23,"240",1.8);
                            BEARING(24,"255",1.8);
                            BEARING(25,"W",2.4);
                            BEARING(26,"285",1.8);
                            BEARING(27,"300",1.8);
                            BEARING(28,"NW",2.4);
                            BEARING(29,"330",1.8);
                            BEARING(30,"345",1.8);
                            BEARING(31,"N",2.4);
                            BEARING(32,"015",1.8);
                            BEARING(33,"030",1.8);
                            BEARING(34,"NO",2.4);
                            BEARING(35,"060",1.8);
                            BEARING(36,"075",1.8);
                            BEARING(37,"O",2.4);
                        };
                    };
                };
            };
        };
    };

};
