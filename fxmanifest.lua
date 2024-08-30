fx_version 'cerulean'
game 'gta5'

author 'Mobius'
description 'QBcore Shop Script using qb-target and OpenStore'
version '1.0.1'

-- Client scripts
client_scripts {
    'client.lua',
    'cl_delivery.lua',
    'config.lua'
}

-- Server scripts
server_scripts {
    'server.lua',
    'sv_delivery.lua',
    'config.lua'
}

-- Dependencies
dependencies {
    'qb-core',
    'qb-target',
    'qb-shops'
}
