function InitializeMemoize()
	if (not memoize) then
		memoize = {}
	end
	return true
end

function GetMemoized(key)
	if (memoize[key] == "nil") then
		return nil
	else
		if (memoize[key]) then
			return memoize[key]
		end
	end
	return nil
end

function SetMemoized(key,variant)
	InitializeMemoize()
	memoize[key] = variant
end

function MGetEntity(entityid)
	entityid = tonumber(entityid) or 0
	
	local memString = "MGetEntity;"..tostring(entityid)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local entity = EntityList:Get(entityid)
		SetMemoized(memString,entity)
		return entity
	end
end

function MIsLoading()
	local memString = "MIsLoading"
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local ret = IsLoading()
		SetMemoized(memString,ret)
		return ret
	end
end

function MIsLocked()
	local memString = "MIsLocked"
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local ret = IsPositionLocked()
		SetMemoized(memString,ret)
		return ret
	end
end

function MIsCasting(fullcheck)
	fullcheck = IsNull(fullcheck,false)
	
	local memString = "MIsCasting;"..tostring(fullcheck)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		--local ret = IsPlayerCasting(fullcheck)
		local ret = ActionList:IsCasting()
		SetMemoized(memString,ret)
		return ret
	end
end

function MGetTarget()
	local memString = "MGetTarget"
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local target = Player:GetTarget()
		SetMemoized(memString,target)
		return target
	end
end

function MEntityList(elstring)
	elstring = elstring or ""
	
	local memString = "MEntityList;"..tostring(elstring)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local el = EntityList(elstring)
		SetMemoized(memString,el)
		return el
	end
end

function MInventory(invstring)
	invstring = invstring or ""
	
	local memString = "MInventory;"..tostring(invstring)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local inventory = Inventory(invstring)
		SetMemoized(memString,inventory)
		return inventory
	end
end

function MGetItem(hqid,includehq,requirehq)
	local memString = "MGetItem;"..tostring(hqid)..";"..tostring(includehq)..";"..tostring(requirehq)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		--local item = GetItem(itemid,includehq,requirehq)
		local item = GetItem(hqid)
		if (item) then
			SetMemoized(memString,item)
		else
			SetMemoized(memString,"nil")
		end	
		return item
	end
end

function MGatherableSlotList()
	local memString = "MGatherableSlotList"
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local list = Player:GetGatherableSlotList()
		SetMemoized(memString,list)
		return list
	end
end

function MPartyMemberWithBuff(ptbuff, ptnbuff, maxrange)
	local memString = "MPartyMemberWithBuff;"..tostring(ptbuff).."-"..tostring(ptnbuff).."-"..tostring(maxrange)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local ret = PartyMemberWithBuff(ptbuff, ptnbuff, maxrange)
		SetMemoized(memString,ret)
		return ret
	end
end

function MGetBestTankHealTarget( maxrange )
	local memString = "GetBestTankHealTarget;"..tostring(maxrange)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local ret = GetBestTankHealTarget( maxrange )
		SetMemoized(memString,ret)
		return ret
	end
end

function MGetBestPartyHealTarget(npc, maxrange)
	local memString = "GetBestPartyHealTarget;"..tostring(npc)..";"..tostring(maxrange)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local ret = GetBestPartyHealTarget( npc, maxrange )
		SetMemoized(memString,ret)
		return ret
	end
end

function MGetBestHealTarget(npc, maxrange, requiredHP)
	local memString = "GetBestHealTarget;"..tostring(npc)..";"..tostring(maxrange)..";"..tostring(requiredHP)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local ret = GetBestHealTarget( npc, maxrange, requiredHP )
		SetMemoized(memString,ret)
		return ret
	end
end

function MPartySMemberWithBuff(ptbuff, ptnbuff, maxrange)
	local memString = "MPartySMemberWithBuff;"..tostring(ptbuff).."-"..tostring(ptnbuff).."-"..tostring(maxrange)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local ret = PartySMemberWithBuff(ptbuff, ptnbuff, maxrange)
		SetMemoized(memString,ret)
		return ret
	end
end

function MGetFateByID(fateID)
	local memString = "MGetFateByID;"..tostring(fateID)
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local fate = GetFateByID(fateID)
		SetMemoized(memString,fate)
		return fate
	end
end

function MFateList()
	local memString = "MFateList"
	local memoized = GetMemoized(memString)
	if (memoized) then
		return memoized
	else
		local fateList = MapObject:GetFateList()
		SetMemoized(memString,fateList)
		return fateList
	end
end
			
-- Functions below pertain to permanent memoize, never-changing data.

function GetPermaMemoized(key)
	return pmemoize[key]
end

function SetPermaMemoized(key,variant)
	pmemoize[key] = variant
end

function PDistance3D(x1,y1,z1,x2,y2,z2)
	x1 = round(x1, 1)
	y1 = round(y1, 1)
	z1 = round(z1, 1)
	x2 = round(x2, 1)
	y2 = round(y2, 1)
	z2 = round(z2, 1)
	
	return Distance3D(x1,y1,z1,x2,y2,z2)
end