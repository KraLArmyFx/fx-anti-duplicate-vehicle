fx_version 'cerulean'
game 'gta5'

author 'KraLArmyFx'
description 'Prevents spawning duplicate vehicles with the same license plate'
version '1.0.1'
lua54 'yes'

shared_scripts {
    'config.lua'
}

client_script 'client.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
