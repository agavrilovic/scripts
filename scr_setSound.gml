/// Play sound and return the sound id

// argument0 - integer - sound resource to play (or -1 for all sounds)
// argument1 - boolean - loop true or false (stop sound if -1)
// return - id of sound in game

if (audio_system() == audio_old_system) {
    if (argument1 == 0) {
        return sound_play(argument0);
    }
    else if (argument1 == 1) {
        return sound_loop(argument0);
    }
    else if (argument1 == -1) {
        if (argument0 == -1) {
            sound_stop_all();
        }
        else {
            sound_stop(argument0);
        }
    }
}
else {
    if (argument1 == -1) {
        if (argument0 == -1) {
            audio_stop_all();
        }
        else {
            audio_stop_sound(argument0);
        }
    }
    else {
        return audio_play_sound(argument0,1,argument1);
    }
}

