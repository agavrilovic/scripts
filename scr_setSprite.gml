/// Set sprite_index to argument0 + mood offset

// argument0 - sprite index

// Local variables
var i = 1, str_sprite = sprite_get_name(argument0), var int_moods = 2;

// Default value
sprite_index = argument0;
mask_index = spr_various_token;

// Mood offset
for(i = 1; string_pos(str_sprite, sprite_get_name(sprite_index + i)); i++) {
    if (string_pos(str_sprite + "_" + str_mood, sprite_get_name(sprite_index + i))) {
        sprite_index = argument0 + i;
    }
}

