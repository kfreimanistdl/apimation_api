require 'json'
require_relative 'features/support/api_helper'

thumbnail = { 'url' => 'https://images2.onionstatic.com/clickhole/3784/7/original/600.jpg' }
fields = []
fields.push( { 'name' => 'Author', 'value' => 'Iz gud' })
fields.push( { 'name' => 'Position', 'value' => 'Engineering'})
embed = []
embed.push({ 'title' => 'Rich Content',
                 'color' => 174592,
                 'fields' => fields,
                 'thumbnail' => thumbnail})

payload = { 'content' => 'Jenkins monitoring', 'embeds' => embed }.to_json

post('https://discordapp.com/api/webhooks/393067525451022336/uz2WgUi_8-6oS9zy2Pu_3l_-CtQvabdSlgflF_ojyxTxWgxO_8Vdj0qBDMNixDj6wlT1',
     headers: { 'Content-Type' => 'application/json' },
     cookies: {},
     payload: payload)