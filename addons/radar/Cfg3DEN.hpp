class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class dui_attributes {
                class Attributes {
                    class customIconRadar {
                        defaultValue = "''";
                        value = "''";
                        control = "Edit";
                        property = QGVAR(customIconRadar);
                        expression = QUOTE(if (local _this && _value isNotEqualTo '' && {fileExists _value}) then {_this setVariable [ARR_3(QQGVAR(customIcon),_value,true)];};);
                        displayName = CSTRING(customIconRadar);
                        tooltip = CSTRING(customIconRadar_desc);
                    };
                };
            };
        };
    };
};
