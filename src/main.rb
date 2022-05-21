require 'matrix'

require 'ruby-progressbar'

require_relative 'parser'
require_relative 'printer'
require_relative 'raster'
require_relative 'triangle'

triangles = Parser.new(ARGV[0]).parse
raster = Raster.new(triangles)
output_size = raster.output_size
bitmap = raster.rasterize
printer = Printer.new(ARGV[1], [0, 0, 0], ARGV[2])
printer.print(bitmap, output_size)
