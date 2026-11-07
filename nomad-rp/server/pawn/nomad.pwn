#include <a_samp>

#define NOMAD_NAME "NOMAD RP | Қазақстан"
#define COLOR_GOLD 0xD8B46AFF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_GREY 0xA0A0A0FF
#define COLOR_RED 0xE05B5BFF

new PlayerCash[MAX_PLAYERS];
new PlayerBank[MAX_PLAYERS];
new PlayerHunger[MAX_PLAYERS];
new PlayerThirst[MAX_PLAYERS];

stock SendKazakhUsage(playerid, const text[])
{
    SendClientMessage(playerid, COLOR_GREY, text);
    return 1;
}

public OnGameModeInit()
{
    SetGameModeText(NOMAD_NAME);
    ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);
    SetWorldTime(12);
    print("[NOMAD RP] Қазақстандық RP режимі іске қосылды.");
    return 1;
}

public OnPlayerConnect(playerid)
{
    PlayerCash[playerid] = 500;
    PlayerBank[playerid] = 2500;
    PlayerHunger[playerid] = 100;
    PlayerThirst[playerid] = 100;
    SendClientMessage(playerid, COLOR_GOLD, "NOMAD RP серверіне қош келдіңіз!");
    SendClientMessage(playerid, COLOR_WHITE, "Сервер әзірлену үстінде. /help — командалар.");
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    // TODO: account and character persistence via database.
    return 1;
}

public OnPlayerSpawn(playerid)
{
    // TODO: spawn at saved character position after authenticated character selection.
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (!strcmp(cmdtext, "/help", true))
    {
        SendClientMessage(playerid, COLOR_GOLD, "NOMAD RP | Командалар:");
        SendClientMessage(playerid, COLOR_WHITE, "/me /do /stats /help");
        SendClientMessage(playerid, COLOR_WHITE, "Келесі жаңартуда жаңа командалар қосылады.");
        return 1;
    }

    if (!strcmp(cmdtext, "/stats", true))
    {
        new message[144];
        format(message, sizeof(message), "Ақша: %d тг | Банк: %d тг", PlayerCash[playerid], PlayerBank[playerid]);
        SendClientMessage(playerid, COLOR_GOLD, message);
        format(message, sizeof(message), "Қарны тоқ: %d%% | Шөл: %d%%", PlayerHunger[playerid], PlayerThirst[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, message);
        return 1;
    }

    if (!strcmp(cmdtext, "/me", true))
    {
        return SendKazakhUsage(playerid, "Қолдану: /me [әрекет]. Мысалы: /me құжаттарын көрсетеді");
    }

    if (!strcmp(cmdtext, "/do", true))
    {
        return SendKazakhUsage(playerid, "Қолдану: /do [жағдай]. Мысалы: /do Көшеде тыныш.");
    }

    return 0;
}
