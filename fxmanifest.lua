fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Mobius'
description 'QBcore Shop Script using qb-target and OpenStore'
version '1.0.1'

-- Client scripts
client_scripts {
    'config.lua',
    'cl_delivery.lua',
    'client.lua'
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

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}
