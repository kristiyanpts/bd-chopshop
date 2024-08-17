# Add these into qb-vehiclekeys/client/main.lua

```lua
    local VehiclesThatCantBeLockpicked = {} -- this at the top of the file

    -- The ones below at the bottom of the file
    function MakeVehicleNotLockpickable(Plate)
        VehiclesThatCantBeLockpicked[Plate] = true
    end

    exports("MakeVehicleNotLockpickable", MakeVehicleNotLockpickable)

    -- The following line must be added to the LockpickDoor function on the top where the if conditions are
    if VehiclesThatCantBeLockpicked[GetVehicleNumberPlateText(vehicle)] == true then return end
```
