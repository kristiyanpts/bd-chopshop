fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'FiveM Chop Shop Script by Bulgar Development'
author 'kristiyanpts'
version '1.0.0'

shared_scripts {
  '@ox_lib/init.lua',
  'shared/*.lua',
}

client_scripts {
  'client/editable/framework/*.lua',
  'client/editable/inventories/*.lua',
  'client/client.utils.lua',
  'client/client.main.lua',
  'client/client.animations.lua',
  'client/client.parts.lua',
}

server_scripts {
  "server/editable/framework/*.lua",
  "server/editable/inventories/*.lua",
  "server/editable/groups/*.lua",
  'server/server.main.lua',
}

escrow_ignore {
  'shared/**/*.lua',
  'client/**/*.lua',
  'server/**/*.lua',
  'config.lua',
}

dependencies {
    'ox_lib',
    'bd-minigames',
    'bd-scanner',
    'bd-jobstatus',
}
