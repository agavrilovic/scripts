/// Parse interaction text and perform actions, block by block

// argument0 - string - a succession of text blocks (str_blocks) separated by ">" signs

// Local variables
var int_lt, str_blocks = argument0;

// Stop character from moving
global.bool_free = false;

// Separate blocks into an array
for(int_blocks = 0; string_pos(">",str_blocks) != 0; int_blocks++) {
    int_lt = string_pos(">",str_blocks);
    str_block[int_blocks] = scr_getTrimmed(string_copy(str_blocks,1,int_lt-1));
    str_blocks = string_copy(str_blocks,int_lt+1,string_length(str_blocks)-int_lt);
}
str_block[int_blocks] = scr_getTrimmed(str_blocks);
int_blocks += 1;

// Parse first block
int_currentBlock = 0;
event_perform(ev_alarm,2);
