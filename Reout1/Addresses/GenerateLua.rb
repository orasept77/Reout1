require "yaml"

working_directory   = ARGV.first
addresses_yaml_file = "GOG.yaml"
output_lua_file     = File.join File.dirname(working_directory), "Libraries", "Lua", "Fallout1", "fallout1", "addresses.lua"

addresses = YAML.load_file File.join(working_directory, addresses_yaml_file)

lua = <<-LUA
-- This file is generated by GenerateLua.rb

local addresses = {}
LUA

addresses.each do |name, address|
    lua += "addresses.#{name} = {" + address.map { |a| "0x#{a.to_s(16)}" }.join(", ") + "}\n"
end

lua += <<-LUA
return addresses
LUA

File.write output_lua_file, lua

# puts lua

puts "Done! Wrote #{addresses.length} addresses to #{output_lua_file}"
