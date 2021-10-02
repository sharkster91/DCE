ED_CutUpBodies = {}

function ED_CutUpBodies.CanCutUpBodies(scriptItems)
	scriptItems:addAll(getScriptManager():getItemsTag("CanCutUpBodies"))
end


function ED_CutUpBodies.MALE(recipe, result, player)
	player:getInventory():AddItems("ED.MaleHead", 1)
	player:getInventory():AddItems("ED.MaleTorso", 1)
	player:getInventory():AddItems("ED.MaleRightArm", 1)
	player:getInventory():AddItems("ED.MaleLeftArm", 1)
	player:getInventory():AddItems("ED.MaleLeftLeg", 1)
	player:getInventory():AddItems("ED.MaleRightLeg", 1)
end

function ED_CutUpBodies.FEMALE(recipe, result, player)
	player:getInventory():AddItems("ED.FemaleHead", 1)
	player:getInventory():AddItems("ED.FemaleTorso", 1)
	player:getInventory():AddItems("ED.FemaleRightArm", 1)
	player:getInventory():AddItems("ED.FemaleLeftArm", 1)
	player:getInventory():AddItems("ED.FemaleLeftLeg", 1)
	player:getInventory():AddItems("ED.FemaleRightLeg", 1)
end

ED_CutUpBodies.typesThatCanCutUpBodies = ED_CutUpBodies.typesThatCanCutUpBodies or {}

---@param list table of type paths
function ED_CutUpBodies.addCanCutUpBodiesTypes(list)
	for _,type in pairs(list) do
		table.insert(ED_CutUpBodies.typesThatCanCutUpBodies, type)
	end
end

---Sub-mod authors will have to use the following function to add more types
ED_CutUpBodies.addCanCutUpBodiesTypes(
		{"Base.HuntingKnife","Base.KitchenKnife",
		 "Base.MeatCleaver", "Base.Machete","Base.Katana","Base.HandAxe","Base.Axe","Base.WoodAxe","Base.HandScythe",})


---Adds "CanCutUpBodies" tag to scripts for type
---@param type string
function ED_CutUpBodies.addCanCutUpBodiesTag(type)
	local item = ScriptManager.instance:getItem(type);
	if item then
		local tags = item:getTags()
		local tagString = "CanCutUpBodies"

		for i=0, tags:size()-1 do
			---@type string
			local tag = tags:get(i)
			tagString = tagString..";"..tag
		end

		item:DoParam("Tags = "..tagString);
		print("--AddTag:"..type..": "..tagString);
	end
end

---For each type in ED_CutUpBodies.addCanCutUpBodiesTypes process ED_CutUpBodies.addCanCutUpBodiesesTag(type)
function ED_CutUpBodies.addCanCutUpBodiesTagToTypesThatCan()
	for _,type in pairs(ED_CutUpBodies.typesThatCanCutUpBodies) do
		ED_CutUpBodies.addCanCutUpBodiesTag(type)
	end
end

Events.OnGameBoot.Add(ED_CutUpBodies.addCanCutUpBodiesTagToTypesThatCan)
