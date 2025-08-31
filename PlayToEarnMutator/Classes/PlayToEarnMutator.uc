class PlayToEarnMutator extends KFMutator;

var private PlayToEarn PlayToEarn;

public simulated function bool SafeDestroy()
{
    return (bPendingDelete || bDeleteMe || Destroy());
}

public event PreBeginPlay()
{
    Super.PreBeginPlay();

    if (WorldInfo.NetMode == NM_Client) return;

    foreach WorldInfo.DynamicActors(class'PlayToEarn', PlayToEarn)
    {
        break;
    }

    if (PlayToEarn == None)
    {
        PlayToEarn = WorldInfo.Spawn(class'PlayToEarn');
    }

    if (PlayToEarn == None)
    {
        `Log("PlayToEarn: FATAL: Can't Spawn 'PlayToEarn'");
        SafeDestroy();
    }
}

public function AddMutator(Mutator Mut)
{
    if (Mut == Self) return;

    if (Mut.Class == Class)
        PlayToEarnMutator(Mut).SafeDestroy();
    else
        Super.AddMutator(Mut);
}

public function NotifyLogin(Controller C)
{
    PlayToEarn.NotifyLogin(C);

    Super.NotifyLogin(C);
}

public function NotifyLogout(Controller C)
{
    PlayToEarn.NotifyLogout(C);

    Super.NotifyLogout(C);
}

static function String GetLocalString(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2)
{
    return String(class'PlayToEarn');
}

defaultproperties
{

}