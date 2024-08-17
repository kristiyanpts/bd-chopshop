RegisterNetEvent('sp-chopshop:StartMenu', function()
    lib.registerContext({
        id = 'sell-chop-shop',
        title = 'Части От Коли',
        options = {
          {
            title = 'Врата',
            icon = 'door',
            event = 'sp-chopshop:chopdoor',
            arrow = true,
            args = {
                number = 1,
                id = 2
            }
          },
          {
            title = 'Гума',
            icon = 'wheel',
            event = 'sp-chopshop:chopwheel',
            arrow = true,
            args = {
                number = 1,
                id = 3
            }
          },
          {
            title = 'Преден Капак',
            icon = 'door',
            event = 'sp-chopshop:chophood',
            arrow = true,
            args = {
                number = 1,
                id = 4
            }
          },
          {
            title = 'Капак От Багажник',
            icon = 'door',
            event = 'sp-chopshop:choptrunk',
            arrow = true,
            args = {
                number = 1,
                id = 5
            }
          },
        }
    })

    lib.showContext('sell-chop-shop')
end)

RegisterNetEvent('sp-chopshop:chopdoor')
AddEventHandler('sp-chopshop:chopdoor', function()
    TriggerServerEvent("sp-chopshop:server:chopdoor")
end)

RegisterNetEvent('sp-chopshop:chopwheel')
AddEventHandler('sp-chopshop:chopwheel', function()
    TriggerServerEvent("sp-chopshop:server:chopwheel")
end)

RegisterNetEvent('sp-chopshop:chophood')
AddEventHandler('sp-chopshop:chophood', function()
    TriggerServerEvent("sp-chopshop:server:chophood")
end)

RegisterNetEvent('sp-chopshop:choptrunk')
AddEventHandler('sp-chopshop:choptrunk', function()
    TriggerServerEvent("sp-chopshop:server:choptrunk")
end)