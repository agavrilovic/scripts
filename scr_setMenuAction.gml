/// Parse menu action and act accordingly

// argument0 - string - action to do

if (argument0 == "exit") {
    game_end();
}
else if (string_pos("menu ",argument0) == 1) {
    scr_setMenu(string_copy(argument0,6,string_length(argument0)-5),false);
}
else if (string_pos("web ",argument0) == 1) {
    url_open(string_copy(argument0,5,string_length(argument0)-4));
    game_end();
}
else if (string_pos("new ",argument0) == 1) {
    // Local variables
    var str_arguments, int_blank, str_room, str_entrance;
    // Parse menu action arguments - starting room and entrance
    str_arguments = string_copy(argument0,5,string_length(argument0)-4);
    int_blank = string_pos(" ",str_arguments);
    str_room = string_copy(str_arguments,1,int_blank-1);
    str_entrance = string_copy(str_arguments,int_blank+1,string_length(str_arguments)-int_blank);
    instance_create(0,0,obj_player);
    // Delete menu buttons
    with (obj_button) {
        instance_destroy();
    }
    // Start game
    scr_setRoom(str_room,str_entrance);
}
else if (string_pos("load ",argument0) == 1) {
    show_message("Loading not implemented.");
}
else if (string_pos("save ",argument0) == 1) {
    show_message("Saving not implemented.");
}
