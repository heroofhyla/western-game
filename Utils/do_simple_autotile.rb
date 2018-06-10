require_relative "tilemap_to_2d_array"
require_relative "autotile"

@tile_data = gets()
@tile_hash = to_hashed(@tile_data)
@min_x = @tile_hash.min_by{|cell|cell[:x]}[:x]
@min_y = @tile_hash.min_by{|cell|cell[:y]}[:y]


@tilesets = {
  dirt:{
    nw: 13,
    w: 11,
    c: 12,
    n: 1,
    ne: 6,
    inw: 2,
    ine: 5,
    ise: 4,
    isw: 3,
    e: 7,
    se: 8,
    s: 9,
    sw: 10  
  },
  brick:{
    n: 14,
    ne: 15,
    inw: 16,
    ine: 17,
    ise: 18,
    isw: 19,
    nw: 20,
    w: 21,
    sw: 22,
    s: 23,
    se: 24,
    e: 25,
    c: 26
  }
}


@tile_map = to_2d_array(@tile_hash)
@tilesets.values.each do |t|
  simple_auto!(@tile_map, t)
end
puts to_tile_data(@tile_map, @min_x, @min_y)
