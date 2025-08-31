# Killing Floor 2 Play To Earn
Base template for running a server with play to earn support

## Using Database
- Setup [pte_databaseserver](https://github.com/Play-To-Earn-Currency/pte_databaseserver) in the same machine the server will run
- Download [Killing Floor 2](https://wiki.killingfloor2.com/index.php?title=Dedicated_Server_(Killing_Floor_2)) server files
- Create the start script, template can be found on the wiki
- Add: ``?Mutator=PlayToEarnMutator.PlayToEarnMutator``
- Mutator files must be add to the ``KillingFloorDedicatedServer2/KFGame/BrewedPC``
- Install a database like mysql or mariadb
- Create a user for the database: GRANT ALL PRIVILEGES ON pte_wallets.* TO 'pte_admin'@'localhost' IDENTIFIED BY 'supersecretpassword' WITH GRANT OPTION; FLUSH PRIVILEGES;
Create a table named ``killingfloor2``
```sql
CREATE TABLE killingfloor2 (
    uniqueid VARCHAR(255) NOT NULL PRIMARY KEY,
    walletaddress VARCHAR(255) DEFAULT null,
    value DECIMAL(50, 0) NOT NULL DEFAULT 0
);
```

# Compiling (Windows)
- Download killing floor SDK files
- Open KFEditor.exe one time to generate files in ``User/Documents``
- Include this mutator to the compiler section

``.../Documents/My Games/KillingFloor2/KFGame/Config/KFEditor.ini``
```ini
[ModPackages]
ModPackagesInPath=..\..\KFGame\Src
ModOutputDir=..\..\KFGame\Unpublished\BrewedPC\Script
ModPackages=PlayToEarnMutator
```

---
### Option 1
- Use ``build.sh`` script
---
### Option 2
- Copy ``PlayToEarnMutator`` inside the ``.../Documents/My Games/KillingFloor2/KFGame/Src/``
- Use KFEditor.exe to compile the mutators: ``KFEditor.exe make``
- Remove compiled files to rebuild or it will be ignored

# Compiling (Linux)
Follow the steps for windows, but you will need to use wine for compiling

# Developing
- Download [UnrealScript](https://marketplace.visualstudio.com/items?itemName=EliotVU.uc) extension for vscode
- Download [Killing Floor 2 SDK](https://steamdb.info/app/232150/info/), and put it on this root folder (You can use steamcmd or steam to download)
- Restart vscode

# Recommendations
- [SafeMutLoader](https://github.com/GenZmeY/KF2-SafeMutLoader), use it so PlayToEarn does not unrank the server