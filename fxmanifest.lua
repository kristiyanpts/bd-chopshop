fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'kristiyanpts'
version '1.0.0'

client_scripts {
  'config.lua',
  'client/cl_main.lua',
  'client/cl_animations.lua',
  'client/cl_parts.lua',
}

server_scripts {
  'config.lua',
  'server/sv_main.lua',
}

shared_script '@ox_lib/init.lua'

escrow_ignore {
	'config.lua',
}