fx_version 'cerulean'
game 'gta5'

author 'Monbius'
description 'Standalone Shop Script using qb-target and OpenStore'
version '1.0.0'

-- Client scripts
client_scripts {
    'client.lua',
    'config.lua'
}

-- Server scripts
server_scripts {
    'server.lua',
    'config.lua'
}

-- Dependencies
dependencies {
    'qb-core',
    'qb-target',
    'qb-shops'
}
