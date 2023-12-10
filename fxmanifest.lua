fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'krs_shoprobbery'
author 'Config#7804'
version "1.0.0"

client_scripts {
	'bridge/**/client.lua',
    'client/*.lua'
}

server_scripts {
	'bridge/**/server.lua',
    'server/*.lua'
}

shared_scripts {

    '@es_extended/imports.lua',
	'@ox_lib/init.lua',
    'shared/*.lua'
}

files {
    'locales/*.json'
}


dependencies {

	'ox_lib',
	'ox_target'
}