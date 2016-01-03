/// Trim the string

// argument0 - string - a string with trailing whitespace
// return - string - argument0 without trailing whitespace

// Local variables
var str_trim = argument0;

// 
while(string_char_at(str_trim,1) == " ") {
    str_trim = string_copy(str_trim,2,string_length(str_trim)-1)
}
while(string_char_at(str_trim,string_length(str_trim)) = " ") {
    str_trim = string_copy(str_trim,1,string_length(str_trim)-1)
}
return str_trim
