client/proc/Zone_Info(turf/T as null|turf)
	set category = "Debug"
	if(T)
		if(T.zone)
			T.zone.DebugDisplay(mob)
		else
			mob << "No zone here."
	else
		for(T in world)
			T.overlays -= 'icons/debug_space.dmi'
			T.overlays -= 'icons/debug_group.dmi'
			T.overlays -= 'icons/debug_connect.dmi'

zone/proc
	DebugDisplay(mob/M)
		if(!dbg_output)
			dbg_output = 1
			for(var/turf/T in contents)
				T.overlays += 'icons/debug_group.dmi'

			for(var/turf/space/S in space_tiles)
				S.overlays += 'icons/debug_space.dmi'

			M << "<u>Zone Air Contents</u>"
			M << "Oxygen: [air.oxygen]"
			M << "Nitrogen: [air.nitrogen]"
			M << "Plasma: [air.toxins]"
			M << "Carbon Dioxide: [air.carbon_dioxide]"
			M << "Temperature: [air.temperature]"
			M << "Heat Energy: [air.thermal_energy()]"
			M << "Pressure: [air.return_pressure()]"
			M << ""
			M << "<u>Connections: [length(connections)]</u>"

			for(var/connection/C in connections)
				M << "[C.A] --> [C.B] [(C.indirect?"Indirect":"Direct")]"
				C.A.overlays += 'icons/debug_connect.dmi'
				C.B.overlays += 'icons/debug_connect.dmi'
				spawn(50)
					C.A.overlays -= 'icons/debug_connect.dmi'
					C.B.overlays -= 'icons/debug_connect.dmi'

		else
			dbg_output = 0

			for(var/turf/T in contents)
				T.overlays -= 'icons/debug_group.dmi'

			for(var/turf/space/S in space_tiles)
				S.overlays -= 'icons/debug_space.dmi'
		for(var/zone/Z in ZAS_zones)
			if(Z.air == air)
				var/turf/zloc = pick(Z.contents)
				M << "\red Illegal air datum shared by: [zloc.loc.name]"
