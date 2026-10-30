# 🗡️ codMaster

## Retirement notice — October 30, 2026

> **Retiring standalone repository.** The maintained `codMaster.ash` command has been absorbed into [don_custom_functions](https://github.com/donCannoli-burns/don_custom_functions), and its reusable Codpiece preset functions live in [don-ash-lib](https://github.com/donCannoli-burns/don-ash-lib). Use those repositories for new installs and changes.
>
> This original repository remains a historical source. Consolidation into [Retired-KOL-Scripts](https://github.com/donCannoli-burns/Retired-KOL-Scripts) is **planned in approximately 30 days (late November 2026)**, not yet completed. Original usage below is retained as legacy documentation.

**Migration:** run `git list`, update/install both maintained repositories, verify `don_codmaster_lib.ash` and `codMaster.ash`, and only after successful verification remove the redundant old checkout that installs the same script filename. **Preserve `data/cod_master/saves/`, including `spell.txt`**, as well as player preferences and any local modifications. The maintained implementation reads and writes the existing saved preset format.

See the [maintained CodMaster migration instructions](https://github.com/donCannoli-burns/don_custom_functions#official-codmaster-absorption-2026-10-29).

A script for Kingdom of Loathing. To set, save and equip gem configurations for The Eternity Codpiece.
&#10240;
## 🗡️ <ins>Installation / Uninstallation</ins><br/>
 &#10240; 🔹 To install, run the following on the gCLI:
 >     git checkout https://github.com/donCannoli-burns/codMaster.git
 &#10240; 🔹 To uninstall, run the following on the gCLI:
 >     git delete https://github.com/donCannoli-burns/codMaster.git
 &#10240; 🔹 To set gem configuration.
 >      codMaster set
 &#10240; 🔹 To save your gem configuration.
 >      codMaster save <your config name>
 &#10240; 🔹 To equip your gem configuration.  
>       codMaster equip <your config name>
 &#10240; 🔹 To see other options.    
>       codMaster help
    
