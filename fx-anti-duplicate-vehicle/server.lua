local activePlates = {}

local function Debug(msg)
    if Config.DebugPrint then print("[fx-anti-duplicate-vehicle] " .. msg) end
end

local function sanitizePlate(plate)
    return string.gsub(plate or "", "%s+", ""):upper()
end

local function RefreshSQLPlates()
    if not Config.UseSQLWhitelist then return end
    local result = MySQL.query.await("SELECT plate FROM " .. Config.SQLVehicleTable, {})
    for _, row in ipairs(result) do
        activePlates[sanitizePlate(row.plate)] = true
    end
    Debug("SQL vehicle plate cache loaded.")
end

CreateThread(function()
    if Config.UseSQLWhitelist then
        RefreshSQLPlates()
    end
end)

AddEventHandler("entityCreated", function(entity)
    if not DoesEntityExist(entity) or not IsEntityAVehicle(entity) then return end
    local veh = entity
    local plate = sanitizePlate(GetVehicleNumberPlateText(veh))

    Wait(Config.EntityCreatedWaitTime)

    if Config.UseSQLWhitelist and not activePlates[plate] then
        return
    end

    local coord = GetEntityCoords(veh)
    local alreadyExists = false

    for _, v in ipairs(GetAllVehicles()) do
        if v ~= veh and DoesEntityExist(v) then
            local vplate = sanitizePlate(GetVehicleNumberPlateText(v))
            if vplate == plate then
                local dist = #(GetEntityCoords(v) - coord)
                if dist <= Config.DuplicateScanRange then
                    alreadyExists = true
                    break
                end
            end
        end
    end

    if alreadyExists then
        Debug(("Duplicate vehicle detected: %s"):format(plate))
        if Config.AutoDeleteDuplicate then
            TriggerClientEvent("fx-anti-duplicate-vehicle:forceDelete", -1, plate)
        end
    else
        Debug(("Vehicle allowed: %s"):format(plate))
    end
end)
