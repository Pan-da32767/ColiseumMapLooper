global function MLMain_Init

void function MLMain_Init()
{
    AddCallback_OnClientConnected(CheckMap)
    AddCallback_GameStateEnter(eGameState.Postmatch, GameStateEnter_Postmatch)
}

void function CheckMap(entity player) {
    thread CheckMap_threaded()
}

void function CheckMap_threaded() {
    if (GetMapName() != "mp_coliseum" && GetMapName() != "mp_coliseum_column") {
        foreach (player in GetPlayerArray() ) {
            NSSendAnnouncementMessageToPlayer( player, "地图寄了，稍后将换图", "", <1,1,0>, 1, 1 )
        }
        wait 10
        GameRules_ChangeMap("mp_coliseum", GameRules_GetGameMode())
    }
}

void function GameStateEnter_Postmatch() {
    thread ChangeMapBeforeServer()
}

void function ChangeMapBeforeServer() {
    wait GAME_POSTMATCH_LENGTH - 1
    if( GetMapName() != "mp_coliseum")
        GameRules_ChangeMap("mp_coliseum", GameRules_GetGameMode())
}