 	



printh'-'




function pq(...)
	printh(qq(...))
	return ...
end




function qq(...)
	local res=""
	for ix=1,select("#",...) do
		res..=_quote(select(ix,...),4).." "
	end
	return res
end




function _quote(tab,maxdepth)
	
	if type(tab)~="table" or maxdepth<=0 then
		return tostr(tab)
	end

	local res="{"
	for k,v in next,tab do
		res..=tostr(k).."=".._quote(v,maxdepth-1)..","
	end
	return res.."}"
end