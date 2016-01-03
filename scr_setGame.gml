/// Initialise everything using json setup file

// argument0 - string - name of setup file, default is "setup.json"
// return - string - name of first menu

// Local variables
var str_action;

// Decode main JSON
global.map_setup = json_decode(scr_getFile(argument0));

// Initialise image speed and room speed values from setup
global.int_imageSpeed = global.map_setup[? "image_speed"] / 100;
room_speed = global.map_setup[? "room_speed"];
cursor_sprite = scr_getResource(global.map_setup[? "cursor"]);
str_action = global.map_setup[? "action"];

// If multiple is set, decode other JSONs, otherwise point to main JSON
if (ds_map_find_value(global.map_setup, "multiple") == true) {
    global.map_menus = json_decode(scr_getFile("menus.json"));
    global.map_rooms = json_decode(scr_getFile("rooms.json"));
    global.map_guis = json_decode(scr_getFile("guis.json"));
    global.map_conversations = json_decode(scr_getFile("conversations.json"));
}
else {
    global.map_menus = global.map_setup;
    global.map_rooms = global.map_setup;
    global.map_guis = global.map_setup;
    global.map_conversations = global.map_setup;
}

// Initialise global lists with game data
global.list_menus = global.map_menus[? "menus"];
global.list_rooms = global.map_rooms[? "rooms"];
global.list_guis = global.map_guis[? "guis"];
global.list_conversations = global.map_conversations[? "conversations"];

// Initialise lists populated during gameplay - items, variables, room changes
global.list_inventory = ds_list_create();
global.list_variables = ds_list_create();
global.list_visited = ds_list_create();

// Initialise font
draw_set_halign(fa_center);
draw_set_font(font_default);

// Set cloud shape to standard white round talking cloud
scr_setCloudShape(spr_various_cloud_talk, 2,20,60,150,450,c_white,c_black);

// Initialise background settings
background_showcolour = true;
background_color = c_black;

// Sound, background and description variables for obj_parser to play / draw
with (obj_parser) {
    
    // Sound variables
    scr_setSound(-1,-1);
    intMusic = -1;
    
    // Background variables
    int_background = -1;
    int_inventoryBackground = -1;
    int_guiBackground = -1;
    int_guiForeground = -1;
    
    // Description variables
    str_description = "";
    int_xDescription = room_width / 2;
    int_yDescription = room_height - string_height("I");
    int_descriptionColor = 0;
    
    // Current room alias
    str_currentRoom = "";
    
    // Inventory variables
    bool_inventory = false; // shown on screen or not
    int_xInventory = 300; // left margin
    int_yInventory = 200; // top margin
    int_xInventoryMaximum = 900; // right margin
    int_xInventoryOffset = 200; // x offset
    int_yInventoryOffset = 200; // y offset            
}

// Action variables are global for ease of use at expense of execution speed
global.bool_free = true; // whether player can perform actions or not
global.str_action = ""; // alias for player action, e.g. "idle"
global.str_actionItem = ""; // alias of item used for combination
global.str_actionObject = ""; // alias for object to use action on, e.g. "door"
global.str_actionType = ""; // type of current action, e.g. "combination"
global.str_actionAlias = ""; // alias of selected action, e.g. "kick" or "keys"
global.str_actionText = ""; // text for current action, e.g. "Hello. > Goodbye"
global.int_cursorAction = 0; // current cursor (not neccessarily current action)
global.int_cursorActionDefault = 0; // default cursor action

// Return menu action
return str_action;
