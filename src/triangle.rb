require 'matrix'

class Triangle
  attr_reader :points
  def initialize(a, b, c)
    @points = [a, b, c]
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

  def is_same_side?(a, b, c, point)
    ab = b - a
    ac = c - a
    ap = point - a
    v1 = ab.cross(ac)
    v2 = ap.cross(ac)
    return v1.dot(v2) >= 0
  end

  def contains?(point)
    return is_same_side?(points[0], points[1], points[2], point) &&
      is_same_side?(points[1], points[2], points[0], point) &&
      is_same_side?(points[2], points[0], points[1], point)
  end
end
