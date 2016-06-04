if bnet == nil then
	bnet = {} 
	if SERVER then
		util.AddNetworkString("_BNET")
		bnet.Send = function(ply , name , ...)
			net.Start("_BNET")
				net.WriteString(name)
				net.WriteInt(#{...} , 8) 
				bnet._WriteData({...})
			net.Send(ply)   
		end 
	end
	if CLIENT then
		bnet.SendToServer = function(name , ...)
			net.Start("_BNET")
				net.WriteString(name)
				net.WriteInt(#{...} , 8)  
				bnet._WriteData({...})
			net.SendToServer() 
		end 
	end
	bnet._WriteData = function(d)
		for k ,v in pairs(d) do 
			net.WriteType(v)
		end
	end 
	bnet.receiveEvents = {}
	bnet.Receive = function(name , cb)
		if bnet.receiveEvents[name] == nil then
			bnet.receiveEvents[name] = {}
		end
		table.insert(bnet.receiveEvents[name] , cb)
	end
	net.Receive("_BNET" , function(len , ply)
		local messageName = net.ReadString()
		local messageLen = net.ReadInt(8)
		local data = {}
		for i = 1 , messageLen do
			data[i] = net.ReadType()
		end
		PrintTable(data)
		if bnet.receiveEvents[messageName] ~= nil then
			for k ,v in pairs(bnet.receiveEvents[messageName]) do
				if SERVER then
					v(ply,unpack(data))
				else 
					v(unpack(data))
				end
			end
		end 
	end)
end

