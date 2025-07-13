fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Order screen'
author 'Roxar4TV'
version '1.0.0'

dependencies {
    'ox_lib',
}

shared_script '@ox_lib/init.lua'

client_script 'client.lua' 

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/*.*'
}
