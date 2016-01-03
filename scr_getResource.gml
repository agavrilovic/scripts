/// Search the resource tree for a resource name and return its resource id

// argument0 - string - resource name to find
// return - integer - id of resource with name argument0, or -1 if not found

if (is_undefined(argument0)) {
    return -1;
}

return asset_get_index(argument0);

/*
// Local variables
var i;

// Check if argument is defined
if (is_undefined(argument0)) {
    return -1;
}

// Check for name in resource Sprites
for(i=0; sprite_exists(i); i++) {
    if (argument0 == sprite_get_name(i)) {
        return i;
    }
}

// Check for name in resource Sounds
for(i=0; sound_exists(i); i++) {
    if (argument0 == sound_get_name(i)) {
        return i;
    }
}

// Check for name in resource Backgrounds
for(i=0; background_exists(i); i++) {
    if (argument0 == background_get_name(i)) {
        return i;
    }
}

// Check for name in resource Paths
for(i=0; path_exists(i); i++) {
    if (argument0 == path_get_name(i)) {
        return i;
    }
}

// Check for name in resource Fonts
for(i=0; font_exists(i); i++) {
    if ((argument0 == font_get_name(i))||(font_get_fontname(i))) {
        return i;
    }
}

// Check for name in resource Objects
for(i=0; object_exists(i); i++) {
    if (argument0 == object_get_name(i)) {
        return i;
    }
}

// Check for name in resource Rooms
for(i=0; room_exists(i); i++) {
    if (argument0 == room_get_name(i)) {
        return i;
    }
}

// If not found and script has reached the end, return -1
return -1;
*/
