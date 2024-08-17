function FindGroupByMember(plyId)
    if Config.Core.GroupsSystem == "bd" then
        return exports["bd-groups"]:FindGroupByMember(plyId)
    else
        -- Replace with your own exports for your group system
        return nil
    end
end

function DoesGroupExist(groupId)
    if Config.Core.GroupsSystem == "bd" then
        return exports["bd-groups"]:DoesGroupExist(groupId)
    else
        -- Replace with your own exports for your group system
        return nil
    end
end

function GetGroupMembers(groupId)
    if Config.Core.GroupsSystem == "bd" then
        return exports["bd-groups"]:GetGroupMembers(groupId)
    else
        -- Replace with your own exports for your group system
        return nil
    end
end

function GetGroupLeader(groupId)
    if Config.Core.GroupsSystem == "bd" then
        return exports["bd-groups"]:GetGroupLeader(groupId)
    else
        -- Replace with your own exports for your group system
        return nil
    end
end

function RemoveBlipForGroup(groupId, blip)
    if Config.Core.GroupsSystem == "bd" then
        return exports["bd-groups"]:RemoveBlipForGroup(groupId, blip)
    else
        -- Replace with your own exports for your group system
        return nil
    end
end

function CreateBlipForGroup(groupId, blip, blipData)
    if Config.Core.GroupsSystem == "bd" then
        return exports["bd-groups"]:CreateBlipForGroup(groupId, blip, blipData)
    else
        -- Replace with your own exports for your group system
        return nil
    end
end

function NotifyGroup(groupId, message, time)
    if Config.Core.GroupsSystem == "bd" then
        return exports["bd-groups"]:NotifyGroup(groupId, message, time)
    else
        -- Replace with your own exports for your group system
        return nil
    end
end

function SetJobStatus(groupId, status)
    if Config.Core.GroupsSystem == "bd" then
        return exports["bd-groups"]:SetJobStatus(groupId, status)
    else
        -- Replace with your own exports for your group system
        return nil
    end
end

function GetJobStatus(groupId)
    if Config.Core.GroupsSystem == "bd" then
        return exports["bd-groups"]:GetJobStatus(groupId)
    else
        -- Replace with your own exports for your group system
        return nil
    end
end
