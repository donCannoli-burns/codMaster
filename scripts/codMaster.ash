script: "codMaster.ash"



void equipGems() {
    string Gem_1 = get_property("cod_master_Slot_1").to_int().to_item();
    string Gem_2 = get_property("cod_master_Slot_2").to_int().to_item();
    string Gem_3 = get_property("cod_master_Slot_3").to_int().to_item();
    string Gem_4 = get_property("cod_master_Slot_4").to_int().to_item();
    string Gem_5 = get_property("cod_master_Slot_5").to_int().to_item();

    print(`Equpping slot 1`,'fuchsia');
    cli_execute('equip codpiece1 '+`{(Gem_1)}`);
    print(`Equpping slot 1`,'fuchsia');
    cli_execute('equip codpiece2 '+`{(Gem_2)}`);
    print(`Equpping slot 1`,'fuchsia');
    cli_execute('equip codpiece3 '+`{(Gem_3)}`);
    print(`Equpping slot 1`,'fuchsia');
    cli_execute('equip codpiece4 '+`{(Gem_4)}`);
    print(`Equpping slot 1`,'fuchsia');
    cli_execute('equip codpiece5 '+`{(Gem_5)}`);
    print(`Decorate Your Eternity Codpiece is complete!`,'fuchsia');


/*
    equip($slot[CODPIECE1],$item[Gem_1]);
    equip($slot[CODPIECE2],$item[Gem_2]);
    equip($slot[CODPIECE3],$item[Gem_3]);
    equip($slot[CODPIECE4],$item[Gem_4]);
    equip($slot[CODPIECE5],$item[Gem_5]);
*/


}



string Slot_1_Prompt = `What gem would you like loaded in slot 1? \n Enter item number.`;
string Slot_2_Prompt = `What gem would you like loaded in slot 2? \n Enter item number.`;
string Slot_3_Prompt = `What gem would you like loaded in slot 3? \n Enter item number.`;
string Slot_4_Prompt = `What gem would you like loaded in slot 4? \n Enter item number.`;
string Slot_5_Prompt = `What gem would you like loaded in slot 5? \n Enter item number.`;

void init() {
  try {
    cli_execute('lookup "Decorate Your Eternity Codpiece"');
      }
  finally {
    set_property("cod_master_Slot_1", user_prompt(Slot_1_Prompt));
    set_property("cod_master_Slot_2", user_prompt(Slot_2_Prompt));
    set_property("cod_master_Slot_3", user_prompt(Slot_3_Prompt));
    set_property("cod_master_Slot_4", user_prompt(Slot_4_Prompt));
    set_property("cod_master_Slot_5", user_prompt(Slot_5_Prompt));
    }
}
void log() {

    set_property("cod_master_Slot_1", to_int(get_property($slot[CODPIECE1])));
    set_property("cod_master_Slot_2", to_int(get_property($slot[CODPIECE2])));
    set_property("cod_master_Slot_3", to_int(get_property($slot[CODPIECE3])));
    set_property("cod_master_Slot_4", to_int(get_property($slot[CODPIECE4])));
    set_property("cod_master_Slot_5", to_int(get_property($slot[CODPIECE5])));
}

boolean [string] skip_props = {
    "cod_master_validSaves": true
};

string filePrefix = "data/cod_master/saves/";

void listSaves() {
    print("Current Saves: ", "teal");
    foreach x, it in get_property("cod_master_validSaves").split_string('(?<!\\\\)(, |,)') {
        print("- " + it);
    }
}

void saveAllProperties(string fileName) {
    string [string] save_to_file;
    
    boolean [string] prop_map =  get_all_properties("cod_master_Slot_", false);
    foreach prop, val in prop_map {
        if (skip_props contains prop) {
            continue;
        }
        string value = get_property(prop);
        save_to_file[prop] = value;
    }

    string realFileName = filePrefix + fileName + ".txt";
    if (map_to_file(save_to_file, realFileName)) {
        boolean alreadyExists = false;
        foreach x, it in get_property("cod_master_validSaves").split_string('(?<!\\\\)(, |,)') {
            if (it == fileName) {
                if (!user_confirm("Save state of name " + fileName + " already exists. Are you sure you want to overwrite?") ) {
                    abort("State Save canceled by user.");
                }
                print("Overwriting the save state named " + fileName, "red");
                alreadyExists = true;
                break;
            }
        }
        if (!alreadyExists) {
            if (get_property("cod_master_validSaves") == "") {
                set_property("cod_master_validSaves", fileName);
            } else {
                set_property("cod_master_validSaves", get_property("cod_master_validSaves") + "," + fileName);
            }
        }
        print("codMaster save state successfully created in /" + realFileName, "teal");
    } else {
        print("Error, file was not saved.");
    }
    
}

void loadAllProperties(string fileName) {
    string realFileName = filePrefix + fileName + ".txt";
    string [string] prop_map;
    file_to_map(realFileName, prop_map);
    foreach prop, val in prop_map {
        print("Setting " + prop + " to " + val);
        set_property(prop, val);
    }
    print("codMaster save state successfully loaded.", "teal");
}
void codMasterHelper() {
    print_html("<font color=eda800><b>Welcome to codMaster!</b></font>");
    print("codMaster is a script to save and load different codpiece configurations");
    print("To use the script, please run codMaster init before you run codMaster equip");
    print("Setup Commands - inits must be run before equipGems;","teal");
     print_html("<b>equipGems</b> - Equips the gems that are loaded in the current save file.");
    print_html("<b>init</b> - Sets the gems to be used in each slot");
    print_html("<b>listSaves</b> - Lists all current save states. If you manually delete files from your data folder, this will be out of sync. Tracked by codMaster_validSaves");
    print_html("<b>save (name)</b> - Saves current equipped gems codMaster to a file with the given name");
    print_html("<b>equip (name)</b> - Loads and equips gems from the file with the given name");
}

void optional_help_info() {
    print_html("<font color=eda800><b>Welcome to codMaster!</b></font>");
    print("codMaster is a script to save and load different codpiece configurations");
    print("To use the script, please first run codMaster init, then codMaster save before you run codMaster equip");
    print("Setup Commands - inits must be run","teal");
    print_html("<b>init</b> - Generic init that prompts for pathId. Use this for paths without a dedicated init.");
    print_html("<b>listSaves</b> - Lists all current save states. If you manually delete files from your data folder, this will be out of sync. Tracked by codMaster_validSaves");
    print_html("<b>save (name)</b> - Saves current state of codMaster to a file with the given name");
    print_html("<b>equip (name)</b> - Loads the state of codMaster from the file with the given name and equips gems");
}
void main(string input) {
     string [int] commands = input.split_string("\\s+");
    for(int i = 0; i < commands.count(); ++i){
        switch(commands[i].to_lower_case()){
            case "init":
                init();
                return;
            case "save":
                if(i + 1 < commands.count()) {
                    i = i+1;
                    string saveName = commands[i];
                    saveAllProperties(saveName);
                } else {
                    print("Please provide a save name as an argument.", "red");
                }
                return;
            case "equip":
             
                if (get_property("codMaster_Slot_1") == "") {
                    codMasterHelper();
                } else {
                if(i + 1 < commands.count()) {
                    i = i+1;
                    string saveName = commands[i];
                    loadAllProperties(saveName);
                } else {
                    print("Please provide a save name as an argument.", "red");
                }}
                equipGems();
                return;
            case "listsaves":
                listSaves();
                return;
            case "option":
                codMasterHelper();
                return;
            default:
                codMasterHelper();
                return;
        }
    }

}
