-- Setup Turtle Name
local ws = http.websocket("ws://139.99.155.110:2543")
ws.send("name")
local name = ws.receive()

os.setComputerLabel(name)


-- Create a table of all .lua files that should exist on the turtle and their download urls
local files = {
    ["farmer.lua"] = "https://raw.githubusercontent.com/ErrorDodo/CCTweaked-Turtles/main/Bamboo/Farmer/farmer.lua",
    ["actions.lua"] = "https://raw.githubusercontent.com/ErrorDodo/CCTweaked-Turtles/main/Bamboo/Farmer/actions.lua",
    ["finder.lua"] = "https://raw.githubusercontent.com/ErrorDodo/CCTweaked-Turtles/main/Bamboo/Farmer/finder.lua",
    ["state.lua"] = "https://raw.githubusercontent.com/ErrorDodo/CCTweaked-Turtles/main/Bamboo/Farmer/state.lua",
    ["models.lua"] = "https://raw.githubusercontent.com/ErrorDodo/CCTweaked-Turtles/main/Bamboo/Farmer/models.lua"
}

if not fs.exists("farmer") then
    fs.makeDir("farmer")
end

-- Loop through the table of files to download
for filename, url in pairs(files) do
    -- Check if the file already exists
    if not fs.exists("farmer/" .. filename) then
        -- Download the file from the URL
        print("Downloading " .. filename)
        local response = http.get(url)
        if response then
            -- Write the contents of the response to the file
            local file = fs.open("farmer/" .. filename, "w")
            file.write(response.readAll())
            file.close()
            response.close()
            print("Downloaded " .. filename)
        else
            print("Failed to download " .. filename)
            print("Response code: " .. response.getResponseCode())
        end
    end
end

print("Run farmer/farmer.lua to start the farmer")
