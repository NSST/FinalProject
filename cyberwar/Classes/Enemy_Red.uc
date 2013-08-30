class Enemy_Red extends Enemy;

event TakeDamage(int DamageAmount, Controller EventInstigator,
vector HitLocation, vector Momentum, class<DamageType> DamageType,
optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
        local CyberPlayerController AttackerController;
        local int Damage;

        AttackerController = CyberPlayerController(EventInstigator);


        if(AttackerController == none)
        return;

        Damage = AttackerController.GetPawnDamage();
        EXP = 20;
        //If blue weapon damages this bot
        if (AwesomeWeapon_ShockRifle(DamageCauser) != none)
        {
                BroadcastMessage = "CRITICAL HIT!";
                Damage = Damage * 2;
        }

        //AwesomeWeapon_RocketLauncher fires UTProj_Rocket
        if (UTProj_Rocket(DamageCauser) != none)
        {
                BroadcastMessage = "ABSORBED!";
                Damage = Damage/2;
        }

        HP -= Damage;
        
        super.TakeDamage(DamageAmount,EventInstigator,HitLocation,Momentum,DamageType);

}

DefaultProperties
{

    Begin Object Class=SkeletalMeshComponent Name=SandboxPawnSkeletalMesh
        SkeletalMesh = SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
        Materials(1)=MaterialInstanceConstant'CH_Corrupt_Male.Materials.MI_CH_Corrupt_MBody01_VRed'
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        HiddenGame=FALSE
        HiddenEditor=FALSE
        BlockActors=false
        CollideActors=false
    End Object

    Mesh=SandboxPawnSkeletalMesh


    Components.Add(SandboxPawnSkeletalMesh)

    Begin Object Class=SkeletalMeshComponent Name=MyWeaponSkeletalMesh
    CastShadow=true
    bCastDynamicShadow=true
    bOwnerNoSee=false
    SkeletalMesh=SkeletalMesh'WP_RocketLauncher.Mesh.SK_WP_RocketLauncher_3P'
    End Object

    WeaponSkeletalMesh=MyWeaponSkeletalMesh
    ControllerClass=class'AggressiveAIController'

    bBlockActors=false
    bJumpCapable=false
    bCanJump=false
    bCanStrafe=True

    GroundSpeed=200.0 //Making the bot slower than the player
    HP = 100;
    AttackDistance=500.0


}


function Attack(Actor target)
{
        PFactory.CabbagePattern(Location,target.Location);
        

}

simulated function PostBeginPlay()
{

       super.PostBeginPlay();

       if (Mesh != none && WeaponSkeletalMesh != none)
       Mesh.AttachComponentToSocket(WeaponSkeletalMesh, 'WeaponPoint');

}








