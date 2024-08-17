RegisterNetEvent('bd-chopshop:StartMenu', function()
  lib.registerContext({
    id = 'sell-chop-shop',
    title = Config.Locale["chopTitle"],
    options = {
      {
        title = Config.Locale["chopDoor"],
        icon = 'fa-solid fa-door-closed',
        event = 'bd-chopshop:chopdoor',
        arrow = true,
        args = {
          number = 1,
          id = 2
        }
      },
      {
        title = Config.Locale["chopWheel"],
        icon = 'fa-solid fa-dharmachakra',
        event = 'bd-chopshop:chopwheel',
        arrow = true,
        args = {
          number = 1,
          id = 3
        }
      },
      {
        title = Config.Locale["chopHood"],
        icon = 'fa-solid fa-door-closed',
        event = 'bd-chopshop:chophood',
        arrow = true,
        args = {
          number = 1,
          id = 4
        }
      },
      {
        title = Config.Locale["chopTrunk"],
        icon = 'fa-solid fa-door-closed',
        event = 'bd-chopshop:choptrunk',
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

RegisterNetEvent('bd-chopshop:chopdoor')
AddEventHandler('bd-chopshop:chopdoor', function()
  TriggerServerEvent("bd-chopshop:server:chopdoor")
end)

RegisterNetEvent('bd-chopshop:chopwheel')
AddEventHandler('bd-chopshop:chopwheel', function()
  TriggerServerEvent("bd-chopshop:server:chopwheel")
end)

RegisterNetEvent('bd-chopshop:chophood')
AddEventHandler('bd-chopshop:chophood', function()
  TriggerServerEvent("bd-chopshop:server:chophood")
end)

RegisterNetEvent('bd-chopshop:choptrunk')
AddEventHandler('bd-chopshop:choptrunk', function()
  TriggerServerEvent("bd-chopshop:server:choptrunk")
end)
