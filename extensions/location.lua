-- Looks up a region table for the given location query.
function hs.location.geocoder.lookupRegion(query, callback)
  local function callWithRegion(state, result)
    if state then
      callback(state, result[1].region)
    else
      callback(state, result)
    end
  end

  if type(query) == 'string' then
    return hs.location.geocoder.lookupAddress(query, callWithRegion)
  else
    return hs.location.geocoder.lookupLocation(query, callWithRegion)
  end
end
