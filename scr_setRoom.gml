/// Parse room list and create objects accordingly

// argument0 - room id to select from rooms.txt
// argument1 - enter type id to use from the selected room

// Local variables
var i, map_room, str_roomAlias, map_visited, map_new, list_entrances, map_item, 
str_entrance, map_gui, list_objects, map_object, int_object, list_actions, 
map_action, str_actionDefault, map_inventory, map_description, bool_visited, 
str_color, list_rooms = global.list_rooms, list_visited = global.list_visited, 
list_guis = global.list_guis;

// Flush texture for new room (not neccessary if there is only a few rooms)
draw_texture_flush();

// Search the room list for room alias from argument0
str_currentRoom = argument0;
for(i = 0; i < ds_list_size(list_rooms); i++) {
    if (ds_map_find_value(list_rooms[| i],"alias") == argument0) {
        map_room = list_rooms[| i];
        break;
    }
}

// See if room has been visited before
map_visited = -1;
for(i = 0; i < ds_list_size(list_visited); i++) {
    if (ds_map_find_value(list_visited[| i],"alias") == argument0) {
        map_visited = list_visited[| i];
        break;
    }
}

// If room was not visited, it is visited now
if (map_visited == -1) {
    map_new = ds_map_create();
    ds_map_add(map_new, "alias", argument0);
    ds_map_add_map(map_new, "changes", ds_map_create());
    ds_list_add(global.list_visited, map_new);
    ds_list_mark_as_map(global.list_visited, ds_list_size(global.list_visited)-1);
}

// Set room background
with (obj_parser) {
    int_background = scr_getResource(ds_map_find_value(map_room,"background"));
}

// Create room border
with (obj_border) {
    instance_destroy();
}
with (instance_create(0,0,obj_border)) {
    sprite_index = scr_getResource(ds_map_find_value(map_room, "border"));
    mask_index = sprite_index;
}

// Search the enter list for enter alias from argument1
list_entrances = map_room[? "entrances"];
for(i = 0; i < ds_list_size(list_entrances); i++) {
    if (ds_map_find_value(list_entrances[| i],"alias") == argument1) {
        str_entrance = ds_map_find_value(list_entrances[| i],"entrance");
        break;
    }
}

// Start player entrance
with (obj_player) {
    image_xscale = map_room[? "zoom"] / 100;
    image_yscale = image_xscale;
    str_interaction = str_entrance;
}

// Find GUI via alias defined by room
str_gui = map_room[? "gui"];
for(i = 0; i<ds_list_size(list_guis); i++) {
    if (ds_map_find_value(list_guis[| i],"alias") == str_gui) {
        map_gui = list_guis[| i];
        break;
    }
}

// Set GUI backgrounds and inventory positions
str_color = map_gui[? "rgb"];
background_color = make_colour_rgb(real(string_copy(str_color,1,3)),real(string_copy(str_color,5,3)),real(string_copy(str_color,9,3)));
map_inventory = map_gui[? "inventory"];
with (obj_parser) {
    int_guiForeground = scr_getResource(map_gui[? "foreground"]);
    int_guiBackground = scr_getResource(map_gui[? "background"]);
    int_inventoryBackground = scr_getResource(map_inventory[? "background"]);
    xInventory = map_inventory[? "x"];
    yInventory = map_inventory[? "y"];
    xInventoryOffset = map_inventory[? "xOffset"];
    yInventoryOffset = map_inventory[? "yOffset"];
    xInventoryMaximum = map_inventory[? "xMaximum"];
    map_description = map_gui[? "description"];
    if ((!is_undefined(map_description[? "x"]))&&(!is_undefined(map_description[? "y"]))) {
        int_xDescription = map_description[? "x"];
        int_yDescription = map_description[? "y"];
    }
}
str_color = map_description[? "rgb"];
int_descriptionColor = make_colour_rgb(real(string_copy(str_color,1,3)),real(string_copy(str_color,5,3)),real(string_copy(str_color,9,3)));

// DELETE FROM HERE
// Add room items
var list_inventory = global.list_inventory, list_items = map_room[? "startingItems"];
for(i = 0; i < ds_list_size(list_items); i++) {
    ds_list_add(list_inventory,list_items[| i]);
    ds_list_mark_as_map(list_inventory,ds_list_size(list_inventory)-1);
}
// DELETE TO HERE

// Destroy old GUI action buttons
with (obj_action) {
    instance_destroy();
}

// Set new GUI action buttons
str_actionDefault = map_gui[? "default"];
list_actions = map_gui[? "actions"];
for(i = 0; i < ds_list_size(list_actions); i++) {
    map_action = list_actions[| i];
    with (instance_create(0,0,obj_action)) {
        str_alias = map_action[? "alias"];
        int_x = map_action[? "x"];
        int_y = map_action[? "y"];
        str_type = map_action[? "type"];
        str_default = map_action[? "default"];
        bool_available = map_action[? "available"];
        bool_visible = map_action[? "visible"];
        str_description = map_action[? "description"];
        str_name = map_action[? "name"];
        str_combinationDescription = map_action[? "combinationDescription"];
        str_binding = map_action[? "binding"];
        int_picture = scr_getResource(map_action[? "picture"]);
        int_passive = scr_getResource(map_action[? "passive"]);
        int_active = scr_getResource(map_action[? "active"]);
        if (str_alias == str_actionDefault) {
            global.int_cursorActionDefault = id;
            global.int_cursorAction = id;
            cursor_sprite = int_passive;
        }
        visible = bool_visible;
        x = int_x;
        y = int_y;
        sprite_index = int_picture;
    }
}

// Delete old room objects
with (obj_object) {
    instance_destroy();
}
with (obj_decoration) {
    instance_destroy();
}

// Create room objects with properties from room map
list_objects = map_room[? "objects"];
for(i = 0; i < ds_list_size(list_objects); i++) {
    map_object = list_objects[| i];
    if (is_undefined(map_object[? "xInteract"])) {
        int_object = instance_create(0,0,obj_decoration);
    }
    else {
        int_object = instance_create(0,0,obj_object);
    }
    
    if (map_visited != -1) {
        bool_visited = ds_map_find_value(map_visited[? "changes"], map_object[? "alias"]);
    }
    else {
        bool_visited = undefined;
    }
    
    with (int_object) {
        
        // Object variables
        str_alias = map_object[? "alias"];  
        bool_available = map_object[? "available"];
        bool_visible = map_object[? "visible"];
        str_pair = map_object[? "pair"];
        int_path = scr_getResource(map_object[? "path"]);
        int_depth = map_object[? "depth"];
        map_pictures = map_object[? "pictures"];
        map_sounds = map_object[? "sounds"];
        
        // Screen position
        int_x = map_object[? "x"];
        int_y = map_object[? "y"];
        int_xOffset = map_object[? "xOffset"];
        int_yOffset = map_object[? "yOffset"];
        int_xScale = map_object[? "xScale"];
        int_yScale = map_object[? "yScale"];
        
        // Interaction variables
        int_xInteract = map_object[? "xInteract"];
        int_yInteract = map_object[? "yInteract"];
        int_xCloud = map_object[? "xCloud"];
        int_yCloud = map_object[? "yCloud"];
        str_description = map_object[? "description"];
        map_combinations = map_object[? "combinations"];
        map_inventory = map_object[? "inventory"];
        
        // Adjust for new data if room was visited before
        if (!is_undefined(bool_visited)) {
            bool_available = bool_visited;
        }
        
        // Initialise temporary variable for inventory checks
        bool_availableTemporary = bool_available;
        
        // Initialise object if available
        scr_setObject(bool_available);
    }
}
