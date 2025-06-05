RegisterNetEvent("fx-anti-duplicate-vehicle:forceDelete", function(plate)
    local vehs = GetGamePool("CVehicle")
    for _, veh in ipairs(vehs) do
        if DoesEntityExist(veh) and GetVehicleNumberPlateText(veh):upper() == plate then
            NetworkRequestControlOfEntity(veh)
            Wait(100)
            if NetworkHasControlOfEntity(veh) then
                DeleteEntity(veh)
            end
        end
    end
end)
