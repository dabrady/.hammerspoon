-- Round the given number to the given number of decimal places.
function math.round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- Degree/radian conversions
function math.toRadians(degrees)
  return degrees * math.pi / 180;
end
function math.toDegrees(radians)
  return radians * 180 / math.pi;
end
