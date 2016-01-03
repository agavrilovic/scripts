/// Set background and buttons for menu

// argument0 - string - menu alias
// argument1 - bool - is menu in-game

// Local variables
var i, map_menu, list_buttons, map_button;

// Flush texture for new menu (not neccessary if there is only a few menus)
draw_texture_flush();

// Search the menu list for menu alias from argument0
for(i = 0; i < ds_list_size(global.list_menus); i++) {
    if (ds_map_find_value(global.list_menus[| i],"alias") == argument0) {
        map_menu = global.list_menus[| i];
        break;
    }
}

// If menu is not part of game, set backgrounds and sounds for menu
if (argument1 == false) {
    
    var str_color = map_menu[? "rgb"];
    background_color = make_colour_rgb(real(string_copy(str_color,1,3)),real(string_copy(str_color,5,3)),real(string_copy(str_color,9,3)));
        
    with (obj_parser) {
        scr_setSound(intMusic,-1);
        intMusic = scr_setSound(scr_getResource(map_menu[? "music"]),true);
        int_background = scr_getResource(map_menu[? "background"]);
        int_guiBackground = -1;
        int_guiForeground = -1;
        int_inventoryBackground = -1;        
    }
}

// Delete old buttons
with (obj_button) {
    instance_destroy();
}

// Create buttons
list_buttons = map_menu[? "buttons"];
for(i = 0; i < ds_list_size(list_buttons); i++) {
    map_button = list_buttons[| i];
    with (instance_create(0,0,obj_button)) {
        str_action = map_button[? "action"];
        int_x = map_button[? "x"];
        int_y = map_button[? "y"];
        int_picture = scr_getResource(map_button[? "picture"]);
        sprite_index = int_picture;
        x = int_x;
        y = int_y;
    }
}
