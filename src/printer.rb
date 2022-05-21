class Printer
  def initialize(filename, origin, block)
    @filename = filename
    @origin = origin
    @block = block
  end

  def print(bitmap, size)
    File.open(@filename, "w") do |f|
      progressbar = ProgressBar.create(title: 'Generating', total: size.reduce(:*), format: '%t...  |%B| %c / %C')
      (0...size[0]).each do |x|
        (0...size[1]).each do |y|
          (0...size[2]).each do |z|
            progressbar.increment
            if bitmap[x][y][z] > 0
              f.puts "/setblock #{@origin[0] + x} #{@origin[1] + z} #{@origin[2] + y} #{@block}"
            end
          end
        end
      end
    end
  end
end
