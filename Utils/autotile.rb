# Utility for autotiling.
# This is a very basic autotiling algorithm that only supports 13 autotile
# shapes. It does not support any regions that are only a single tile wide; any
# attempt to do so will yield less-than-good results. A more advanced algorithm
# (e.g. RPG Maker's algorithm) produces 47 shapes by cutting tiles into 4
# subtiles.

@simple_tileset = {
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
}

# Destructively applies autotiling to a 2D array. Works for one tile type at
# a time, which is specified in the tileset variable.
def simple_auto!(map, tileset=@simple_tileset)
  vals = tileset.values
  map.each_with_index do |row, r|
    next if row == nil
    row.each_with_index do |cell, c|
      next if cell == nil
      if vals.include? cell
        neighbors = {nw: vals.include?(check_cell(map,r-1,c-1)),
                     n: vals.include?(check_cell(map,r-1,c)),
                     ne: vals.include?(check_cell(map,r-1,c+1)),
                     e: vals.include?(check_cell(map,r,c+1)),
                     se: vals.include?(check_cell(map,r+1,c+1)),
                     s: vals.include?(check_cell(map,r+1,c)),
                     sw: vals.include?(check_cell(map,r+1,c-1)),
                     w: vals.include?(check_cell(map,r,c-1))
        }
        row[c] = process_cell(tileset, neighbors)
      end
    end
  end
  map
end

# Given a sparse 2D array representing a game map, returns the value at a row
# and column, or nil if the row, column, or value is undefined.
def check_cell(map, r, c)
  return nil if r < 0
  return nil if c < 0
  return nil if map[r] == nil
  return nil if map[r][c] == nil
  return map[r][c]
end

def process_cell(tileset, neighbors)
  return tileset[:nw] if !neighbors[:w] && !neighbors[:n]
  return tileset[:sw] if !neighbors[:w] && !neighbors[:s]
  return tileset[:ne] if !neighbors[:e] && !neighbors[:n]
  return tileset[:se] if !neighbors[:e] && !neighbors[:s]
  return tileset[:e] if !neighbors[:e]
  return tileset[:s] if !neighbors[:s]
  return tileset[:w] if !neighbors[:w]
  return tileset[:n] if !neighbors[:n]
  return tileset[:inw] if !neighbors[:se]
  return tileset[:ine] if !neighbors[:sw]
  return tileset[:isw] if !neighbors[:ne]
  return tileset[:ise] if !neighbors[:nw]
  return tileset[:c]
end

