-- Functions to handle low level crafting and present a nice interface
RECIPE_DIR = "./Recipe"
INGREDIENT_NAME_DELIMITER = ':'

-- Return an array with the name of each item indexed by grid location 0-8
-- Example for stick
-- [Stick, nil, nil, Stick, nil, nil, nil, nil, nil]
function LookupRecipe(ItemName)
  -- Create Blank Array
  for i=0,8 do
    craftingArray[i] = nil

  -- Open the file
  if type(ItemName) != string then
    return "Error: Bad Recipe Name"
  end

  recipeFile = fs.open(RECIPE_DIR .. "/" .. ItemName)
  -- Read till the end of the file
  repeat
     ingredient = recipeFile.readLine()
     if ingredient ~= nil then
       -- Read each ingredient name
       ingredientName = ingredient.sub( 0, ingredient.match(INGREDIENT_NAME_DELIMITER))
       -- Read each location for that item and write the item name into the array location
       for gridLocation in ingredient.gmatch("^[0-8],$") do
        -- If not nil recipe is bad and has two items existing in the same grid location
	 if craftingArray[gridLocation] == nil then
           craftingArray[gridLocation] = ingredientName
	 else
           craftingArray = "Error: Bad Recipe Positions"
           ingredient = nil
	 end
       end
     end
  until ingredient ~= nil

  -- Close File
  recipeFile.close()
  return craftingArray
end

function CraftItem(ItemName)
  craftingArray = LookupRecipe(ItemName)
  turtle.craft(1)
end
