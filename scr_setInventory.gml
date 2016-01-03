/// Create or destroy GUI for inventory and obj_item for each item in global.list_items

// Local variables
var i, map_item, int_xStart, int_yStart, int_xEnd, int_xOffset, int_yOffset, 
int_x, int_y, list_inventory = global.list_inventory;

// Set variables
with (obj_parser) {
    int_xStart = int_xInventory;
    int_yStart = int_yInventory;
    int_x = int_xStart;
    int_y = int_yStart;
    int_xEnd = int_xInventoryMaximum;
    int_xOffset = int_xInventoryOffset;
    int_yOffset = int_yInventoryOffset;
    bool_inventory = argument0;
    global.str_actionItem = "";
}

// Set inventory on or off
if (argument0 == true) {
    // Stop obj_player from moving
    with (obj_player) {
        scr_setPlayerAction("");
        visible = false;   
    }
    global.bool_free = false;
    
    // Set all room objects to invisible and unavailable
    with (obj_object) {
        bool_visible = visible;
        visible = false;
        bool_availableTemporary = bool_available;
        bool_available = false;
    }
    with (obj_decoration) {
        bool_visible = visible;
        visible = false;   
        bool_availableTemporary = bool_available;
        bool_available = false;
    }
    
    // Show items in inventory
    for(i = 0; i < ds_list_size(list_inventory); i++) {
        map_item = list_inventory[| i];
        with (instance_create(int_x,int_y,obj_item)) {
            str_alias = map_item[? "alias"];
            str_name = map_item[? "name"];
            int_picture = scr_getResource(map_item[? "picture"]);
            str_special = map_item[? "special"];
            str_default = map_item[? "default"];
            str_description = map_item[? "description"];
            sprite_index = int_picture;
        }
        int_x += int_xOffset;
        if (int_x > int_xEnd) {
            int_x = int_xStart;
            int_y += int_yOffset;
        }
    }
}
else {

    // Destroy inventory items (except selected item)
    with (obj_item) {
        if (bool_selected == false) {
            instance_destroy();
        }
    }
        
    // Set all objects, decorations and actions to previous state
    with (obj_object) {
        visible = bool_visible;
        bool_available = bool_availableTemporary;
    }
    with (obj_decoration) {
        visible = bool_visible;
        bool_available = bool_availableTemporary;
    }
    
    // Set player to default state
    with (obj_player) {
        visible = true;
    }
    global.bool_free = true;
}
