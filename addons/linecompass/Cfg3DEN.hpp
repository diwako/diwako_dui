class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class dui_attributes {
                class Attributes {
                    class customIconLineCompass {
                        defaultValue = "''";
                        value = "''";
                        control = "Edit";
                        property = QGVAR(customIconLineCompass);
                        expression = QUOTE(if (local _this && _value isNotEqualTo '' && {private _arr = parseSimpleArray _value; !isNil '_arr' && {_arr isNotEqualTo []} && {(count _arr) >= 2} && {(_arr select 0) isEqualType ''} && {fileExists (_arr select 0)} && {(_arr select 1) isEqualType 0} && {(_arr select 1) > 0}}) then {private _arr = parseSimpleArray _value; _this setVariable [ARR_3(QQGVAR(customIcon),[ARR_2(_arr select 0,_arr select 1)],true)];});
                        displayName = CSTRING(customIconLineCompass);
                        tooltip = CSTRING(customIconLineCompass_desc);
                    };
                };
            };
        };
    };
};
