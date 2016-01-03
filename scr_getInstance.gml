/// Search all obj_object in room and return instance with alias

// argument0 - string or integer - alias or id of object to find
// return - integer - instance id

with (obj_object) {
    if (str_alias == argument0) {
        return id;
    }
}
with (obj_decoration) {
    if (str_alias == argument0) {
        return id;
    }
}

// If not found and script has reached the end, return -1
return -1;
