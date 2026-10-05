class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class dui_attributes {
                class Attributes {
                    class customNametagInfo {
                        defaultValue = "''";
                        value = "''";
                        control = "Edit";
                        property = QGVAR(customNametagInfo);
                        expression = QUOTE(if (local _this && _value isNotEqualTo '') then {_this setVariable [ARR_3(QQGVAR(customInfo),_value,true)];});
                        displayName = CSTRING(customNametagInfo);
                        tooltip = CSTRING(customNametagInfo_desc);
                    };
                };
            };
        };
    };
};
