--- Recipes for common string manipulations in Lua ---

-- Returns true if the given string starts with another, otherwise returns false.
function string.startsWith(str, query)
  return string.sub(str, 1, string.len(query)) == query
end

-- Returns true if the given string ends with another, otherwise returns false.
function string.endsWith(str, query)
  return query == '' or string.sub(str, -string.len(query)) == query
end

-- Removes initial and trailing whitespace
-- @see http://lua-users.org/wiki/StringTrim, 'trim6' implementation
function string.trim(str)
  return str:match'^()%s*$' and '' or str:match'^%s*(.*%S)'
end
