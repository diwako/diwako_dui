class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class dui_attributes {
                class Attributes {
                    class customIconIndicators {
                        defaultValue = "''";
                        value = "''";
                        control = "Edit";
                        property = QGVAR(customIconIndicators);
                        expression = QUOTE(if (local _this && _value isNotEqualTo '' && {fileExists _value}) then {if (_value select [ARR_2(0,1)] == '\') then {_this setVariable [ARR_3(QQGVAR(customIcon),_value,true)]} else {_this setVariable [ARR_3(QQGVAR(customIcon),getMissionPath _value,true)]}});
                        displayName = CSTRING(customIconIndicators);
                        tooltip = CSTRING(customIconIndicators_desc);
                    };
                };
            };
        };
    };
};
