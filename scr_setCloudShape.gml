
/// scr_setCloudShape(spr_cloud, borderOffset, textOffset, radius, minWidth, maxWidth, cloudColor, cloudTextColor);
/// Sets the basic shape for all future clouds, until changed again

// argument0 - int - picture of sprite resource for cloud
// argument1 - int - width of the cloud border in pixels
// argument2 - int - padding for text within the cloud
// argument3 - int - radius of curvation for cloud
// argument4 - int - smallest cloud width
// argument5 - int - largest cloud width
// argument6 - int - color of cloud
// argument7 - int - color of text

with (obj_parser) {
    int_cloud = argument0;
    int_cloudBorderOffset = argument1;
    int_cloudTextOffset = argument2;
    int_cloudRadius = argument3;
    int_cloudMinWidth = argument4;
    int_cloudMaxWidth = argument5;
    int_cloudColor = argument6;
    int_cloudTextColor = argument7;
}
