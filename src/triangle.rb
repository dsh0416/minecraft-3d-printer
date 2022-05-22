require 'matrix'

class Triangle
  attr_reader :points
  def initialize(a, b, c)
    @points = [a, b, c]
    @v0 = c - a
    @v1 = b - a
    @dot00 = @v0.dot(@v0)
    @dot01 = @v0.dot(@v1)
    @dot11 = @v1.dot(@v1)
    @invDenom = 1.0 / (@dot00 * @dot11 - @dot01 * @dot01);
  end

  def range_x
    [points.map { |p| p[0] }.min.floor, points.map { |p| p[0] }.max.ceil]
  end

  def range_y
    [points.map { |p| p[1] }.min.floor, points.map { |p| p[1] }.max.ceil]
  end

  def range_z
    [points.map { |p| p[2] }.min.floor, points.map { |p| p[2] }.max.ceil]
  end

  def contains?(point)
    v2 = point - @points[0]
    dot02 = @v0.dot(v2)
    dot12 = @v1.dot(v2)
    u = (@dot11 * dot02 - @dot01 * dot12) * @invDenom
    return false if (u < 0 || u > 1)
    v = (@dot00 * dot12 - @dot01 * dot02) * @invDenom
    return false if (v < 0 || v > 1)
    return true
  end
end
