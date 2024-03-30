local function copyImpl(xs) return function() return table.move(xs, 1, #xs, 1, {}) end end

return {
  new = (function() return {} end),
  peekImpl = (function(just, nothing, i, xs)
    return function()
      if i >= 0 and i < #xs then
        return just(xs[i + 1])
      else
        return nothing
      end
    end
  end),
  pokeImpl = (function(i, a, xs)
    local ret = i >= 0 and i < #xs
    if ret then xs[i + 1] = a end
    return ret
  end),
  lengthImpl = (function(xs) return #xs end),
  popImpl = (function(just, nothing, xs)
    if #xs > 0 then
      return just(table.remove(xs))
    else
      return nothing
    end
  end),
  pushAllImpl = (function(as, xs)
    local r = table.move(as, 1, #as, #xs + 1, xs)
    return #r
  end),
  shiftImpl = (function(just, nothing, xs)
    if #xs > 0 then
      return just(table.remove(xs, 1))
    else
      return nothing
    end
  end),
  unshiftAllImpl = (function(as, xs)
    local r = table.move(as, 1, #as, 1, xs)
    return #r
  end),
  spliceImpl = (function(i, howMany, bs, xs) return table.move(xs, i + howMany + 1, #xs, i + #bs + 1, xs) end),
  unsafeFreezeImpl = (function(xs) return xs end),
  unsafeThawImpl = (function(xs) return xs end),
  freeze = (copyImpl),
  thaw = (copyImpl),
  sortByImpl = ((function()
    local function rshift(x, by) return math.floor(x / 2 ^ by) end

    local function mergeFromTo(compare, fromOrdering, xs1, xs2, from, to)
      local mid, i, j, k, x, y, c

      mid = from + rshift(to - from, 1)
      if mid - from > 1 then mergeFromTo(compare, fromOrdering, xs2, xs1, from, mid) end
      if to - mid > 1 then mergeFromTo(compare, fromOrdering, xs2, xs1, mid, to) end

      i = from
      j = mid
      k = from
      while i < mid and j < to do
        x = xs2[i + 1]
        y = xs2[j + 1]
        c = fromOrdering(compare(x)(y))
        if c > 0 then
          xs1[k + 1] = y
          j = j + 1
        else
          xs1[k + 1] = x
          i = i + 1
        end
        k = k + 1
      end
      while i < mid do
        xs1[k + 1] = xs2[i + 1]
        i = i + 1
        k = k + 1
      end
      while j < to do
        xs1[k + 1] = xs2[j + 1]
        j = j + 1
        k = k + 1
      end
    end

    return function(compare, fromOrdering, xs)
      if #xs < 2 then return xs end
      mergeFromTo(compare, fromOrdering, xs, table.move(xs, 1, #xs, 1, {}), 0, #xs)
      return xs
    end
  end)()),
  toAssocArray = (function(xs)
    return function()
      local r = {}
      for i = 1, #xs do r[i] = {index = i - 1, value = xs[i]} end
      return r
    end
  end),
  pushImpl = (function(a, xs)
    xs[#xs + 1] = a
    return #xs
  end)
}
