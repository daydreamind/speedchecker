#include <amxmodx>
#include <reapi>

new g_iHudSyncObj;

public plugin_init() {
    register_plugin("Speedometr", "0.0.1", "Albertio + daydreamcat");

    RegisterHookChain(RG_CBasePlayer_PreThink, "CBasePlayer_PreThink_Pre", false);

    g_iHudSyncObj = CreateHudSyncObj();
}

public CBasePlayer_PreThink_Pre(const iPlayer) {
    new iUserId = get_user_userid(iPlayer);
	
	if(!is_user_alive(iPlayer))
        return;

    static Float:fVelocity[3];
    get_entvar(iPlayer, var_velocity, fVelocity);

    static Float:fSpeed;
    fSpeed = vector_length(fVelocity);

    set_hudmessage(255, 255, 255, -1.0, 0.8, 0, 0.0, 0.1, 0.1, 0.0);
    ShowSyncHudMsg(iPlayer, g_iHudSyncObj, "%2.0f u/s", fSpeed);
	
	if(fSpeed >= 380.0) {
		if(iUserId != -1) {
			server_cmd("kick #%d ^"Вы были кикнуты за превышение 380 units^"", iUserId);
			
			new name[32];
			get_user_name(iPlayer, name, sizeof(name));
			client_cmd(-1, "say %s был кикнут за превышение скорости", name);
		}
	}
}