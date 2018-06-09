require_relative "tilemap_to_2d_array"
require_relative "autotile"

@tile_data = gets()
@tile_hash = to_hashed(@tile_data)
@min_x = @tile_hash.min_by{|cell|cell[:x]}[:x]
@min_y = @tile_hash.min_by{|cell|cell[:y]}[:y]

@tile_map = to_2d_array(@tile_hash)
simple_auto!(@tile_map)
puts to_tile_data(@tile_map, @min_x, @min_y)
