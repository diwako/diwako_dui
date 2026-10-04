class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class dui_attributes {
                displayName = CSTRING(Options);
                collapsed = 1;
                class Attributes {
                    class unitType {
                        displayName = CSTRING(unitType);
                        tooltip = CSTRING(unitType_desc);
                        property = "dui_unitType";
                        control = "combo";
                        expression = "if (local _this && _value isNotEqualTo '') then {_this setVariable ['dui_unitType', _value, true];};";
                        defaultValue = "''";
                        validate = "none";
                        unique = 0;
                        typeName = "STRING";
                        class values {
                            class None {
                                name = "$STR_A3_KeyframeAnimation_OrientationMode_none";
                                value = "";
                            };
                            class SQL {
                                name = "$STR_b_soldier_sl_f0";
                                value = "sql";
                            };
                            class Medic {
                                name = "$STR_b_medic_f0";
                                value = "medic";
                            };
                            class Auto_Rifleman {
                                name = "$STR_b_soldier_ar_f0";
                                value = "auto_rifleman";
                            };
                            class AT_gunner {
                                name = "$STR_b_soldier_lat_f0";
                                value = "at_gunner";
                            };
                            class Engineer {
                                name = "$STR_b_soldier_repair_f0";
                                value = "engineer";
                            };
                            class Explosive_Specialist {
                                name = "$STR_b_soldier_exp_f0";
                                value = "explosive_specialist";
                            };
                            class Rifleman {
                                name = "$STR_dn_rifleman";
                                value = "rifleman";
                            };
                            class Officer {
                                name = "$STR_b_officer_f0";
                                value = "officer";
                            };
                            class Commander {
                                name = "$STR_position_commander";
                                value = "commander";
                            };
                        };
                    };
                };
            };
        };
    };
};
