/// Set global.action variables depending on obj_action id, str_type and str_default

// argument0 - bool - whether to force execution regardless of game state

// If it's not the inventory screen and the player or action is unavailable, exit
if ((obj_parser.bool_inventory == false) && (argument0 == false) && ((bool_available == false) || (global.bool_free == false))) {
    exit;
}

// Delete inventory and/or items following the cursor
with (obj_item) {
    bool_selected = false;
}
scr_setInventory(false);

// Check type
if (str_type == "immediate") {
    with (obj_player) {
        global.int_cursorAction = global.int_cursorActionDefault;
        scr_setInteraction(other.str_default);
    }
}
else if (str_type == "combination") {
    with (obj_parser) {
        if ((global.int_cursorAction != other.id) && (bool_inventory == false)) {
            global.int_cursorAction = other.id;
            scr_setInventory(true);
        }
        else {
            global.int_cursorAction = global.int_cursorActionDefault;
            scr_setInventory(false);
        }
    }
}
else {
    if (global.int_cursorAction != id) {
        global.int_cursorAction = id;
    }
    else {
        global.int_cursorAction = global.int_cursorActionDefault;
    }    
}

// Set cursor sprite and description
with (global.int_cursorAction) {
    cursor_sprite = int_passive;
    scr_setDescription(str_description);
}
