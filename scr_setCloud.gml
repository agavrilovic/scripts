/// scr_setCloud(text, x, y);
/// Sets the cloud text and position of the cloud, returns its id

// argument0 - string - text that needs to fit in the cloud (global.str_cloudText)
// argument1 - int - x position of cloud (set left of the "cloud spike" sprite)
// argument2 - int - y position of cloud (set on top of the "cloud spike" sprite)
// return - int - id of obj_cloud instance created

with (instance_create(argument1,argument2,obj_cloud)) {
    str_cloudText = argument0;
    sprite_index = int_cloud;
    int_cloudWidth = max(int_cloudMinWidth,string_width_ext(str_cloudText,-1,int_cloudMaxWidth));
    int_cloudTextWidth = int_cloudWidth-2*int_cloudTextOffset;
    int_cloudHeight = string_height_ext(str_cloudText, -1, int_cloudTextWidth);
    if (x < room_width/2) {
        int_xLeft = x;
        int_xRight = x+int_cloudWidth+int_cloudTextOffset*2;
        x += sprite_get_width(int_cloud)
        image_xscale = -1;
    }
    else {
        int_xLeft = x-int_cloudWidth-int_cloudTextOffset*2;
        int_xRight = x;
        x -= sprite_get_width(int_cloud)
    }
    int_y = y-int_cloudHeight-int_cloudTextOffset*2;
    int_xCloudText = int_xLeft+int_cloudTextOffset+int_cloudWidth/2;
    int_yCloudText = int_y+int_cloudTextOffset;
    // Default reading time is 15 letters per second
    alarm[0] = room_speed * string_length(str_cloudText) / 15;
    return id;
}
