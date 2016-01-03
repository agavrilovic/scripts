/// Set bool_available to argument0 and set other variables accordingly

// argument0 - bool - bool_available

// Local variables
var str_currentRoom = obj_parser.str_currentRoom;

if (bool_available != argument0) {
    var i, map_visited;
    bool_available = argument0;
    for(i = 0; i < ds_list_size(global.list_rooms); i++) {
        if (ds_map_find_value(global.list_visited[| i],"alias") == str_currentRoom) {
            map_visited = global.list_visited[| i];
            break;
        }
    }
    if (is_undefined(ds_map_find_value(map_visited[? "changes"], str_alias))) {
        ds_map_add(map_visited[? "changes"], str_alias, argument0);
    }
    else {
        ds_map_replace(map_visited[? "changes"], str_alias, argument0);
    }
}

if (argument0 == true) {
    // Set position
    if (is_undefined(int_xOffset)) {
        int_xOffset = 0;
    }
    if (is_undefined(int_yOffset)) {
        int_yOffset = 0;
    }
    x = int_x - int_xOffset;
    y = int_y - int_yOffset;
    
    // Set cloud position
    if (is_undefined(int_xCloud)) {
        int_xCloud = 0;
    }
    if (is_undefined(int_yCloud)) {
        int_yCloud = 0;
    }
    
    // Set scale
    if (is_undefined(int_xScale)) {
        int_xScale = 1;
    }
    if (is_undefined(int_yScale)) {
        int_yScale = 1;
    }
    image_xscale = int_xScale;
    image_yscale = int_yScale;
    
    // Set visibility
    if (is_undefined(bool_visible)) {
        bool_visible = true;
    }
    visible = bool_visible;
    
    // Set default picture
    sprite_index = scr_getResource(map_pictures[? "default"]);
    image_speed = global.int_imageSpeed;
    image_index = 0;
    
    // Set default sound
    if (!is_undefined(map_sounds[? "default"])) {
        int_sound = scr_setSound(scr_getResource(map_sounds[? "default"]),true);
    }
    
    // Set depth
    depth = -y;
    if (!is_undefined(int_depth)) {
        depth = int_depth;
    }
    
    // Set path
    if (int_path != -1) {
        path_start(int_path,int_movementSpeed,path_action_restart,false);
    }
}
else {
    visible = false;
    x = -1;
    y = -1;
}
