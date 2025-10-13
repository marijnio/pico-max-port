 	

-- pq-debugging v11, by  @pancelor
-- https://www.lexaloffle.com/bbs/?tid=42367
printh'-'

-- quote all args and print to host console
-- usage:
--   pq("handles nils", many_vars, {tables=1, work=22, too=333})
function pq(...)
	printh(qq(...))
	return ...
end

-- quote all arguments into a string,
-- usage:
--   x=2 y=3 ?qq("x",x,"y",y)
function qq(...)
	local res=""
	for ix=1,select("#",...) do
		res..=_quote(select(ix,...),4).." "
	end
	return res
end

-- quote a single thing
-- like tostr(), but works for tables too
-- (don't call this directly; call pq or qq instead)
function _quote(tab,maxdepth)
	--avoid inf loop
	if type(tab)~="table" or maxdepth<=0 then
		return tostr(tab)
	end

	local res="{"
	for k,v in next,tab do
		res..=tostr(k).."=".._quote(v,maxdepth-1)..","
	end
	return res.."}"
end