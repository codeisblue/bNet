# **What is bNet?**
> bNet is a simple library that aims to make using the net library easier for new or even experienced coders. Find example below to see how to use it.

## **Install**
> Either install this as an addon like normaly or put the single lua file in your addons autorun folder. If you want to use anouther method just make sure the same file exists on both client and servere and is included at least once before use (You can include multiple times as the addon will prevent reloads from it)

## **Usage**
```lua 
	--Client example
	bnet.SendToServer(string messagename , varargs data (...))
	bnet.Receive(string messagename , function f(varargs data (...)) end)

	--Server example
	bnet.Send(Player ply , string messagename , varargs data (...))
	bnet.Receive(string messagename , function f(Player ply , varargs data (...)) end)
```

So to send a message from the client to the server simply do
Client
```lua
	bnet.SendToServer("your message name", 10 , 20 , true , "example string")
```
Server
```lua
	bnet.Receive("your message name" , function(ply , num1 , num2 , bool1 , string1)
		print("Message from "..ply:Name())
		print("Data : ")
		print(num1 , num2 , bool1 , string1)
	end)
```
**Note that when using SendToServer after specifying the message name you can add as much data as you want to the message Then for the server you would have**

And from server to client
Client
```lua
	bnet.Receive("your message name" , function(num1 , num2 , bool1 , string1)
		print("Message from server!")
		print("Data : ")
		print(num1 , num2 , bool1 , string1)
	end)
```
Server
```lua
	local ply = player.GetAll()[1]
	bnet.Send(ply, 10 , 20 , true , "example string")
```
**Note that ply would be the reference to the player you sending the message too!**