		for i,v in pairs(getgc(true)) do
           		if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
                		v.OpenEgg = function()
                    			return
				            end
			      end
		end
