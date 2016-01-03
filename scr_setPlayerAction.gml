/// Set animation according to argument0 - str_action

//argument0 - string - str_action

// Local variables
var str_sprite = "spr_" + str_alias;

if (argument0 != "") {
    str_sprite += "_" + argument0;
}

// Set animation speed to default
image_speed = int_imageSpeed;
speed = 0;

// Check what action to perform
global.str_action = argument0;
if (argument0 == "") {
    scr_setSprite(scr_getResource(str_sprite));
    image_speed = 0;
    global.str_actionItem = "";
    global.str_actionObject = "";
    global.str_actionType = "";
    global.str_actionAlias = "";
    global.str_actionText = "";
    global.bool_free = true;
    alarm[0] = int_idleMinimum + irandom(int_idleMaximum - int_idleMinimum);
}
else if (argument0 == "idle") {
    var i, list_idle = ds_list_create();
    for (i = scr_getResourcePart(str_sprite); string_pos(str_sprite,sprite_get_name(i)); i++) {
        ds_list_add(list_idle, i);
    }
    scr_setSprite(list_idle[| irandom(ds_list_size(list_idle)-1)]);
    ds_list_destroy(list_idle);
}
else if (argument0 == "walk") {
    direction = point_direction(x,y,int_xTarget,int_yTarget);
    switch (floor((direction * 4 + 180) / 360) mod 4) {
        case 0: scr_setSprite(scr_getResource(str_sprite + "_right")); break;
        case 1: scr_setSprite(scr_getResource(str_sprite + "_back")); break;
        case 2: scr_setSprite(scr_getResource(str_sprite + "_left")); break;
        case 3: scr_setSprite(scr_getResource(str_sprite + "_front")); break;
    }
    move_towards_point(int_xTarget, int_yTarget, int_movementSpeed);
}
else if (argument0 == "talk") {
    var str_direction = "_front", int_x = x - 50;
    global.bool_free = false;
    scr_setSprite(scr_getResource(str_sprite+str_direction));
    if (x < room_width / 2) {
        int_x = x + 50;
    }
    int_cloud = scr_setCloud(str_cloudText, int_x, y-300);
}
else if (argument0 == "interact") {
    var int_instance = scr_getInstance(global.str_actionObject), str_interaction,
    str_combinationAlias = global.str_actionAlias;
    if (global.str_actionType == "combination") {
        str_combinationAlias = global.str_actionItem;
    }
    // Get str_interaction
    if (!is_undefined(int_instance.map_combinations[? str_combinationAlias])) {
        with (int_instance) {
            str_interaction = map_combinations[? str_combinationAlias];
        }
    }
    else if ((global.str_actionType == "combination") && (!is_undefined(obj_item.str_default))) {
        with (obj_item) {
            str_interaction = str_default;
        }
    }
    else {
        with (global.int_cursorAction) {
            str_interaction = str_default;
        }
    }
    // Interact using str_interaction
    scr_setInteraction(str_interaction);
}
