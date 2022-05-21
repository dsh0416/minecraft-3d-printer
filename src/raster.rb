class Raster
  attr_reader :output_size
  def initialize(triangles, step = 1)
    @triangles = triangles
    @step = step
    @offset = [
      -@triangles.map { |triangle| triangle.range_x[0] }.min,
      -@triangles.map { |triangle| triangle.range_y[0] }.min,
      -@triangles.map { |triangle| triangle.range_z[0] }.min,
    ]

    size = [
      @triangles.map { |t| t.range_x[1] }.max,
      @triangles.map { |t| t.range_y[1] }.max,
      @triangles.map { |t| t.range_z[1] }.max,
    ]

    @output_size = [
      ((size[0] + @offset[0]) / @step).ceil + 1,
      ((size[1] + @offset[1]) / @step).ceil + 1,
      ((size[2] + @offset[2]) / @step).ceil + 1,
    ]

    puts "Output size: #{@output_size}"
    @bitmap = Array.new(@output_size[0]) { Array.new(@output_size[1]) { Array.new(@output_size[2], 0) } }
  end

  def rasterize
    progressbar = ProgressBar.create(title: 'Rasterization', total: @triangles.count, format: '%t: |%B| %c / %C')
    @triangles.each do |triangle|
      progressbar.increment
      (triangle.range_x[0]..triangle.range_x[1]).step(@step) do |x|
        (triangle.range_y[0]..triangle.range_y[1]).step(@step) do |y|
          (triangle.range_z[0]..triangle.range_z[1]).step(@step) do |z|
            @bitmap[(x + @offset[0]).div(@step)][(y + @offset[1]).div(@step)][(z + @offset[2]).div(@step)] = rasterize_pixel(x, y, z, triangle)
          end
        end
      end
    end
    @bitmap
  end

  def rasterize_pixel(x, y, z, triangle)
    return 1 if @bitmap[x][y][z] == 1 # Early-Z
    center = Vector[
      (x * 2 + @step) / 2,
      (y * 2 + @step) / 2,
      (z * 2 + @step) / 2,
    ]
    return 1 if triangle.contains?(center)
    return 0
  end
end
