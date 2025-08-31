// From: https://github.com/GenZmeY/KF2-SafeMutLoader/blob/master/DEV.md

class PlayToEarn extends Info;

var int LastProcessedWave;

public event PreBeginPlay()
{
    Super.PreBeginPlay();

    // do some initialization here
}

public event PostBeginPlay()
{
    Super.PostBeginPlay();

    // do some initialization here
}

// Does not work unfurtunally :(
public function NotifyLogin(Controller C)
{
    // Do what you need here when the player log in
}

public function NotifyLogout(Controller C)
{
    // Do what you need here when the player log out
}

function Tick(float DeltaTime)
{
    local RegisterTCP registerController;
    local KFGameReplicationInfo KFGI;
    local KFPawn_Human Human;
    local IncrementTCP incrementController;
    local KFPlayerController playerController;

    super.Tick(DeltaTime);

    KFGI = KFGameReplicationInfo(WorldInfo.GRI);

    if (KFGI != None && KFGI.WaveNum > 0 && KFGI.AIRemaining == 0)
    {
        if (LastProcessedWave != KFGI.WaveNum)
        {
            `log("[PTE] Wave " $ KFGI.WaveNum $ " is over.");
            LastProcessedWave = KFGI.WaveNum;

            foreach WorldInfo.AllPawns(class'KFPawn_Human', Human)
            {
                if (Human != None && !Human.bDeleteMe && Human.Health > 0)
                {
                    `log("[PTE] Player Alive: " $ Human.PlayerReplicationInfo.PlayerName);

                    if (Human.Controller != None && KFPlayerController(Human.Controller) != None)
                    {
                        registerController = Spawn(class'RegisterTCP');
                        registerController.SetUniqueID("" $ Human.PlayerReplicationInfo.uniqueId.Uid.A);
                        registerController.Resolve("127.0.0.1");

                        incrementController = Spawn(class'IncrementTCP');
                        incrementController.SetUniqueID("" $ Human.PlayerReplicationInfo.uniqueId.Uid.A);
                        incrementController.Resolve("127.0.0.1");
                        KFPlayerController(Human.Controller).ClientMessage("[PTE] You earned 0.1 PTE for surviving!");
                    }
                }
            }
        }
    }
}

defaultproperties
{

}