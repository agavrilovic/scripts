/// Open file for reading, put contents in string, return string

// argument0 - string - path to file
// return - string - file contents

// Local variables
var str_file = "", var_file = file_text_open_read(working_directory + argument0);

while (!file_text_eof(var_file)) {
    str_file += file_text_readln(var_file);
}
file_text_close(var_file);
return str_file;
