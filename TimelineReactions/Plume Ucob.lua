local tbl = 
{
	[2] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "c831846c-06b3-aa88-603b-093a4981e2dc",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Eclosion - Fleche neurolien",
				uuid = "337c22e4-b055-99e4-a849-ebb4cb3c515f",
				version = 2,
			},
			inheritedObjectUUID = "ebad5f38-4885-d0c0-b3b4-e703e343d045",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Eclosion - Fleche neurolien",
								uuid = "61243705-b17b-03a4-ac5d-bb742cb50062",
								version = 2.1,
							},
							inheritedObjectUUID = "bfd4fdb3-eb29-91f9-a451-6be3637ca6ee",
							inheritedOverwrites = 
							{
								actionLua = "local s = data.ucob_nearest_hatch\nif not s or not s.target then self.used = true; return end\nlocal remaining = math.floor(math.min(s.expires - Now(), (1500 - TensorReactions_CurrentTimer) * 1000))\nlocal p = TensorCore.mGetPlayer()\nlocal e = TensorCore.mGetEntity(s.target)\nif not p or not p.alive or p.hp.current <= 0 or not e or e.contentid ~= 2001151 or remaining <= 0 then\n    if s.arrow then Argus.deleteTimedShape(s.arrow) end\n    if s.ring then Argus.deleteTimedShape(s.ring) end\n    data.ucob_nearest_hatch = nil\n    self.used = true\n    return\nend\nlocal dx, dz = p.pos.x - e.pos.x, p.pos.z - e.pos.z\nlocal distanceSquared = dx * dx + dz * dz\nlocal ring = TensorCore.getCachedDrawer(0x30FFF060, nil, 0x30FFF060, 0xFFFFF060, 4)\nif s.ring and not ring:updateTimedCircleOnEnt(s.ring, nil, s.target, 2, 0, false, true) then s.ring = nil end\nif not s.ring then s.ring = ring:addTimedCircleOnEnt(remaining, s.target, 2, 0, false, true) end\nif distanceSquared <= 4 then\n    s.arrived = true\nelseif distanceSquared >= 5.0625 then\n    s.arrived = false\nend\nif not s.arrived then\n    local drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\n    drawer:setGradient(0.25, 0.4, 1.5)\n    -- Explicit distance and absolute heading place the tip at the destination.\n    local distance = math.sqrt(distanceSquared)\n    local tipLength = math.min(1.1, distance * 0.4)\n    local baseLength = distance - tipLength\n    local heading = TensorCore.getHeadingToTarget(p.pos, e.pos)\n    -- Replace an old target-attached arrow once, then keep updating the same shape.\n    if not s.fullLengthArrow then\n        if s.arrow then Argus.deleteTimedShape(s.arrow); s.arrow = nil end\n        s.fullLengthArrow = true\n    end\n    if s.arrow and not drawer:updateTimedArrowOnEnt(s.arrow, nil, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) then s.arrow = nil end\n    if not s.arrow then s.arrow = drawer:addTimedArrowOnEnt(remaining, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) end\nelseif s.arrow then\n    Argus.deleteTimedShape(s.arrow)\n    s.arrow = nil\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide central",
				uuid = "55a536a1-319b-45d9-ae10-3b49e2efd6ee",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nif not data.ucob_guide then\n    local g = { cues = {}, seen = {}, phase = 1, serial = 0, slotLayout = \"LR\", slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}, stacks = {}, shakers = {}, octet = {}, hatch = {} }\n    data.ucob_guide = g\n    data.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\n    function g.put(key, title, detail, nextText, priority, ttl, voice)\n        local now = Now()\n        local c = g.cues[key]\n        if not c then c = {}; g.cues[key] = c end\n        if c.title ~= title or not c.expires or c.expires <= now then\n            g.serial = g.serial + 1\n            c.serial = g.serial\n            c.born = now\n            c.spoken = false\n        end\n        c.title = title\n        c.detail = detail\n        c.nextText = nextText\n        c.priority = priority or 50\n        c.expires = now + ttl\n        c.voice = voice\n        return c\n    end\n    function g.drop(key)\n        local c = g.cues[key]\n        if c then c.expires = 0 end\n    end\n    function g.clear()\n        for _, c in pairs(g.cues) do c.expires = 0 end\n        for k in pairs(g.stacks) do g.stacks[k] = nil end\n        for k in pairs(g.shakers) do g.shakers[k] = nil end\n        for k in pairs(g.octet) do g.octet[k] = nil end\n        for k in pairs(g.hatch) do g.hatch[k] = nil end\n        g.stackCount, g.shakerCount = 0, 0\n        g.octetCount, g.shakerWave = 0, 0\n        g.shakerFirstMine = nil\n        g.mineStack, g.markerExpires, g.hatchExpires, g.octetMine = nil, nil, nil, nil\n    end\n    function g.tank(p)\n        return p.job == 19 or p.job == 21 or p.job == 32 or p.job == 37\n    end\n    function g.healer(p)\n        return p.job == 24 or p.job == 28 or p.job == 33 or p.job == 40\n    end\n    function g.select(now)\n        local best\n        for _, c in pairs(g.cues) do\n            if c.expires > now and (not best or c.priority > best.priority or\n                (c.priority == best.priority and c.serial > best.serial)) then best = c end\n        end\n        g.best = best\n        return best\n    end\n    function g.once(key, hold)\n        local now = Now()\n        if g.seen[key] and now - g.seen[key] < hold then return false end\n        g.seen[key] = now\n        return true\n    end\nend\nlocal s = data.ucob_guide\nif s.slotLayout ~= \"LR\" then\n    s.slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}\n    s.slotLayout = \"LR\"\nend\ndata.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\nif data.ucob_guide_settings.slotLayout ~= \"LR\" then\n    data.ucob_guide_settings.slot = 0\n    data.ucob_guide_settings.slotLayout = \"LR\"\nend\n\nlocal p = TensorCore.mGetPlayer()\nif not p then self.used = true return end\nlocal id = eventArgs.spellID\nlocal duration = math.max(300, (eventArgs.channelTimeMax or 0) * 1000)\nlocal now = Now()\nif id >= 9954 and id <= 9959 then\n    s.clear()\n    data.ucob_tower_nael = nil\n    data.ucob_fireball_guide = nil\n    data.ucob_twister_until = nil\n    s.towerReady, s.towerKnockback = nil, nil\n    s.hfDiveDone, s.blackfireNovas = nil, 0\n    s.phase, s.trio = 3, id\n    s.personalMegaUntil = nil\n    s.hfBaitUntil = id == 9957 and now + duration or nil\n    local names = {[9954]=\"QUICKMARCH\", [9955]=\"BLACKFIRE\", [9956]=\"FELLRUIN\", [9957]=\"HEAVENSFALL\", [9958]=\"TENSTRIKE\", [9959]=\"GRAND OCTET\"}\n    s.put(\"trio\", names[id], \"Prépare ton placement de départ\", nil, 35, duration + 2000)\nelseif id == 9898 then\n    s.twintaniaID = eventArgs.entityID\n    -- Ground effects can arrive after the cast event; keep a short placement margin.\n    data.ucob_twister_until = now + duration + 900\n    local nextText = data.ucob_fireball_guide and \"Ensuite : PARTAGE BOULE DE FEU\" or \"Évite les tornades laissées au sol\"\n    s.put(\"twister\", \"BOUGE — TWISTER\", \"Petit déplacement continu ; évite de revenir sur tes pas\", nextText, 100, duration + 900, \"Twister, bouge\")\nelseif id == 9906 then\n    s.put(\"dive\", \"ÉVITE LE DIVE\", \"Reste hors du passage de Gémellia\", \"TWISTER au passage du dive\", 88, duration + 300)\nelseif id == 9897 or id == 9941 then\n    if eventArgs.targetID == p.id then\n        s.put(\"buster\", \"TANKBUSTER SUR TOI\", \"Prépare ta mitigation ; reste séparé du groupe\", nil, 86, duration + 300, \"Tankbuster\")\n    elseif s.tank(p) then\n        s.put(\"buster\", \"TANKBUSTER — AUTRE TANK\", \"Prépare l'échange prévu par votre stratégie\", nil, 50, duration + 300)\n    end\nelseif id == 9911 or id == 9912 then\n    if s.phase < 3 then s.phase = 2 end\n    s.put(\"recul\", \"PRÉPARE LE RECUL\", \"Ajuste ton placement avant l'impact\", \"Évite les zones au sol\", 68, duration + 300)\nelseif id == 9953 or id == 9923 then\n    s.put(\"dive\", \"ÉVITE LE DIVE\", \"Sors de l'axe de la charge\", nil, 78, duration + 300)\nelseif id == 9942 then\n    s.phase = 3\n    s.put(\"raidwide\", \"GIGAFLARE — DÉGÂTS DE GROUPE\", \"Prépare les soins et mitigations prévus\", nil, 40, duration + 300)\nelseif id == 9905 then\n    s.put(\"abri\", \"ABRI — NEUROLIEN\", \"Rejoins le neurolien prévu pour ton groupe\", \"Reste jusqu'à la résolution\", 85, duration + 200, \"Neurolien\")\nelseif id == 9915 or id == 9916 or id == 9917 or id == 9918 or id == 9920 or id == 9921 then\n    if s.phase < 3 then s.phase = 2 end\n    local q = data.ucob_nael_calls\n    if not q or not q.hudUntil or q.hudUntil < now then\n        local title, detail\n        if id == 9915 then title, detail = \"OUT — ÉLOIGNE-TOI\", \"Sors de la zone autour de Nael\"\n        elseif id == 9916 then title, detail = \"IN — SOUS NAEL\", \"Rejoins l'intérieur du donut\"\n        elseif id == 9917 then title, detail = \"STACK — REGROUPEMENT\", \"Rejoins le partage ; garde la foudre à l'écart\"\n        elseif id == 9921 then\n            title = eventArgs.targetID == p.id and \"TANK — ISOLE-TOI\" or \"ÉCARTE-TOI DU TANK\"\n            detail = \"Laisse la zone du Dalamud Dive libre\"\n        else title, detail = \"SPREAD — ÉCARTEZ-VOUS\", \"Garde ton espace personnel\" end\n        s.put(\"castMove\", title, detail, nil, 80, duration + 300)\n    end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"1de8cfbe-a805-31ac-814a-44d50961e8fa",
									true,
								},
							},
							name = "Mettre à jour la consigne",
							uuid = "049ff120-55f1-8149-9248-706952c33eec",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Événement de mécanique",
							spellIDList = 
							{
								9898,
								9906,
								9897,
								9941,
								9911,
								9912,
								9953,
								9923,
								9942,
								9905,
								9915,
								9916,
								9917,
								9918,
								9920,
								9921,
								9954,
								9955,
								9956,
								9957,
								9958,
								9959,
							},
							uuid = "1de8cfbe-a805-31ac-814a-44d50961e8fa",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Guide central",
				eventType = 3,
				loop = true,
				mechanicTime = 7,
				name = "Guide - Casts et debut des trios",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 836.3,
				timerStartOffset = -7,
				uuid = "932a3c9c-5f58-4726-b49b-89278b14eabd",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nif not data.ucob_guide then\n    local g = { cues = {}, seen = {}, phase = 1, serial = 0, slotLayout = \"LR\", slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}, stacks = {}, shakers = {}, octet = {}, hatch = {} }\n    data.ucob_guide = g\n    data.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\n    function g.put(key, title, detail, nextText, priority, ttl, voice)\n        local now = Now()\n        local c = g.cues[key]\n        if not c then c = {}; g.cues[key] = c end\n        if c.title ~= title or not c.expires or c.expires <= now then\n            g.serial = g.serial + 1\n            c.serial = g.serial\n            c.born = now\n            c.spoken = false\n        end\n        c.title = title\n        c.detail = detail\n        c.nextText = nextText\n        c.priority = priority or 50\n        c.expires = now + ttl\n        c.voice = voice\n        return c\n    end\n    function g.drop(key)\n        local c = g.cues[key]\n        if c then c.expires = 0 end\n    end\n    function g.clear()\n        for _, c in pairs(g.cues) do c.expires = 0 end\n        for k in pairs(g.stacks) do g.stacks[k] = nil end\n        for k in pairs(g.shakers) do g.shakers[k] = nil end\n        for k in pairs(g.octet) do g.octet[k] = nil end\n        for k in pairs(g.hatch) do g.hatch[k] = nil end\n        g.stackCount, g.shakerCount = 0, 0\n        g.octetCount, g.shakerWave = 0, 0\n        g.shakerFirstMine = nil\n        g.mineStack, g.markerExpires, g.hatchExpires, g.octetMine = nil, nil, nil, nil\n    end\n    function g.tank(p)\n        return p.job == 19 or p.job == 21 or p.job == 32 or p.job == 37\n    end\n    function g.healer(p)\n        return p.job == 24 or p.job == 28 or p.job == 33 or p.job == 40\n    end\n    function g.select(now)\n        local best\n        for _, c in pairs(g.cues) do\n            if c.expires > now and (not best or c.priority > best.priority or\n                (c.priority == best.priority and c.serial > best.serial)) then best = c end\n        end\n        g.best = best\n        return best\n    end\n    function g.once(key, hold)\n        local now = Now()\n        if g.seen[key] and now - g.seen[key] < hold then return false end\n        g.seen[key] = now\n        return true\n    end\nend\nlocal s = data.ucob_guide\nif s.slotLayout ~= \"LR\" then\n    s.slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}\n    s.slotLayout = \"LR\"\nend\ndata.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\nif data.ucob_guide_settings.slotLayout ~= \"LR\" then\n    data.ucob_guide_settings.slot = 0\n    data.ucob_guide_settings.slotLayout = \"LR\"\nend\n\nlocal p = TensorCore.mGetPlayer()\nif not p then self.used = true return end\nlocal id, now = eventArgs.spellID, Now()\nif id == 9903 then\n    for _, hit in ipairs(eventArgs.hitTargets) do\n        if hit == p.id then s.drop(\"hatch\"); s.hatchExpires = nil end\n    end\n    self.used = true return\nend\nif not s.once(\"cast\"..id, 400) then self.used = true return end\nif id == 9898 then\n    data.ucob_twister_until = math.max(data.ucob_twister_until or 0, now + 650)\n    local nextText = data.ucob_fireball_guide and \"Ensuite : PARTAGE BOULE DE FEU\" or \"Évite les tornades laissées au sol\"\n    s.put(\"twister\", \"BOUGE — TWISTER\", \"Termine ton déplacement ; ne reviens pas sur tes pas\", nextText, 100, data.ucob_twister_until - now)\n    s.put(\"twisterDone\", \"TWISTERS POSÉS\", \"Évite les tornades ; reprends ton placement\", nil, 30, 2000)\nelseif id == 9906 then\n    if s.trio == 9957 then s.hfDiveDone = now end\n    s.drop(\"dive\")\n    data.ucob_twister_until = now + 2200\n    s.put(\"twister\", \"BOUGE — TWISTER\", \"Déplace-toi après le dive ; ne reviens pas sur tes pas\", nil, 100, 2200, \"Twister, bouge\")\nelseif id == 9919 then\n    if s.trio == 9955 then s.blackfireNovas = (s.blackfireNovas or 0) + 1 end\nelseif id == 9900 then\n    s.drop(\"fireball\")\n    data.ucob_fireball_guide = nil\nelseif id == 9897 or id == 9941 then s.drop(\"buster\"); s.drop(\"tankPrep\")\nelseif id == 9915 or id == 9916 or id == 9917 or id == 9918 or id == 9920 or id == 9921 then\n    s.drop(\"castMove\")\nelseif id == 9911 or id == 9912 then\n    if id == 9912 and s.trio == 9957 then s.towerKnockback = now end\n    s.drop(\"recul\")\n    s.put(\"reculDone\", \"ÉVITE LES ZONES AU SOL\", \"Reprends ton placement après le recul\", nil, 45, 2500)\nelseif id == 9940 then\n    s.phase = 3\n    s.breathCount = (s.breathCount or 0) + 1\nelseif id == 9942 then s.drop(\"raidwide\"); s.drop(\"raidPrep\")\nelseif id == 9948 then s.drop(\"spreadPrep\")\nelseif id == 9949 then s.drop(\"groundPrep\")\nelseif id == 9950 then\n    s.personalMegaUntil = nil\n    if s.trio == 9955 then s.towerReady = now end\n    s.drop(\"stackPrep\"); s.drop(\"assignment\")\nelseif id == 9951 then s.drop(\"towerPrep\")\nelseif id == 9945 then\n    if s.trio == 9958 and s.shakerFirstMine == false and (s.shakerWave or 0) == 1 then\n        s.put(\"shaker\", \"DEUXIÈME VAGUE — PRENDS TON SECTEUR\", \"La première vague vient de passer\", nil, 94, 5000, \"Deuxième vague\")\n    else s.drop(\"shaker\") end\nelseif id == 9943 then s.drop(\"tetherPrep\")\nelseif id == 9905 then\n    s.drop(\"abri\"); s.drop(\"shelterPrep\")\n    if s.trio == 9956 then s.put(\"spreadPrep\", \"SPREAD — SORS DU GROUPE\", \"Prépare Meteor Stream\", nil, 82, 3300) end\nelseif id == 9901 then\n    if not s.liquidAt or now - s.liquidAt > 6000 then s.liquidCount = 0 end\n    s.liquidAt = now\n    s.liquidCount = math.min(5, (s.liquidCount or 0) + 1)\n    s.put(\"liquid\", \"LIQUID HELL — \" .. s.liquidCount .. \"/5\", \"Le joueur chargé du bait continue ; garde les flaques hors du groupe\", nil, 45, 2200)\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"1f0d1348-eba9-529c-a7ae-8b5b7fb228e4",
									true,
								},
							},
							name = "Mettre à jour la consigne",
							uuid = "b9e4ea57-cb25-ce48-aec0-8de88fe490d2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Événement de mécanique",
							spellIDList = 
							{
								9898,
								9906,
								9900,
								9897,
								9941,
								9915,
								9916,
								9917,
								9918,
								9920,
								9921,
								9911,
								9912,
								9940,
								9942,
								9948,
								9949,
								9950,
								9951,
								9945,
								9943,
								9905,
								9901,
								9903,
								9919,
							},
							uuid = "1f0d1348-eba9-529c-a7ae-8b5b7fb228e4",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Guide central",
				eventType = 2,
				loop = true,
				mechanicTime = 7,
				name = "Guide - Resolutions et changements d'etape",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 836.3,
				timerStartOffset = -7,
				uuid = "dd6ab0b2-a57e-bf79-9d1a-a918f711545c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nif not data.ucob_guide then\n    local g = { cues = {}, seen = {}, phase = 1, serial = 0, slotLayout = \"LR\", slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}, stacks = {}, shakers = {}, octet = {}, hatch = {} }\n    data.ucob_guide = g\n    data.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\n    function g.put(key, title, detail, nextText, priority, ttl, voice)\n        local now = Now()\n        local c = g.cues[key]\n        if not c then c = {}; g.cues[key] = c end\n        if c.title ~= title or not c.expires or c.expires <= now then\n            g.serial = g.serial + 1\n            c.serial = g.serial\n            c.born = now\n            c.spoken = false\n        end\n        c.title = title\n        c.detail = detail\n        c.nextText = nextText\n        c.priority = priority or 50\n        c.expires = now + ttl\n        c.voice = voice\n        return c\n    end\n    function g.drop(key)\n        local c = g.cues[key]\n        if c then c.expires = 0 end\n    end\n    function g.clear()\n        for _, c in pairs(g.cues) do c.expires = 0 end\n        for k in pairs(g.stacks) do g.stacks[k] = nil end\n        for k in pairs(g.shakers) do g.shakers[k] = nil end\n        for k in pairs(g.octet) do g.octet[k] = nil end\n        for k in pairs(g.hatch) do g.hatch[k] = nil end\n        g.stackCount, g.shakerCount = 0, 0\n        g.octetCount, g.shakerWave = 0, 0\n        g.shakerFirstMine = nil\n        g.mineStack, g.markerExpires, g.hatchExpires, g.octetMine = nil, nil, nil, nil\n    end\n    function g.tank(p)\n        return p.job == 19 or p.job == 21 or p.job == 32 or p.job == 37\n    end\n    function g.healer(p)\n        return p.job == 24 or p.job == 28 or p.job == 33 or p.job == 40\n    end\n    function g.select(now)\n        local best\n        for _, c in pairs(g.cues) do\n            if c.expires > now and (not best or c.priority > best.priority or\n                (c.priority == best.priority and c.serial > best.serial)) then best = c end\n        end\n        g.best = best\n        return best\n    end\n    function g.once(key, hold)\n        local now = Now()\n        if g.seen[key] and now - g.seen[key] < hold then return false end\n        g.seen[key] = now\n        return true\n    end\nend\nlocal s = data.ucob_guide\nif s.slotLayout ~= \"LR\" then\n    s.slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}\n    s.slotLayout = \"LR\"\nend\ndata.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\nif data.ucob_guide_settings.slotLayout ~= \"LR\" then\n    data.ucob_guide_settings.slot = 0\n    data.ucob_guide_settings.slotLayout = \"LR\"\nend\n\nlocal p = TensorCore.mGetPlayer()\nif not p or not p.alive then self.used = true return end\nlocal id, target, now = eventArgs.markerID, eventArgs.entityID, Now()\nif id == 117 then\n    local f = data.ucob_fireball_guide\n    if f and f.target == target and now - f.started < 1000 then self.used = true return end\n    if not f then f = {}; data.ucob_fireball_guide = f end\n    f.target, f.started, f.expires = target, now, now + 10000\n    -- The marker may precede the Twister cast by a fraction of a second.\n    f.holdUntil, f.nextCount, f.voiceDone = now + 500, 0, false\n    f.count, f.partyCount, f.countText = nil, nil, nil\n    s.drop(\"fireball\")\nelseif id == 118 then\n    if not s.hatch[target] then s.hatch[target] = true end\n    if target == p.id then\n        s.hatchExpires = now + 12000\n        s.put(\"hatch\", \"HATCH SUR TOI — NEUROLIEN\", \"Utilise ton neurolien attribué ; ne traverse pas les autres porteurs\", nil, 94, 12000, \"Hatch sur toi\")\n    end\nelseif id == 39 then\n    if target == p.id and s.phase == 3 then s.personalMegaUntil = now + 6500 end\n    if not s.stacks[target] then\n        s.stacks[target] = true\n        s.stackCount = (s.stackCount or 0) + 1\n    end\n    s.markerExpires = now + 18000\n    if target == p.id then s.mineStack = true end\n    if s.trio == 9955 then\n        if s.mineStack then\n            s.put(\"assignment\", \"TON RÔLE : STACK\", \"Termine le bait avant de rejoindre le partage\", \"STACK après les Hypernovas\", 42, 12000)\n        elseif s.stackCount == 4 then\n            s.put(\"assignment\", \"TON RÔLE : TOUR\", \"Termine le bait avant d'entrer dans ta tour\", \"TOUR après le partage\", 42, 12000)\n        end\n    end\nelseif id == 40 then\n    if not s.shakerMarkAt or now - s.shakerMarkAt > 2500 then\n        for k in pairs(s.shakers) do s.shakers[k] = nil end\n        s.shakerCount = 0\n        s.shakerWave = (s.shakerWave or 0) + 1\n        s.shakerMarkAt = now\n    end\n    if not s.shakers[target] then s.shakers[target] = true; s.shakerCount = s.shakerCount + 1 end\n    if target == p.id then\n        if s.shakerWave == 1 then s.shakerFirstMine = true end\n        s.put(\"shaker\", \"EARTHSHAKER SUR TOI — ÉCARTE-TOI\", \"Oriente ta secousse hors du groupe, vers ton secteur\", nil, 96, 6500, \"Secousse sur toi\")\n    elseif s.trio == 9958 and s.shakerWave == 1 and s.shakerCount == 4 and not s.shakers[p.id] then\n        s.shakerFirstMine = false\n        s.put(\"assignment\", \"EARTHSHAKER : DEUXIÈME VAGUE\", \"Attends la première vague avant de prendre ton secteur\", nil, 45, 11000)\n    end\nelseif s.trio == 9959 and (id == 119 or id == 20 or id == 41 or id == 42) then\n    if not s.octet[target] then s.octet[target] = true; s.octetCount = (s.octetCount or 0) + 1 end\n    if target == p.id then\n        s.octetMine = true\n        local dragon = id == 119 and \"NAEL\" or id == 41 and \"BAHAMUT\" or id == 42 and \"GÉMELLIA\" or \"DRAGON\"\n        local detail = id == 42 and \"Isole le dernier dive du partage selon votre placement\" or \"Dépose la charge avec le groupe, puis poursuis la rotation prévue\"\n        s.put(\"octetBait\", dragon .. \" SUR TOI — BAIT\", detail, id == 42 and \"Puis BOUGE pour Twister\" or nil, 90, 5000, \"Dive sur toi\")\n    elseif id == 41 then\n        s.octetCheckAt = now + 700\n    end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"8e156b2b-2393-4c08-b649-da40bb75e31f",
									true,
								},
							},
							name = "Mettre à jour la consigne",
							uuid = "3c6a2c01-b1f1-1831-b993-6aaae1f6f9fb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							markerIDList = 
							{
								117,
								118,
								39,
								40,
								119,
								20,
								41,
								42,
							},
							name = "Événement de mécanique",
							uuid = "8e156b2b-2393-4c08-b649-da40bb75e31f",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Guide central",
				eventType = 4,
				loop = true,
				mechanicTime = 7,
				name = "Guide - Affectations personnelles",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 836.3,
				timerStartOffset = -7,
				uuid = "a088981c-cfcf-bc64-8e5e-a9fd8fa147c2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nif not data.ucob_guide then\n    local g = { cues = {}, seen = {}, phase = 1, serial = 0, slotLayout = \"LR\", slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}, stacks = {}, shakers = {}, octet = {}, hatch = {} }\n    data.ucob_guide = g\n    data.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\n    function g.put(key, title, detail, nextText, priority, ttl, voice)\n        local now = Now()\n        local c = g.cues[key]\n        if not c then c = {}; g.cues[key] = c end\n        if c.title ~= title or not c.expires or c.expires <= now then\n            g.serial = g.serial + 1\n            c.serial = g.serial\n            c.born = now\n            c.spoken = false\n        end\n        c.title = title\n        c.detail = detail\n        c.nextText = nextText\n        c.priority = priority or 50\n        c.expires = now + ttl\n        c.voice = voice\n        return c\n    end\n    function g.drop(key)\n        local c = g.cues[key]\n        if c then c.expires = 0 end\n    end\n    function g.clear()\n        for _, c in pairs(g.cues) do c.expires = 0 end\n        for k in pairs(g.stacks) do g.stacks[k] = nil end\n        for k in pairs(g.shakers) do g.shakers[k] = nil end\n        for k in pairs(g.octet) do g.octet[k] = nil end\n        for k in pairs(g.hatch) do g.hatch[k] = nil end\n        g.stackCount, g.shakerCount = 0, 0\n        g.octetCount, g.shakerWave = 0, 0\n        g.shakerFirstMine = nil\n        g.mineStack, g.markerExpires, g.hatchExpires, g.octetMine = nil, nil, nil, nil\n    end\n    function g.tank(p)\n        return p.job == 19 or p.job == 21 or p.job == 32 or p.job == 37\n    end\n    function g.healer(p)\n        return p.job == 24 or p.job == 28 or p.job == 33 or p.job == 40\n    end\n    function g.select(now)\n        local best\n        for _, c in pairs(g.cues) do\n            if c.expires > now and (not best or c.priority > best.priority or\n                (c.priority == best.priority and c.serial > best.serial)) then best = c end\n        end\n        g.best = best\n        return best\n    end\n    function g.once(key, hold)\n        local now = Now()\n        if g.seen[key] and now - g.seen[key] < hold then return false end\n        g.seen[key] = now\n        return true\n    end\nend\nlocal s = data.ucob_guide\nif s.slotLayout ~= \"LR\" then\n    s.slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}\n    s.slotLayout = \"LR\"\nend\ndata.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\nif data.ucob_guide_settings.slotLayout ~= \"LR\" then\n    data.ucob_guide_settings.slot = 0\n    data.ucob_guide_settings.slotLayout = \"LR\"\nend\n\nlocal p=TensorCore.mGetPlayer()\nif p and eventArgs.entityID == p.id and eventArgs.ownerContentID == 2210 then\n    s.drop(\"hatch\")\n    s.hatchExpires=nil\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"5128c049-be7e-9043-9ab4-f4b472cc376d",
									true,
								},
							},
							name = "Mettre à jour la consigne",
							uuid = "a16f7f8c-887c-50c9-8266-9001d38a1a36",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventBuffID = 1434,
							name = "Événement de mécanique",
							uuid = "5128c049-be7e-9043-9ab4-f4b472cc376d",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Guide central",
				eventType = 8,
				loop = true,
				mechanicTime = 7,
				name = "Guide - Impact Hatch confirme",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 836.3,
				timerStartOffset = -7,
				uuid = "d86fefac-dd4d-f59e-aef8-5a89801594e2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide central",
				execute = "\nif not data.ucob_guide then\n    local g = { cues = {}, seen = {}, phase = 1, serial = 0, slotLayout = \"LR\", slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}, stacks = {}, shakers = {}, octet = {}, hatch = {} }\n    data.ucob_guide = g\n    data.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\n    function g.put(key, title, detail, nextText, priority, ttl, voice)\n        local now = Now()\n        local c = g.cues[key]\n        if not c then c = {}; g.cues[key] = c end\n        if c.title ~= title or not c.expires or c.expires <= now then\n            g.serial = g.serial + 1\n            c.serial = g.serial\n            c.born = now\n            c.spoken = false\n        end\n        c.title = title\n        c.detail = detail\n        c.nextText = nextText\n        c.priority = priority or 50\n        c.expires = now + ttl\n        c.voice = voice\n        return c\n    end\n    function g.drop(key)\n        local c = g.cues[key]\n        if c then c.expires = 0 end\n    end\n    function g.clear()\n        for _, c in pairs(g.cues) do c.expires = 0 end\n        for k in pairs(g.stacks) do g.stacks[k] = nil end\n        for k in pairs(g.shakers) do g.shakers[k] = nil end\n        for k in pairs(g.octet) do g.octet[k] = nil end\n        for k in pairs(g.hatch) do g.hatch[k] = nil end\n        g.stackCount, g.shakerCount = 0, 0\n        g.octetCount, g.shakerWave = 0, 0\n        g.shakerFirstMine = nil\n        g.mineStack, g.markerExpires, g.hatchExpires, g.octetMine = nil, nil, nil, nil\n    end\n    function g.tank(p)\n        return p.job == 19 or p.job == 21 or p.job == 32 or p.job == 37\n    end\n    function g.healer(p)\n        return p.job == 24 or p.job == 28 or p.job == 33 or p.job == 40\n    end\n    function g.select(now)\n        local best\n        for _, c in pairs(g.cues) do\n            if c.expires > now and (not best or c.priority > best.priority or\n                (c.priority == best.priority and c.serial > best.serial)) then best = c end\n        end\n        g.best = best\n        return best\n    end\n    function g.once(key, hold)\n        local now = Now()\n        if g.seen[key] and now - g.seen[key] < hold then return false end\n        g.seen[key] = now\n        return true\n    end\nend\nlocal s = data.ucob_guide\nif s.slotLayout ~= \"LR\" then\n    s.slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}\n    s.slotLayout = \"LR\"\nend\ndata.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\nif data.ucob_guide_settings.slotLayout ~= \"LR\" then\n    data.ucob_guide_settings.slot = 0\n    data.ucob_guide_settings.slotLayout = \"LR\"\nend\n\nlocal p = TensorCore.mGetPlayer()\nif not p then self.used = true return end\nlocal now = Now()\nif not p.alive or p.hp.current <= 0 then\n    data.ucob_fireball_guide = nil\n    s.clear(); s.best = nil; self.used = true return\nend\n\n-- Count living party members at the existing 100ms guide cadence, never per frame.\nlocal f = data.ucob_fireball_guide\nif f and now < f.expires then\n    local target = TensorCore.mGetEntity(f.target)\n    if target and (not target.alive or target.hp.current <= 0) then\n        data.ucob_fireball_guide = nil\n        s.drop(\"fireball\")\n    else\n        if now >= f.nextCount then\n            f.nextCount = now + 100\n            f.count, f.partyCount = nil, 0\n            local party = target and TensorCore.getEntityGroupList(\"Party\")\n            if party and next(party) ~= nil then\n                f.count = 0\n                for _, member in pairs(party) do\n                    f.partyCount = f.partyCount + 1\n                    if member.alive and member.hp.current > 0 then\n                        local dx, dz = member.pos.x - target.pos.x, member.pos.z - target.pos.z\n                        if dx * dx + dz * dz <= 16 then f.count = f.count + 1 end\n                    end\n                end\n            end\n            if f.count then\n                f.countText = string.format(\"%d joueur%s vivant%s dans le cercle · cible comprise\", f.count, f.count == 1 and \"\" or \"s\", f.count == 1 and \"\" or \"s\")\n                if f.partyCount ~= 8 then f.countText = f.countText .. \" · groupe incomplet\" end\n            else\n                f.countText = \"Comptage indisponible\"\n            end\n        end\n        local twister = data.ucob_twister_until and now < data.ucob_twister_until\n        local waiting = twister or now < f.holdUntil or not target or not f.count\n        local mine = f.target == p.id\n        local instruction, voice\n        if twister then\n            instruction = \"TWISTER d'abord → PARTAGE ensuite\"\n            local cue = s.cues.twister\n            if cue and cue.expires > now then cue.nextText = \"Ensuite : PARTAGE BOULE DE FEU\" end\n        elseif now < f.holdUntil then\n            instruction = \"Repère la cible du partage\"\n        elseif not target then\n            instruction = \"Position de la cible indisponible\"\n        elseif mine and f.count == 1 then\n            instruction = \"Tu es seul : rejoins ton groupe de partage\"\n        else\n            instruction = mine and \"Rejoins ton groupe de partage\" or \"Rejoins le joueur indiqué en évitant les tornades\"\n        end\n        if not waiting and not f.voiceDone then voice = mine and \"Boule de feu sur toi, rejoins le partage\" or \"Maintenant, partage boule de feu\" end\n        s.put(\"fireball\", mine and \"BOULE DE FEU SUR TOI — PARTAGE\" or \"BOULE DE FEU — PARTAGE\",\n            f.countText or \"Comptage en cours\", instruction, 65, math.min(350, f.expires - now), voice)\n    end\nelse\n    if f then data.ucob_fireball_guide = nil end\n    s.drop(\"fireball\")\nend\n\nif s.phase == 1 and s.twintaniaID and s.tank(p) then\n    local boss = TensorCore.mGetEntity(s.twintaniaID)\n    if boss and boss.alive and boss.targetid == p.id then\n        local count=0\n        if data.ucob_nearest_links then\n            for id in pairs(data.ucob_nearest_links) do\n                local link=TensorCore.mGetEntity(id)\n                if link and link.contentid == 2001151 then count=count+1 end\n            end\n        end\n        local percent=boss.hp.percent\n        if (count==0 and percent<=78 and percent>0) or (count==1 and percent<=48 and percent>0) or (count==2 and percent<=3 and percent>0) then\n            s.put(\"neuroDrop\", \"NEUROLIEN \"..(count+1)..\" — PLACE LE BOSS\", \"Garde Gémellia sur le point de dépôt LPDU prévu\", nil, 55, 350)\n        else s.drop(\"neuroDrop\") end\n    else s.drop(\"neuroDrop\") end\nelse s.drop(\"neuroDrop\") end\nlocal thunder = TensorCore.getBuff(p, 466)\nif thunder and thunder.duration > 0 then\n    s.put(\"thunder\", \"FOUDRE SUR TOI — ÉCARTE-TOI\", string.format(\"Explosion dans %.1f s · reste hors du groupe\", thunder.duration), nil, 105, 350)\nelse s.drop(\"thunder\") end\nlocal doom = TensorCore.getBuff(p, 210)\nlocal d = data.ucob_doom_hud\nif doom and doom.duration > 0 then\n    local title = d and d.order and (\"GLAS \" .. d.order .. \" — PURIFIE-TOI\") or \"GLAS — PURIFIE-TOI\"\n    local detail = d and d.position and \"Rejoins la flaque indiquée\" or \"Attends ta flaque de purification\"\n    s.put(\"doom\", title, string.format(\"%.1f s · \", doom.duration) .. detail, nil, doom.duration <= 3 and 104 or 92, 350)\nelse s.drop(\"doom\") end\nlocal q = data.ucob_nael_calls\nif q and q.current and q.hudUntil and now < q.hudUntil then\n    if not s.words then\n        s.words = {IN=\"IN — SOUS NAEL\", OUT=\"OUT — ÉLOIGNE-TOI\", STACK=\"STACK — REGROUPEMENT\", SPREAD=\"SPREAD — ÉCARTEZ-VOUS\", TANK=\"TANK À L'ÉCART\"}\n    end\n    local detail = q.current == \"TANK\" and (s.tank(p) and \"Isole le tank ciblé ; respecte la cible du dive\" or \"Laisse le tank ciblé seul\") or \"Change de consigne à la résolution de l'attaque\"\n    s.put(\"quote\", s.words[q.current] or q.current, detail, q.next and (\"Ensuite : \" .. (s.words[q.next] or q.next)) or nil, 82, math.min(350,q.hudUntil-now))\nelse s.drop(\"quote\") end\nlocal dive = data.ucob_p2_dive\nif dive and dive.hudVisible and dive.hudTitle and dive.hudStatus then\n    s.put(\"p2Dive\", dive.hudTitle, dive.hudStatus, dive.hudNote, 95, 350)\nelse s.drop(\"p2Dive\") end\nlocal fire = data.ucob_guide_fire\nif fire and fire.expires and now < fire.expires and fire.title then\n    s.put(\"p2Fire\", fire.title, fire.detail, nil, fire.priority or 75, math.min(350,fire.expires-now))\nelse s.drop(\"p2Fire\") end\nlocal route = data.ucob_path_preview\ns.routeDetail = route and route.active and route.pulse and now-route.pulse < 500 and route.status or nil\nlocal fix = data.ucobP3DrawFix\nif fix and fix.flareUUID and fix.flareExpires and now < fix.flareExpires then\n    s.put(\"cleave\", s.tank(p) and \"SOUFFLE — GARDE LE BOSS ORIENTÉ\" or \"CLEAVE — ÉVITE DEVANT BAHAMUT\", \"Le repère rouge indique la direction du souffle\", nil, 48, 350)\nelse s.drop(\"cleave\") end\nif s.octetCheckAt and now >= s.octetCheckAt then\n    s.octetCheckAt = nil\n    if s.octetCount == 7 and not s.octet[p.id] then\n        local party = TensorCore.getEntityGroupList(\"Party\")\n        local count, marked, valid = 0, 0, true\n        if party then\n            for _, member in pairs(party) do\n                count = count + 1\n                if not member.alive then valid = false end\n                if s.octet[member.id] then marked = marked + 1 end\n            end\n        end\n        if valid and count == 8 and marked == 7 then\n            s.put(\"octetLast\", \"SANS MARQUEUR — PRÉPARE GÉMELLIA\", \"Prépare le dernier bait selon le placement de votre groupe\", \"TWISTER après le passage\", 89, 11500, \"Tu prends Gémellia\")\n        end\n    end\nend\nlocal best = s.select(now)\nif best and best.voice and not best.spoken and data.ucob_guide_settings.voice then\n    if not s.lastVoice or now-s.lastVoice >= 900 then\n        TensorCore.sendTTS(best.voice, 85)\n        best.spoken, s.lastVoice = true, now\n        if best == s.cues.fireball and data.ucob_fireball_guide then\n            data.ucob_fireball_guide.voiceDone = true\n        end\n    end\nend\nself.used = true\n",
				executeType = 2,
				loop = true,
				mechanicTime = 7,
				name = "Guide - Priorites et suivi personnel",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 836.3,
				timerStartOffset = -7,
				uuid = "a3305405-19eb-98ed-b1ed-5a251ef4eefa",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide central",
				eventType = 13,
				execute = "\nif not data.ucob_guide then\n    local g = { cues = {}, seen = {}, phase = 1, serial = 0, slotLayout = \"LR\", slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}, stacks = {}, shakers = {}, octet = {}, hatch = {} }\n    data.ucob_guide = g\n    data.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\n    function g.put(key, title, detail, nextText, priority, ttl, voice)\n        local now = Now()\n        local c = g.cues[key]\n        if not c then c = {}; g.cues[key] = c end\n        if c.title ~= title or not c.expires or c.expires <= now then\n            g.serial = g.serial + 1\n            c.serial = g.serial\n            c.born = now\n            c.spoken = false\n        end\n        c.title = title\n        c.detail = detail\n        c.nextText = nextText\n        c.priority = priority or 50\n        c.expires = now + ttl\n        c.voice = voice\n        return c\n    end\n    function g.drop(key)\n        local c = g.cues[key]\n        if c then c.expires = 0 end\n    end\n    function g.clear()\n        for _, c in pairs(g.cues) do c.expires = 0 end\n        for k in pairs(g.stacks) do g.stacks[k] = nil end\n        for k in pairs(g.shakers) do g.shakers[k] = nil end\n        for k in pairs(g.octet) do g.octet[k] = nil end\n        for k in pairs(g.hatch) do g.hatch[k] = nil end\n        g.stackCount, g.shakerCount = 0, 0\n        g.octetCount, g.shakerWave = 0, 0\n        g.shakerFirstMine = nil\n        g.mineStack, g.markerExpires, g.hatchExpires, g.octetMine = nil, nil, nil, nil\n    end\n    function g.tank(p)\n        return p.job == 19 or p.job == 21 or p.job == 32 or p.job == 37\n    end\n    function g.healer(p)\n        return p.job == 24 or p.job == 28 or p.job == 33 or p.job == 40\n    end\n    function g.select(now)\n        local best\n        for _, c in pairs(g.cues) do\n            if c.expires > now and (not best or c.priority > best.priority or\n                (c.priority == best.priority and c.serial > best.serial)) then best = c end\n        end\n        g.best = best\n        return best\n    end\n    function g.once(key, hold)\n        local now = Now()\n        if g.seen[key] and now - g.seen[key] < hold then return false end\n        g.seen[key] = now\n        return true\n    end\nend\nlocal s = data.ucob_guide\nif s.slotLayout ~= \"LR\" then\n    s.slots = {\"Non attribué\", \"L1\", \"L2\", \"L3\", \"L4\", \"R1\", \"R2\", \"R3\", \"R4\"}\n    s.slotLayout = \"LR\"\nend\ndata.ucob_guide_settings = data.ucob_guide_settings or {slot = 0, voice = true}\nif data.ucob_guide_settings.slotLayout ~= \"LR\" then\n    data.ucob_guide_settings.slot = 0\n    data.ucob_guide_settings.slotLayout = \"LR\"\nend\n\nlocal p = TensorCore.mGetPlayer()\nif not p or p.localmapid ~= 733 then self.used = true return end\nlocal cfg, now = data.ucob_guide_settings, Now()\n-- Personal default confirmed by Plume; the pre-pull buttons remain editable.\nif not cfg.plumeL4Confirmed then\n    cfg.slot, cfg.slotLayout, cfg.plumeL4Confirmed = 4, \"LR\", true\n    local towers = data.ucob_tower_visual\n    if towers and towers.trio == 9957 then\n        towers.selected, towers.assigned, towers.nextCheck = nil, false, 0\n    end\nend\nif type(cfg.slot) ~= \"number\" or cfg.slot < 0 or cfg.slot > 8 or cfg.slot ~= math.floor(cfg.slot) then cfg.slot = 0 end\nlocal prep = not p.incombat\nlocal best = s.select(now)\nif not prep and (not best or best.priority < 90 or not p.alive) then self.used = true return end\ns.flags = GUI.WindowFlags_NoResize + GUI.WindowFlags_NoCollapse + GUI.WindowFlags_AlwaysAutoResize + GUI.WindowFlags_NoFocusOnAppearing\nlocal flags = s.flags\nlocal width,height = GUI:GetScreenSize()\nGUI:SetNextWindowPos(width*0.5, height*0.23, GUI.SetCond_FirstUseEver, 0.5, 0)\nGUI:PushStyleColor(GUI.Col_WindowBg, 0.025, 0.035, 0.05, 0.90)\nlocal visible = GUI:Begin(\"Guide LPDU##ucob_p123_guide\", true, flags)\nif visible then\n    GUI:SetWindowFontScale(1.25)\n    if prep then\n        GUI:TextColored(0.35,0.94,1,1,\"UCoB — GUIDE P1 / P2 / P3\")\n        GUI:TextUnformatted(\"Poste LPDU : gauche / droite\")\n        for i=1,8 do\n            if GUI:Button(s.slots[i+1], 58, 0) then cfg.slot=i end\n            if i % 4 ~= 0 then GUI:SameLine() end\n        end\n        if GUI:Button(\"Non attribué\",126,0) then cfg.slot=0 end\n        cfg.voice = GUI:Checkbox(\"Voix essentielles\",cfg.voice)\n        GUI:TextUnformatted(\"Glisse la barre de titre pour déplacer la fenêtre\")\n        GUI:TextUnformatted(\"Poste conservé entre les pulls\")\n        if cfg.slot > 0 then GUI:TextUnformatted(\"Poste : \" .. (s.slots[cfg.slot+1] or \"Non attribué\") .. \" · secteurs selon votre macro\") end\n        if cfg.slot == 0 then GUI:TextColored(1,0.78,0.3,1,\"Consignes selon ton job et tes marqueurs ; secteurs selon votre macro.\") end\n    else\n        GUI:SetWindowFontScale(1.7)\n        GUI:TextColored(1,0.8,0.4,1,best.title)\n\n    end\nend\nGUI:End()\nGUI:PopStyleColor()\nself.used = true\n",
				executeType = 2,
				loop = true,
				mechanicTime = 7,
				name = "Guide - Panneau unique et poste",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 836.3,
				timerStartOffset = -7,
				uuid = "173efe9d-b721-de48-b531-7202b6a36a61",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide central",
				eventType = 9,
				execute = "local old=eventArgs.oldData\nif old and old.ucob_guide_settings then data.ucob_guide_settings=old.ucob_guide_settings end\nself.used=true",
				executeType = 2,
				loop = true,
				mechanicTime = 7,
				name = "Guide - Nettoyage et conservation du poste",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 9999,
				timerStartOffset = -7,
				uuid = "0ceb002d-b793-8b9d-aaf2-6c7d053df4b6",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "239e45e7-b18f-3634-8041-e81d51056f18",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[plummetPrep]==],[==[PLUMMET — CLEAVE DEVANT]==],[==[Tank : garde le boss orienté ; groupe : évite sa face avant]==],nil,43,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 7,
				name = "P1 - PLUMMET — CLEAVE DEVANT (7s)",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "663e50ef-b57d-e7df-9f31-9f9e7865f4e2",
				version = 2,
			},
		},
	},
	[3] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "ff22f157-35e2-0653-8e73-f6ed29e2a5c7",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[4] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "5e638d72-1395-85d6-053e-80d4abb4b662",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Boule de feu - Cible du partage",
				uuid = "e2805749-fd92-3a71-9fcc-aa41e3b5101b",
				version = 2,
			},
			inheritedObjectUUID = "5f9b9dd7-a5de-db69-b0c1-6e26c3091110",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "0c64c6b5-ac89-1f5e-b6f9-3d186af884ee",
								version = 2.1,
							},
							inheritedObjectUUID = "19c55477-aea7-4d73-960a-96b4ae5ce96b",
						},
					},
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "e8719030-08e3-84a1-9c87-7de587fc469b",
								version = 2.1,
							},
							inheritedObjectUUID = "b90e8aae-63f5-0c28-a2e6-64ee74c90f1f",
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suivre cible du partage",
								uuid = "3a2da7e9-4cf7-31a3-b26b-3d0af1f65de0",
								version = 2.1,
							},
							inheritedObjectUUID = "d41cd5ef-088c-0959-8818-d5757e5367bf",
							inheritedOverwrites = 
							{
								actionLua = "data.ucob_twin_fire_4 = data.ucob_twin_fire_4 or {}\nlocal s = data.ucob_twin_fire_4\nif s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\nif s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\ns.target = eventArgs.entityID\ns.arrived = nil\ns.holdUntil = Now() + 500\ns.expires = Now() + 15000\nself.used = true",
							},
						},
					},
				},
				conditions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "Cible : moi",
								uuid = "16a63293-37a9-ac7e-a241-3643aab47f98",
								version = 3,
							},
							inheritedObjectUUID = "44a0e962-e11f-4295-9a2c-3901937c6914",
						},
					},
				},
				name = "Boule de feu - Cible du partage",
			},
		},
		
		{
			data = 
			{
				name = "Boule de feu - Fin du partage",
				uuid = "8ebca44b-8651-1805-a114-78bed03105ec",
				version = 2,
			},
			inheritedObjectUUID = "eab5e74b-2dea-3e94-a99e-6b2d48518385",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Nettoyer dessins de partage",
								uuid = "073cf1a8-d546-2899-838e-fb2ec6a1a47c",
								version = 2.1,
							},
							inheritedObjectUUID = "d3280c8e-5fa9-03cc-afbe-805515608659",
							inheritedOverwrites = 
							{
								actionLua = "for _, key in ipairs({\"ucob_twin_fire_4\", \"ucob_twin_fire_8\", \"ucob_twin_fire_24\", \"ucob_twin_fire_33\", \"ucob_twin_fire_135\"}) do\n    local s = data[key]\n    if s then\n        if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n        if s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\n        s.target = nil\n    end\nend\ndata.ucob_fireball_guide = nil\nlocal guide = data.ucob_guide\nif guide then guide.drop(\"fireball\") end\nself.used = true",
							},
						},
					},
				},
			},
		},
		
		{
			data = 
			{
				name = "Boule de feu - Distance",
				uuid = "68c14c8a-ba9b-ed65-aec1-0c0046ee2a54",
				version = 2,
			},
			inheritedObjectUUID = "93a83a25-d642-1588-af3e-a784ea0a05fb",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Cercle et fleche de partage",
								uuid = "45cc5fab-8dbf-cc3c-a913-487e74c3dd42",
								version = 2.1,
							},
							inheritedObjectUUID = "cce2045d-1ce0-3b1d-afce-15a2142088aa",
							inheritedOverwrites = 
							{
								actionLua = "local s = data.ucob_twin_fire_4\nif not s or not s.target then self.used = true; return end\nlocal remaining = math.floor(math.min(s.expires - Now(), (21.3 - TensorReactions_CurrentTimer) * 1000))\nlocal p = TensorCore.mGetPlayer()\nlocal target = TensorCore.mGetEntity(s.target)\nif not p or not p.alive or p.hp.current <= 0 or not target or not target.alive or target.hp.current <= 0 or remaining <= 0 then\n    if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n    if s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\n    s.target = nil\n    self.used = true\n    return\nend\nlocal dx, dz = p.pos.x - target.pos.x, p.pos.z - target.pos.z\nlocal distanceSquared = dx * dx + dz * dz\n-- Two thresholds inside the 4y stack radius prevent boundary flicker.\nif distanceSquared <= 12.25 then\n    s.arrived = true\nelseif distanceSquared >= 14.44 then\n    s.arrived = false\nend\nlocal outside = not s.arrived\nlocal now = Now()\nlocal f = data.ucob_fireball_guide\nlocal holdUntil = f and f.target == s.target and f.holdUntil or s.holdUntil or 0\nlocal waiting = now < holdUntil or (data.ucob_twister_until and now < data.ucob_twister_until)\nlocal fill = waiting and 0x10AAAAAA or 0x30FFF060\nlocal outline = waiting and 0xFFAAAAAA or 0xFFFFF060\nlocal ring = TensorCore.getCachedDrawer(fill, nil, fill, outline, waiting and 2 or 4)\nif s.circle and not ring:updateTimedCircleOnEnt(s.circle, nil, s.target, 4, 0, false, true) then s.circle = nil end\nif not s.circle then s.circle = ring:addTimedCircleOnEnt(remaining, s.target, 4, 0, false, true) end\nif outside and not waiting then\n    local drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\n    drawer:setGradient(0.25, 0.4, 1.5)\n    -- Explicit distance and absolute heading place the tip at the destination.\n    local distance = math.sqrt(distanceSquared)\n    local tipLength = math.min(1.1, distance * 0.4)\n    local baseLength = distance - tipLength\n    local heading = TensorCore.getHeadingToTarget(p.pos, target.pos)\n    -- Replace an old target-attached arrow once, then keep updating the same shape.\n    if not s.fullLengthArrow then\n        if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n        s.fullLengthArrow = true\n    end\n    if s.uuid and not drawer:updateTimedArrowOnEnt(s.uuid, nil, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) then s.uuid = nil end\n    if not s.uuid then s.uuid = drawer:addTimedArrowOnEnt(remaining, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) end\nelseif s.uuid then\n    Argus.deleteTimedShape(s.uuid); s.uuid = nil\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
	},
	[5] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "b923376c-8766-d44e-b787-d96ac41f48e9",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.phase=1\ns.put([==[tankPrep]==],[==[DEATH SENTENCE — TANKBUSTER]==],[==[Tanks : mitigation et échange selon votre plan]==],nil,65,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 24.5,
				name = "P1 - DEATH SENTENCE — TANKBUSTER (24.5s)",
				timeRange = true,
				timelineIndex = 5,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "3af17d12-948b-146a-866b-6efc75058da8",
				version = 2,
			},
		},
	},
	[6] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "8b229a38-43bf-6c1e-9c7c-7ea6bcdc4d64",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[plummetPrep]==],[==[PLUMMET — CLEAVE DEVANT]==],[==[Tank : garde le boss orienté ; groupe : évite sa face avant]==],nil,43,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 27.6,
				name = "P1 - PLUMMET — CLEAVE DEVANT (27.6s)",
				timeRange = true,
				timelineIndex = 6,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "f2aa464c-436c-b4dd-a9cc-66b801e2beda",
				version = 2,
			},
		},
	},
	[7] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "9edd0deb-ec55-0d3f-49b1-850913eb9d9b",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[8] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "1cce3866-880d-b062-180d-b6b0373c8bd6",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Boule de feu - Cible du partage",
				uuid = "5ce1052f-157f-ba3c-bedd-3aa9b991afd3",
				version = 2,
			},
			inheritedObjectUUID = "fc9ce2b9-99e8-7a89-b713-aa0323a21f53",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "df423c24-3189-3e5d-aa5d-0b8f3ba6f401",
								version = 2.1,
							},
							inheritedObjectUUID = "15805dab-44c9-d081-acdb-064c9e516bc0",
						},
					},
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "642847ca-d795-0f01-9e84-8464c2e779b7",
								version = 2.1,
							},
							inheritedObjectUUID = "4276dcb2-4b67-29d7-ac0b-19cc873bbbd1",
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suivre cible du partage",
								uuid = "1e532ca4-8be8-16a4-921a-c521bdc9e5d4",
								version = 2.1,
							},
							inheritedObjectUUID = "a9606165-f8ab-38af-8515-c3edd063eb12",
							inheritedOverwrites = 
							{
								actionLua = "data.ucob_twin_fire_8 = data.ucob_twin_fire_8 or {}\nlocal s = data.ucob_twin_fire_8\nif s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\nif s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\ns.target = eventArgs.entityID\ns.arrived = nil\ns.holdUntil = Now() + 500\ns.expires = Now() + 15000\nself.used = true",
							},
						},
					},
				},
				conditions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "Cible : moi",
								uuid = "2c594680-76e3-52d2-bc5d-c68e8fa0ad4c",
								version = 3,
							},
							inheritedObjectUUID = "c11d10bd-09ba-ff10-9251-d75551e4a937",
						},
					},
				},
				name = "Boule de feu - Cible du partage",
			},
		},
		
		{
			data = 
			{
				name = "Boule de feu - Distance",
				uuid = "43bf6bf3-e160-c93b-8442-806b2a7c3b30",
				version = 2,
			},
			inheritedObjectUUID = "cd611016-3cfc-64ee-aa6c-b188a20f725c",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Cercle et fleche de partage",
								uuid = "e7fc8d65-3282-27fe-82e7-7f6a3210fa51",
								version = 2.1,
							},
							inheritedObjectUUID = "9b24159e-ba1a-184d-8e17-e9120e7437c6",
							inheritedOverwrites = 
							{
								actionLua = "local s = data.ucob_twin_fire_8\nif not s or not s.target then self.used = true; return end\nlocal remaining = math.floor(math.min(s.expires - Now(), (41 - TensorReactions_CurrentTimer) * 1000))\nlocal p = TensorCore.mGetPlayer()\nlocal target = TensorCore.mGetEntity(s.target)\nif not p or not p.alive or p.hp.current <= 0 or not target or not target.alive or target.hp.current <= 0 or remaining <= 0 then\n    if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n    if s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\n    s.target = nil\n    self.used = true\n    return\nend\nlocal dx, dz = p.pos.x - target.pos.x, p.pos.z - target.pos.z\nlocal distanceSquared = dx * dx + dz * dz\n-- Two thresholds inside the 4y stack radius prevent boundary flicker.\nif distanceSquared <= 12.25 then\n    s.arrived = true\nelseif distanceSquared >= 14.44 then\n    s.arrived = false\nend\nlocal outside = not s.arrived\nlocal now = Now()\nlocal f = data.ucob_fireball_guide\nlocal holdUntil = f and f.target == s.target and f.holdUntil or s.holdUntil or 0\nlocal waiting = now < holdUntil or (data.ucob_twister_until and now < data.ucob_twister_until)\nlocal fill = waiting and 0x10AAAAAA or 0x30FFF060\nlocal outline = waiting and 0xFFAAAAAA or 0xFFFFF060\nlocal ring = TensorCore.getCachedDrawer(fill, nil, fill, outline, waiting and 2 or 4)\nif s.circle and not ring:updateTimedCircleOnEnt(s.circle, nil, s.target, 4, 0, false, true) then s.circle = nil end\nif not s.circle then s.circle = ring:addTimedCircleOnEnt(remaining, s.target, 4, 0, false, true) end\nif outside and not waiting then\n    local drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\n    drawer:setGradient(0.25, 0.4, 1.5)\n    -- Explicit distance and absolute heading place the tip at the destination.\n    local distance = math.sqrt(distanceSquared)\n    local tipLength = math.min(1.1, distance * 0.4)\n    local baseLength = distance - tipLength\n    local heading = TensorCore.getHeadingToTarget(p.pos, target.pos)\n    -- Replace an old target-attached arrow once, then keep updating the same shape.\n    if not s.fullLengthArrow then\n        if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n        s.fullLengthArrow = true\n    end\n    if s.uuid and not drawer:updateTimedArrowOnEnt(s.uuid, nil, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) then s.uuid = nil end\n    if not s.uuid then s.uuid = drawer:addTimedArrowOnEnt(remaining, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) end\nelseif s.uuid then\n    Argus.deleteTimedShape(s.uuid); s.uuid = nil\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
	},
	[10] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "8ff74a35-711b-2a59-0dd0-0e4ba09f9965",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "09769adb-f12c-b14d-836d-b1087caac4c6",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[liquidPrep]==],[==[LIQUID HELL — PRÉPARE LE BAIT]==],[==[Le baiter désigné s'écarte ; garde les cinq flaques hors du groupe]==],nil,43,3500)\nself.used=true",
				executeType = 2,
				mechanicTime = 47.5,
				name = "P1 - LIQUID HELL — PRÉPARE LE BAIT (47.5s)",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 1,
				timerStartOffset = -2.5,
				uuid = "a2966e07-18cc-9405-b0e8-3f5f879f9ab1",
				version = 2,
			},
		},
	},
	[12] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "21653edb-e4de-e24f-7271-e4653bfdc34b",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[13] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "85559530-53f6-8ba4-4a89-93528092c820",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "13ea6e0a-eb93-ff42-a759-d71da8270ef7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[liquidPrep]==],[==[LIQUID HELL — PRÉPARE LE BAIT]==],[==[Le baiter désigné s'écarte ; garde les cinq flaques hors du groupe]==],nil,43,3500)\nself.used=true",
				executeType = 2,
				mechanicTime = 59.1,
				name = "P1 - LIQUID HELL — PRÉPARE LE BAIT (59.1s)",
				timeRange = true,
				timelineIndex = 13,
				timerEndOffset = 1,
				timerStartOffset = -2.5,
				uuid = "5c7eb001-bf46-bd76-a1b5-893368323be5",
				version = 2,
			},
		},
	},
	[14] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "2a3c3145-80a1-ab9b-b0ba-f1bf32603145",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.phase=1\ns.put([==[tankPrep]==],[==[DEATH SENTENCE — TANKBUSTER]==],[==[Tanks : mitigation et échange selon votre plan]==],nil,65,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 70.6,
				name = "P1 - DEATH SENTENCE — TANKBUSTER (70.6s)",
				timeRange = true,
				timelineIndex = 14,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "24ab4036-6be2-fe55-8d87-9efdb157143a",
				version = 2,
			},
		},
	},
	[17] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "f992062a-c2cd-8065-9bcb-36abe1bca4c2",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[plummetPrep]==],[==[PLUMMET — CLEAVE DEVANT]==],[==[Tank : garde le boss orienté ; groupe : évite sa face avant]==],nil,43,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 86.6,
				name = "P1 - PLUMMET — CLEAVE DEVANT (86.6s)",
				timeRange = true,
				timelineIndex = 17,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "bda8febe-fd7c-7b3a-8d80-b2a8f3b664e5",
				version = 2,
			},
		},
	},
	[18] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "fbbbd56d-efc4-6f61-4731-6f036389f55d",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "f03c4dc8-718b-d44e-af0d-5b2cc40e369a",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[liquidPrep]==],[==[LIQUID HELL — PRÉPARE LE BAIT]==],[==[Le baiter désigné s'écarte ; garde les cinq flaques hors du groupe]==],nil,43,3500)\nself.used=true",
				executeType = 2,
				mechanicTime = 91.7,
				name = "P1 - LIQUID HELL — PRÉPARE LE BAIT (91.7s)",
				timeRange = true,
				timelineIndex = 18,
				timerEndOffset = 1,
				timerStartOffset = -2.5,
				uuid = "90543784-9903-5cbd-bbfd-530ecc29f43a",
				version = 2,
			},
		},
	},
	[20] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "c76491ae-b900-a5e2-281b-7a680ec2091e",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "ece251f7-aff8-4fa7-989e-4f3ed177db41",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[liquidPrep]==],[==[LIQUID HELL — PRÉPARE LE BAIT]==],[==[Le baiter désigné s'écarte ; garde les cinq flaques hors du groupe]==],nil,43,3500)\nself.used=true",
				executeType = 2,
				mechanicTime = 106.4,
				name = "P1 - LIQUID HELL — PRÉPARE LE BAIT (106.4s)",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 1,
				timerStartOffset = -2.5,
				uuid = "26092544-8475-9e9c-aa37-fe16cb32ae59",
				version = 2,
			},
		},
	},
	[23] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "0757e637-2137-8d1b-3a95-c80dda1654e7",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[24] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "f0c7f1d2-7194-517e-d807-6ef4495a8382",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Boule de feu - Cible du partage",
				uuid = "f34bb59f-874c-7b16-9025-caf148b4ac31",
				version = 2,
			},
			inheritedObjectUUID = "39d1cc4b-9e74-8641-b9c6-e2a917f3aab1",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "5f68d229-36f4-8986-91c2-5dc20663d535",
								version = 2.1,
							},
							inheritedObjectUUID = "5a49dc5f-2651-8c3f-88cf-b03498e60a0a",
						},
					},
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "62286a6d-e689-cc52-99d4-d6957c10c1d5",
								version = 2.1,
							},
							inheritedObjectUUID = "8027e2fa-ee59-1dcb-8a8f-f8a95cf04e06",
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suivre cible du partage",
								uuid = "a20c865a-4ee8-cbb4-a8f3-f3049918e16b",
								version = 2.1,
							},
							inheritedObjectUUID = "7db6dfed-046a-59da-a387-500ea115dd22",
							inheritedOverwrites = 
							{
								actionLua = "data.ucob_twin_fire_24 = data.ucob_twin_fire_24 or {}\nlocal s = data.ucob_twin_fire_24\nif s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\nif s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\ns.target = eventArgs.entityID\ns.arrived = nil\ns.holdUntil = Now() + 500\ns.expires = Now() + 15000\nself.used = true",
							},
						},
					},
				},
				conditions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "Cible : moi",
								uuid = "7250ea36-195c-69e1-804c-19e4567208df",
								version = 3,
							},
							inheritedObjectUUID = "d70e98ac-ec96-e500-bc89-3df82b711d80",
						},
					},
				},
				name = "Boule de feu - Cible du partage",
			},
		},
		
		{
			data = 
			{
				name = "Boule de feu - Distance",
				uuid = "79d4469a-14da-0eff-9eeb-3751cbde4794",
				version = 2,
			},
			inheritedObjectUUID = "bf5c230a-11de-4066-8ae5-09824e26d1c0",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Cercle et fleche de partage",
								uuid = "a1409540-3f16-b5d8-961e-4a1faabe4f20",
								version = 2.1,
							},
							inheritedObjectUUID = "cf4278cf-06a4-257a-9f40-f57518f0d722",
							inheritedOverwrites = 
							{
								actionLua = "local s = data.ucob_twin_fire_24\nif not s or not s.target then self.used = true; return end\nlocal remaining = math.floor(math.min(s.expires - Now(), (129.6 - TensorReactions_CurrentTimer) * 1000))\nlocal p = TensorCore.mGetPlayer()\nlocal target = TensorCore.mGetEntity(s.target)\nif not p or not p.alive or p.hp.current <= 0 or not target or not target.alive or target.hp.current <= 0 or remaining <= 0 then\n    if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n    if s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\n    s.target = nil\n    self.used = true\n    return\nend\nlocal dx, dz = p.pos.x - target.pos.x, p.pos.z - target.pos.z\nlocal distanceSquared = dx * dx + dz * dz\n-- Two thresholds inside the 4y stack radius prevent boundary flicker.\nif distanceSquared <= 12.25 then\n    s.arrived = true\nelseif distanceSquared >= 14.44 then\n    s.arrived = false\nend\nlocal outside = not s.arrived\nlocal now = Now()\nlocal f = data.ucob_fireball_guide\nlocal holdUntil = f and f.target == s.target and f.holdUntil or s.holdUntil or 0\nlocal waiting = now < holdUntil or (data.ucob_twister_until and now < data.ucob_twister_until)\nlocal fill = waiting and 0x10AAAAAA or 0x30FFF060\nlocal outline = waiting and 0xFFAAAAAA or 0xFFFFF060\nlocal ring = TensorCore.getCachedDrawer(fill, nil, fill, outline, waiting and 2 or 4)\nif s.circle and not ring:updateTimedCircleOnEnt(s.circle, nil, s.target, 4, 0, false, true) then s.circle = nil end\nif not s.circle then s.circle = ring:addTimedCircleOnEnt(remaining, s.target, 4, 0, false, true) end\nif outside and not waiting then\n    local drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\n    drawer:setGradient(0.25, 0.4, 1.5)\n    -- Explicit distance and absolute heading place the tip at the destination.\n    local distance = math.sqrt(distanceSquared)\n    local tipLength = math.min(1.1, distance * 0.4)\n    local baseLength = distance - tipLength\n    local heading = TensorCore.getHeadingToTarget(p.pos, target.pos)\n    -- Replace an old target-attached arrow once, then keep updating the same shape.\n    if not s.fullLengthArrow then\n        if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n        s.fullLengthArrow = true\n    end\n    if s.uuid and not drawer:updateTimedArrowOnEnt(s.uuid, nil, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) then s.uuid = nil end\n    if not s.uuid then s.uuid = drawer:addTimedArrowOnEnt(remaining, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) end\nelseif s.uuid then\n    Argus.deleteTimedShape(s.uuid); s.uuid = nil\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
	},
	[25] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "0b4bb8f1-695a-9195-a211-b57e746fd244",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.phase=1\ns.put([==[tankPrep]==],[==[DEATH SENTENCE — TANKBUSTER]==],[==[Tanks : mitigation et échange selon votre plan]==],nil,65,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 133.6,
				name = "P1 - DEATH SENTENCE — TANKBUSTER (133.6s)",
				timeRange = true,
				timelineIndex = 25,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "e5c37f6a-2ef7-0a75-9f1d-cbf4011e680e",
				version = 2,
			},
		},
	},
	[26] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "eeb42909-0c97-8243-8d5b-1f83e9b5ce9b",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[plummetPrep]==],[==[PLUMMET — CLEAVE DEVANT]==],[==[Tank : garde le boss orienté ; groupe : évite sa face avant]==],nil,43,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 136.6,
				name = "P1 - PLUMMET — CLEAVE DEVANT (136.6s)",
				timeRange = true,
				timelineIndex = 26,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "929836df-4743-b17f-8c2d-0aba563511b6",
				version = 2,
			},
		},
	},
	[29] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "5602a45e-2719-27f9-808a-2de751564b82",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[plummetPrep]==],[==[PLUMMET — CLEAVE DEVANT]==],[==[Tank : garde le boss orienté ; groupe : évite sa face avant]==],nil,43,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 151.6,
				name = "P1 - PLUMMET — CLEAVE DEVANT (151.6s)",
				timeRange = true,
				timelineIndex = 29,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "64c302e3-1d1f-6d57-95a3-5646502b2e14",
				version = 2,
			},
		},
	},
	[30] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "5226fe67-8bc5-3c0b-2a8e-05990a501d97",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "18ecfb5b-8bd4-3f57-83c4-6ac5f6562c59",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[liquidPrep]==],[==[LIQUID HELL — PRÉPARE LE BAIT]==],[==[Le baiter désigné s'écarte ; garde les cinq flaques hors du groupe]==],nil,43,3500)\nself.used=true",
				executeType = 2,
				mechanicTime = 153.8,
				name = "P1 - LIQUID HELL — PRÉPARE LE BAIT (153.8s)",
				timeRange = true,
				timelineIndex = 30,
				timerEndOffset = 1,
				timerStartOffset = -2.5,
				uuid = "82d6bfe4-9476-966f-ab51-e23222e19c72",
				version = 2,
			},
		},
	},
	[33] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "86d2b29e-b5ae-3412-1a2b-30e4bedc328e",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Boule de feu - Cible du partage",
				uuid = "93fb6a46-2b15-631d-b412-7e686cca418f",
				version = 2,
			},
			inheritedObjectUUID = "990111df-84e8-3c82-9fd1-06efea0337c4",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "95173de0-ac83-3bb4-8867-2dbf6f2cbea0",
								version = 2.1,
							},
							inheritedObjectUUID = "d243a6b7-7413-cb18-ab72-b0553c1155c2",
						},
					},
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "34a9d410-ddc0-268e-8a0c-63baa020084f",
								version = 2.1,
							},
							inheritedObjectUUID = "7243695c-4981-b6bb-b3df-7e144a55a014",
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suivre cible du partage",
								uuid = "ca154dc5-5810-45cc-a6ef-92f2c0b8faff",
								version = 2.1,
							},
							inheritedObjectUUID = "3c4e8811-8dde-7e14-b3d2-5220d23862d3",
							inheritedOverwrites = 
							{
								actionLua = "data.ucob_twin_fire_33 = data.ucob_twin_fire_33 or {}\nlocal s = data.ucob_twin_fire_33\nif s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\nif s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\ns.target = eventArgs.entityID\ns.arrived = nil\ns.holdUntil = Now() + 500\ns.expires = Now() + 15000\nself.used = true",
							},
						},
					},
				},
				conditions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "Cible : moi",
								uuid = "0bc8321b-7140-729a-a93f-3352baca1627",
								version = 3,
							},
							inheritedObjectUUID = "5082842b-7552-bc0a-9124-2ae036264558",
						},
					},
				},
				name = "Boule de feu - Cible du partage",
			},
		},
		
		{
			data = 
			{
				name = "Boule de feu - Distance",
				uuid = "081c17ce-080d-d351-a619-1ca6d572ee6e",
				version = 2,
			},
			inheritedObjectUUID = "02ec2fb2-5c39-6210-9952-8adc0891ed63",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Cercle et fleche de partage",
								uuid = "f203a481-8510-35f8-9563-a95f7d0ff5b7",
								version = 2.1,
							},
							inheritedObjectUUID = "aef91689-4858-2533-827e-a294a1ae9643",
							inheritedOverwrites = 
							{
								actionLua = "local s = data.ucob_twin_fire_33\nif not s or not s.target then self.used = true; return end\nlocal remaining = math.floor(math.min(s.expires - Now(), (177 - TensorReactions_CurrentTimer) * 1000))\nlocal p = TensorCore.mGetPlayer()\nlocal target = TensorCore.mGetEntity(s.target)\nif not p or not p.alive or p.hp.current <= 0 or not target or not target.alive or target.hp.current <= 0 or remaining <= 0 then\n    if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n    if s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\n    s.target = nil\n    self.used = true\n    return\nend\nlocal dx, dz = p.pos.x - target.pos.x, p.pos.z - target.pos.z\nlocal distanceSquared = dx * dx + dz * dz\n-- Two thresholds inside the 4y stack radius prevent boundary flicker.\nif distanceSquared <= 12.25 then\n    s.arrived = true\nelseif distanceSquared >= 14.44 then\n    s.arrived = false\nend\nlocal outside = not s.arrived\nlocal now = Now()\nlocal f = data.ucob_fireball_guide\nlocal holdUntil = f and f.target == s.target and f.holdUntil or s.holdUntil or 0\nlocal waiting = now < holdUntil or (data.ucob_twister_until and now < data.ucob_twister_until)\nlocal fill = waiting and 0x10AAAAAA or 0x30FFF060\nlocal outline = waiting and 0xFFAAAAAA or 0xFFFFF060\nlocal ring = TensorCore.getCachedDrawer(fill, nil, fill, outline, waiting and 2 or 4)\nif s.circle and not ring:updateTimedCircleOnEnt(s.circle, nil, s.target, 4, 0, false, true) then s.circle = nil end\nif not s.circle then s.circle = ring:addTimedCircleOnEnt(remaining, s.target, 4, 0, false, true) end\nif outside and not waiting then\n    local drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\n    drawer:setGradient(0.25, 0.4, 1.5)\n    -- Explicit distance and absolute heading place the tip at the destination.\n    local distance = math.sqrt(distanceSquared)\n    local tipLength = math.min(1.1, distance * 0.4)\n    local baseLength = distance - tipLength\n    local heading = TensorCore.getHeadingToTarget(p.pos, target.pos)\n    -- Replace an old target-attached arrow once, then keep updating the same shape.\n    if not s.fullLengthArrow then\n        if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n        s.fullLengthArrow = true\n    end\n    if s.uuid and not drawer:updateTimedArrowOnEnt(s.uuid, nil, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) then s.uuid = nil end\n    if not s.uuid then s.uuid = drawer:addTimedArrowOnEnt(remaining, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) end\nelseif s.uuid then\n    Argus.deleteTimedShape(s.uuid); s.uuid = nil\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
	},
	[34] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "5a4306f6-9c76-e575-b38e-aa1045a0432c",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.phase=1\ns.put([==[tankPrep]==],[==[DEATH SENTENCE — TANKBUSTER]==],[==[Tanks : mitigation et échange selon votre plan]==],nil,65,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 181,
				name = "P1 - DEATH SENTENCE — TANKBUSTER (181s)",
				timeRange = true,
				timelineIndex = 34,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "d02fc5f4-cb1b-3e2f-b2e6-6fe978698ef1",
				version = 2,
			},
		},
	},
	[35] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P1",
				uuid = "63ca1ccc-4666-ffd7-af5b-55868448f843",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P1",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.put([==[plummetPrep]==],[==[PLUMMET — CLEAVE DEVANT]==],[==[Tank : garde le boss orienté ; groupe : évite sa face avant]==],nil,43,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 184,
				name = "P1 - PLUMMET — CLEAVE DEVANT (184s)",
				timeRange = true,
				timelineIndex = 35,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "5e5097ea-a801-a830-8582-1a41f4c06ee8",
				version = 2,
			},
		},
	},
	[38] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "0449d85f-bc30-1ac3-d841-5fa13c07d24f",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[39] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "56f0fd34-538e-2fb8-6d96-04ceab1f7ba4",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "5b84271c-5339-cc79-91cd-4e1405cddfd6",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=2\ns.put([==[recul]==],[==[PRÉPARE LE RECUL]==],[==[Place-toi pour Heavensfall ; garde ton espace]==],[==[Ensuite : dispersion]==],68,4000)\nself.used=true",
				executeType = 2,
				mechanicTime = 200,
				name = "P2 - PRÉPARE LE RECUL (200s)",
				timeRange = true,
				timelineIndex = 39,
				timerEndOffset = 1,
				timerStartOffset = -3,
				uuid = "719f415d-58bb-699e-9ff1-4c78d060f905",
				version = 2,
			},
		},
	},
	[40] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "d3def91c-a082-0e56-8996-411be02ec070",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=2\ns.put([==[spreadPrep]==],[==[SPREAD — METEOR STREAM]==],[==[Reste séparé pour les deux vagues]==],[==[Évite aussi les secteurs au sol]==],80,6000)\nself.used=true",
				executeType = 2,
				mechanicTime = 205.5,
				name = "P2 - SPREAD — METEOR STREAM (205.5s)",
				timeRange = true,
				timelineIndex = 40,
				timerEndOffset = 4,
				timerStartOffset = -2,
				uuid = "aa97119f-19f8-2eaa-b729-c9bff1c2ab20",
				version = 2,
			},
		},
	},
	[44] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "8d0a60fc-ac4f-9ad0-0bc5-502a70bf6eac",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "086fbce1-46b8-4daf-bbb3-96e075e8eaa2",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=2\ns.put([==[tankPrep]==],[==[DALAMUD DIVE — TANK ISOLÉ]==],[==[Garde le tank ciblé à l'écart du groupe]==],nil,68,3000)\nself.used=true",
				executeType = 2,
				mechanicTime = 211.5,
				name = "P2 - DALAMUD DIVE — TANK ISOLÉ (211.5s)",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 1,
				timerStartOffset = -2,
				uuid = "b8b2259b-22a3-3fd2-9d4b-3dea1c6ba38d",
				version = 2,
			},
		},
	},
	[45] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "b689bf67-7097-427b-0b6d-5d9d6eb2de97",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Potion",
				uuid = "c2d2f03b-dbfd-595d-9c4d-8de19bd05223",
				version = 2,
			},
			inheritedObjectUUID = "9bd0c684-f92e-7d86-9d9a-1635fce362b5",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "a7ddd9df-9bbc-7240-bdfe-13ba77ed317e",
								version = 2.1,
							},
							inheritedObjectUUID = "b9c3fbaa-c866-401a-9566-be2479abb5a1",
							inheritedOverwrites = 
							{
								alertText = "Burst sa mère",
							},
						},
					},
				},
			},
		},
	},
	[46] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "d5ada7b1-634a-3e16-ac16-0c788a827f6c",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.phase=2\ns.put([==[tankPrep]==],[==[BAHAMUT'S CLAW — 5 COUPS]==],[==[Tanks : mitigation et échange selon votre plan]==],nil,50,6500)\nself.used=true",
				executeType = 2,
				mechanicTime = 213.6,
				name = "P2 - BAHAMUT'S CLAW — 5 COUPS (213.6s)",
				timeRange = true,
				timelineIndex = 46,
				timerEndOffset = 5,
				timerStartOffset = -1.5,
				uuid = "c90bc9ef-16e2-7de3-a7e5-7e89d47baf08",
				version = 2,
			},
		},
	},
	[47] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "f08bb431-e38c-5255-fd2d-2a43ab502061",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[48] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "11d505a8-32a7-9e74-9c8e-696e8d444b58",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Quotes",
				uuid = "bf5ac246-5943-0b9a-9183-43f9db660216",
				version = 2,
			},
			inheritedObjectUUID = "cb9925a9-c980-2477-9e9c-57e8b62d3c99",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "16b983bb-a1ab-2906-8295-dea89b313899",
								version = 2.1,
							},
							inheritedObjectUUID = "fd1d6cda-c08f-6fc6-8a56-21ac3c69dc77",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"08419f69-fe5f-28ce-91a8-79c0109474e0",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suite IN puis OUT",
								uuid = "d65a1654-b699-9b0c-bd06-3286ff42a94a",
								version = 2.1,
							},
							inheritedObjectUUID = "dc73ebf5-58ef-16ff-a800-fbc093d1360b",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"08419f69-fe5f-28ce-91a8-79c0109474e0",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "cae62024-0c4f-5e5d-9f36-0094ed48c6a2",
								version = 2.1,
							},
							inheritedObjectUUID = "7a107969-92db-4271-be57-4a6e317c96dd",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"e62a2e13-be09-f064-ba90-3870788b23c1",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suite IN puis STACK",
								uuid = "b8a58d8e-3400-7cc7-a0f7-7cd8485b03d5",
								version = 2.1,
							},
							inheritedObjectUUID = "b5062698-bcca-aa37-b529-549612872a86",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"e62a2e13-be09-f064-ba90-3870788b23c1",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "6d9c0c8d-72a8-7175-8126-3ff26f2f93f3",
								version = 2.1,
							},
							inheritedObjectUUID = "4b90d3a4-15f4-4302-af40-d869c694b6d3",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"5cb27dce-c12c-c103-b824-0d5dfd017c02",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suite STACK puis OUT",
								uuid = "4c3ea3b1-a8b2-7984-86ce-89de1e5001d1",
								version = 2.1,
							},
							inheritedObjectUUID = "8af5dcbd-7bc5-eef7-9c11-63dd869845e1",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"5cb27dce-c12c-c103-b824-0d5dfd017c02",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "5160eadb-79be-93fd-ae4b-3e8791c3e48e",
								version = 2.1,
							},
							inheritedObjectUUID = "d2398dc3-3806-3000-b6bf-12a9ca4faf4b",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"5f60399e-9431-a290-9701-8b9e0a4c498a",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suite STACK puis IN",
								uuid = "351345ee-98a4-2df5-b568-3a12296e400f",
								version = 2.1,
							},
							inheritedObjectUUID = "aa05fec2-4d76-d66e-b21c-a2ecd4556892",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"5f60399e-9431-a290-9701-8b9e0a4c498a",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "eee59ef9-58d5-47bf-832e-04862fa6f221",
								version = 2.1,
							},
							inheritedObjectUUID = "c393894f-f93a-0d98-a0cb-4eda9746e627",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"fa8194a4-fb17-4ba2-8357-4adc58783d83",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suite SPREAD puis OUT",
								uuid = "296cfe19-2a94-9968-8b7b-905ba4688caa",
								version = 2.1,
							},
							inheritedObjectUUID = "7e87ea4d-ca6c-47da-aeb4-b415c094da91",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"fa8194a4-fb17-4ba2-8357-4adc58783d83",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "dc1b80a2-7e69-3a77-b934-d96340b5235c",
								version = 2.1,
							},
							inheritedObjectUUID = "c809462c-2e55-9dc5-b0a4-27b4bfa8aff1",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"d35d9131-600d-496b-bacc-e829f511d7b3",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suite SPREAD puis IN",
								uuid = "6bc36d5a-cde7-59f8-8b6c-1a889fbcf086",
								version = 2.1,
							},
							inheritedObjectUUID = "13c2132f-2132-8de9-b9a7-e4ed753ad523",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"d35d9131-600d-496b-bacc-e829f511d7b3",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "e4f24a5c-8e3a-4ba1-9d13-ea7b657fc997",
								version = 2.1,
							},
							inheritedObjectUUID = "d8af2c36-378a-4360-81de-9f9a30e3e00d",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"713a2649-2663-510f-9150-e2257e1c820b",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suite SPREAD puis tank à l'écart",
								uuid = "351c9284-6b1b-136b-9dc8-49bcbbb32a1f",
								version = 2.1,
							},
							inheritedObjectUUID = "b6856800-2e99-4af2-b407-3ec7423efa48",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"713a2649-2663-510f-9150-e2257e1c820b",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "a97c7e91-b6fe-5b18-8437-4efca0ef4d9e",
								version = 2.1,
							},
							inheritedObjectUUID = "919141ce-8159-78e4-bd94-4b2991de5c0b",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"07facd39-76ba-25e7-a178-0da2b290645b",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suite Tank à l'écart puis STACK",
								uuid = "f55b9874-7850-a6ea-a23c-72ae55d5c052",
								version = 2.1,
							},
							inheritedObjectUUID = "3ea25b5c-a24a-cb9e-b106-ae9de80c33e5",
							inheritedOverwrites = 
							{
								conditions = 
								{
									
									{
										type = "remove",
										value = 
										{
											"07facd39-76ba-25e7-a178-0da2b290645b",
											true,
										},
									},
									
									{
										type = "remove",
										value = 
										{
											"aa2b12b8-d90a-4f01-96c2-b5940c543e6a",
											true,
										},
									},
									
									{
										position = 1,
										type = "add",
										value = 
										{
											"f626640f-68bb-b597-bc4a-33b3c0d47cf2",
											true,
										},
									},
								},
							},
						},
					},
					
					{
						position = 25,
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"IN puis OUT\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"IN puis OUT\", 1, 2, true, 100)\nend\nself.used = true",
								conditions = 
								{
									
									{
										"08419f69-fe5f-28ce-91a8-79c0109474e0",
										true,
									},
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
								},
								name = "Voix - IN puis OUT",
								uuid = "5010f550-c8e5-adac-9061-fcc66296355a",
								version = 2.1,
							},
							inheritedIndex = 25,
						},
					},
					
					{
						position = 26,
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"IN puis STACK\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"IN puis STACK\", 1, 2, true, 100)\nend\nself.used = true",
								conditions = 
								{
									
									{
										"e62a2e13-be09-f064-ba90-3870788b23c1",
										true,
									},
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
								},
								name = "Voix - IN puis STACK",
								uuid = "85ed2960-9040-42de-bb93-c350c64f29e0",
								version = 2.1,
							},
							inheritedIndex = 26,
						},
					},
					
					{
						position = 27,
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"STACK puis OUT\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"STACK puis OUT\", 1, 2, true, 100)\nend\nself.used = true",
								conditions = 
								{
									
									{
										"5cb27dce-c12c-c103-b824-0d5dfd017c02",
										true,
									},
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
								},
								name = "Voix - STACK puis OUT",
								uuid = "2c9d853e-0e9f-7dca-b2a8-2316610f2179",
								version = 2.1,
							},
							inheritedIndex = 27,
						},
					},
					
					{
						position = 28,
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"STACK puis IN\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"STACK puis IN\", 1, 2, true, 100)\nend\nself.used = true",
								conditions = 
								{
									
									{
										"5f60399e-9431-a290-9701-8b9e0a4c498a",
										true,
									},
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
								},
								name = "Voix - STACK puis IN",
								uuid = "55c49556-b05d-b32e-9fde-9f8966f632f6",
								version = 2.1,
							},
							inheritedIndex = 28,
						},
					},
					
					{
						position = 29,
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"SPREAD puis OUT\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"SPREAD puis OUT\", 1, 2, true, 100)\nend\nself.used = true",
								conditions = 
								{
									
									{
										"fa8194a4-fb17-4ba2-8357-4adc58783d83",
										true,
									},
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
								},
								name = "Voix - SPREAD puis OUT",
								uuid = "5a71e2ed-a937-9707-b584-b3897b1e10f1",
								version = 2.1,
							},
							inheritedIndex = 29,
						},
					},
					
					{
						position = 30,
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"SPREAD puis IN\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"SPREAD puis IN\", 1, 2, true, 100)\nend\nself.used = true",
								conditions = 
								{
									
									{
										"d35d9131-600d-496b-bacc-e829f511d7b3",
										true,
									},
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
								},
								name = "Voix - SPREAD puis IN",
								uuid = "378bc59b-2656-d239-aded-accd6f62b891",
								version = 2.1,
							},
							inheritedIndex = 30,
						},
					},
					
					{
						position = 31,
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"SPREAD puis tank à l'écart\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"SPREAD puis tank à l'écart\", 1, 2, true, 100)\nend\nself.used = true",
								conditions = 
								{
									
									{
										"713a2649-2663-510f-9150-e2257e1c820b",
										true,
									},
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
								},
								name = "Voix - SPREAD puis tank à l'écart",
								uuid = "87f60104-0140-9901-9c1c-b2e46b092f6f",
								version = 2.1,
							},
							inheritedIndex = 31,
						},
					},
					
					{
						position = 32,
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"Tank à l'écart puis STACK\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"Tank à l'écart puis STACK\", 1, 2, true, 100)\nend\nself.used = true",
								conditions = 
								{
									
									{
										"07facd39-76ba-25e7-a178-0da2b290645b",
										true,
									},
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
								},
								name = "Voix - Tank à l'écart puis STACK",
								uuid = "5b13b2da-542a-76e1-92cd-8168b6d15df6",
								version = 2.1,
							},
							inheritedIndex = 32,
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"IN\", \"OUT\"\ns.firstSpell, s.finalSpell = 9916, 9915\ns.followup = \"OUT\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 2\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\n-- Cactbot quotes resolve after about 4.5-4.9s; this is only a route budget.\ns.routeMode, s.routeSpell = \"IN\", 9916\ns.routeStarted, s.routeDeadline, s.routeUntil = now, now + 4500, now + 5100\nself.used = true",
								conditions = 
								{
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
									
									{
										"08419f69-fe5f-28ce-91a8-79c0109474e0",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite IN puis OUT - état",
								uuid = "79398fab-83ca-3419-bf9a-8792afb13d27",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"IN\", \"STACK\"\ns.firstSpell, s.finalSpell = 9916, 9917\ns.followup = \"STACK\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 2\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\n-- Cactbot quotes resolve after about 4.5-4.9s; this is only a route budget.\ns.routeMode, s.routeSpell = \"IN\", 9916\ns.routeStarted, s.routeDeadline, s.routeUntil = now, now + 4500, now + 5100\nself.used = true",
								conditions = 
								{
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
									
									{
										"e62a2e13-be09-f064-ba90-3870788b23c1",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite IN puis STACK - état",
								uuid = "093a0474-682c-6ef7-be20-0c39bee4c6f9",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"STACK\", \"OUT\"\ns.firstSpell, s.finalSpell = 9917, 9915\ns.followup = \"OUT\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 2\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\nself.used = true",
								conditions = 
								{
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
									
									{
										"5cb27dce-c12c-c103-b824-0d5dfd017c02",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite STACK puis OUT - état",
								uuid = "ccd44a8f-5a0e-e8f5-8d5a-a508509fa6f3",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"STACK\", \"IN\"\ns.firstSpell, s.finalSpell = 9917, 9916\ns.followup = \"IN\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 2\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\nself.used = true",
								conditions = 
								{
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
									
									{
										"5f60399e-9431-a290-9701-8b9e0a4c498a",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite STACK puis IN - état",
								uuid = "97453386-15cd-5b8a-a328-1ab55ce1259b",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"SPREAD\", \"OUT\"\ns.firstSpell, s.finalSpell = 9918, 9915\ns.followup = \"OUT\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 2\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\nself.used = true",
								conditions = 
								{
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
									
									{
										"fa8194a4-fb17-4ba2-8357-4adc58783d83",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite SPREAD puis OUT - état",
								uuid = "b4e6a169-1400-129f-b23b-5ee5eb7d6dda",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"SPREAD\", \"IN\"\ns.firstSpell, s.finalSpell = 9918, 9916\ns.followup = \"IN\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 2\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\nself.used = true",
								conditions = 
								{
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
									
									{
										"d35d9131-600d-496b-bacc-e829f511d7b3",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite SPREAD puis IN - état",
								uuid = "4d50cbab-296b-7904-8c10-4b47f44f50d7",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"SPREAD\", \"TANK\"\ns.firstSpell, s.finalSpell = 9920, 9921\ns.followup = \"TANK\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 2\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\nself.used = true",
								conditions = 
								{
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
									
									{
										"713a2649-2663-510f-9150-e2257e1c820b",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite SPREAD puis tank à l'écart - état",
								uuid = "6649ae71-91da-eee7-9b70-0a1bb40025ee",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"TANK\", \"STACK\"\ns.firstSpell, s.finalSpell = 9921, 9917\ns.followup = \"STACK\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 2\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\nself.used = true",
								conditions = 
								{
									
									{
										"405039aa-66be-f5a3-a189-b615dd82f415",
										true,
									},
									
									{
										"07facd39-76ba-25e7-a178-0da2b290645b",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite Tank à l'écart puis STACK - état",
								uuid = "bad7ad3f-97ef-daee-95fa-3d766d10358c",
								version = 2.1,
							},
						},
					},
				},
				conditions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								category = "Lua",
								conditionLua = "local s = data.ucob_nael_calls\nlocal line = eventArgs.line and eventArgs.line.line\nif type(line) ~= \"string\" then return false end\nreturn not s or s.lastLine ~= line or not s.started or Now() - s.started > 2000",
								dequeueIfLuaFalse = true,
								name = "Citation nouvelle - état fiable",
								uuid = "405039aa-66be-f5a3-a189-b615dd82f415",
								version = 3,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								category = "Lua",
								conditionLua = "return false",
								dequeueIfLuaFalse = true,
								name = "Ancien état remplacé",
								uuid = "f626640f-68bb-b597-bc4a-33b3c0d47cf2",
								version = 3,
							},
						},
					},
				},
			},
		},
		
		{
			data = 
			{
				name = "Nael P2-P3 - Étapes de citation",
				uuid = "99b4a39b-2c25-b71e-8580-c78d5914fb25",
				version = 2,
			},
			inheritedObjectUUID = "3d911632-857c-ca41-85c4-a091cf04e11d",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Voix - IN",
								uuid = "9af3fcf8-d5b2-6a7a-b76a-4f91a173f086",
								version = 2.1,
							},
							inheritedObjectUUID = "638a4dee-19c4-96f6-b511-a1f9a735b525",
							inheritedOverwrites = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"IN\", 100) end\nelse\n    TensorCore.addAlertText(2500, \"IN\", 1, 2, true, 100)\nend\nself.used = true",
								name = "Voix - IN",
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Voix - OUT",
								uuid = "40368eb9-f86e-0a56-a684-b16d0e1adc72",
								version = 2.1,
							},
							inheritedObjectUUID = "fe017aef-a389-087f-9be5-114856e9d11e",
							inheritedOverwrites = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"OUT\", 100) end\nelse\n    TensorCore.addAlertText(2500, \"OUT\", 1, 2, true, 100)\nend\nself.used = true",
								name = "Voix - OUT",
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Voix - STACK",
								uuid = "5786b439-da7b-da5b-bf29-237510da2e4f",
								version = 2.1,
							},
							inheritedObjectUUID = "fbd0b584-a568-2a99-b34f-19bff4d585b3",
							inheritedOverwrites = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"STACK\", 100) end\nelse\n    TensorCore.addAlertText(2500, \"STACK\", 1, 2, true, 100)\nend\nself.used = true",
								name = "Voix - STACK",
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Voix - Tank à l'écart",
								uuid = "3fb969f2-631c-30af-9a0f-697d612b43fc",
								version = 2.1,
							},
							inheritedObjectUUID = "5cec99f2-e544-95e7-8e46-0cd2492c3662",
							inheritedOverwrites = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"Tank à l'écart\", 100) end\nelse\n    TensorCore.addAlertText(2500, \"Tank à l'écart\", 1, 2, true, 100)\nend\nself.used = true",
								name = "Voix - Tank à l'écart",
							},
						},
					},
					
					{
						position = 5,
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"SPREAD\", 100) end\nelse\n    TensorCore.addAlertText(2500, \"SPREAD\", 1, 2, true, 100)\nend\nself.used = true",
								alertDuration = 2500,
								alertPriority = 2,
								alertScale = 1,
								alertTTS = true,
								alertText = "SPREAD",
								alertVolume = 100,
								conditions = 
								{
									
									{
										"ecf423fb-c805-a0cd-b26d-1e681a3abf19",
										true,
									},
									
									{
										"f858d834-327b-a9f7-a0eb-2533288ccdb4",
										true,
									},
									
									{
										"f01a5f0d-b17b-18e1-bdd5-702aa805508b",
										true,
									},
								},
								name = "Voix - SPREAD",
								uuid = "afbbf140-5452-3d79-8692-c9069d44d392",
								version = 2.1,
							},
							inheritedIndex = 5,
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Consommer le rappel",
								uuid = "389b805d-3bca-2f4d-bcc0-354f79968cef",
								version = 2.1,
							},
							inheritedObjectUUID = "0f0de5b0-0950-465e-8ac4-177cc15ab097",
							inheritedOverwrites = 
							{
								actionLua = "local s = data.ucob_nael_calls\nlocal mode = s.followup\nlocal now = Now()\ns.current, s.next = mode, nil\ns.hudUntil, s.expires = now + 3500, now + 6000\ns.routeMode = s.phase == 2 and (mode == \"IN\" or mode == \"OUT\") and mode or nil\ns.routeSpell = s.finalSpell\ns.routeStarted, s.routeDeadline, s.routeUntil = now, now + 3100, now + 3700\ns.routeEstimated = true\ns.firstSpell, s.followup = nil, nil\nself.used = true",
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local s = data.ucob_nael_calls\ns.current, s.next, s.firstSpell, s.finalSpell, s.followup = nil, nil, nil, nil, nil\ns.hudUntil, s.expires = 0, 0\ns.routeMode, s.routeSpell = nil, nil\ns.routeUntil, s.routeDeadline = 0, 0\nself.used = true",
								conditions = 
								{
									
									{
										"ecf423fb-c805-a0cd-b26d-1e681a3abf19",
										true,
									},
									
									{
										"a1ff5baa-3f96-7dba-b551-3d0ecbe39919",
										true,
									},
								},
								name = "Terminer la citation",
								uuid = "9b1d6323-6cba-6318-9bb9-61885cc46cc3",
								version = 2.1,
							},
						},
					},
				},
				conditions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Attaque de citation",
								uuid = "c7db91bf-6d3e-08f3-b628-c7396e25ec12",
								version = 3,
							},
							inheritedObjectUUID = "ecf423fb-c805-a0cd-b26d-1e681a3abf19",
							inheritedOverwrites = 
							{
								spellIDList = 
								{
									
									{
										type = "remove",
										value = 9916,
									},
									
									{
										type = "remove",
										value = 9917,
									},
									
									{
										type = "remove",
										value = 9918,
									},
									
									{
										type = "remove",
										value = 9920,
									},
									
									{
										type = "remove",
										value = 9921,
									},
									
									{
										type = "add",
										value = 9915,
									},
									
									{
										type = "add",
										value = 9916,
									},
									
									{
										type = "add",
										value = 9917,
									},
									
									{
										type = "add",
										value = 9918,
									},
									
									{
										type = "add",
										value = 9920,
									},
									
									{
										type = "add",
										value = 9921,
									},
								},
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								category = "Lua",
								conditionLua = "return data.ucob_nael_calls.followup == \"SPREAD\"",
								dequeueIfLuaFalse = true,
								name = "Suite SPREAD",
								uuid = "f01a5f0d-b17b-18e1-bdd5-702aa805508b",
								version = 3,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								category = "Lua",
								conditionLua = "local s = data.ucob_nael_calls\nreturn s ~= nil and s.followup == nil and s.finalSpell == eventArgs.spellID and s.expires ~= nil and Now() <= s.expires",
								dequeueIfLuaFalse = true,
								name = "Dernière attaque attendue",
								uuid = "a1ff5baa-3f96-7dba-b551-3d0ecbe39919",
								version = 3,
							},
						},
					},
				},
				name = "Nael P2-P3 - Étapes de citation",
				timerEndOffset = 426,
			},
		},
		
		{
			data = 
			{
				name = "P2 - Prévisualisation des trajets",
				uuid = "bc601c57-f1af-ed1a-b08f-fa6551a9bc7a",
				version = 2,
			},
			inheritedObjectUUID = "080737fa-b460-8abc-923f-7d7921c3893c",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Calculer trajet visuel",
								uuid = "57a737a8-1d02-6f25-8d51-32c06bd0b0e2",
								version = 2.1,
							},
							inheritedObjectUUID = "ea9d3b5a-d0c8-8443-be33-89b85ec7dfbc",
							inheritedOverwrites = 
							{
								actionLua = "-- Visual-only planner v1. No movement commands.\n-- Quote timing: observed P2 casts; geometry cross-check: BossMod UCOB/Quote.cs.\n-- IN goal 3y (well inside the suggested 6y hole); OUT goal 10y (effective Chariot 8.55y).\n-- Active ground circles are avoided throughout travel. Unknown shapes suspend the preview.\nlocal now = Now()\nlocal q = data.ucob_nael_calls\nlocal doom = data.ucob_doom_hud\nlocal s = data.ucob_path_preview\n-- Glas uses its dedicated direct arrows. Give them sole ownership while active.\nlocal playerForDoom = TensorCore.mGetPlayer()\nlocal activeDoomBuff = playerForDoom and TensorCore.getBuff(playerForDoom, 210)\nif doom and doom.expires and now < doom.expires and activeDoomBuff and activeDoomBuff.duration > 0 then\n    if s then\n        s.clearDraw(s)\n        s.active, s.hasPath, s.doom, s.ok = false, false, nil, false\n        s.nextPlanAt, s.token, s.mode, s.validSince = nil, nil, nil, nil\n    end\n    self.used = true\n    return\nend\n-- Smooth the existing first segment between the bounded planner passes.\n-- Reuse the last verified route and obstacles; no party/AOE scan on this path.\nif s and s.nextPlanAt and now < s.nextPlanAt then\n    if s.active and s.ok and s.hasPath and s.arrows[1] then\n        local p = TensorCore.mGetPlayer()\n        if not p or not p.alive or p.hp.current <= 0 then\n            s.clearDraw(s)\n            s.active, s.hasPath, s.doom = false, false, nil\n            if q then q.routeMode = nil end\n        elseif now >= s.deadline or TensorReactions_CurrentTimer >= 403.2 then\n            s.clearDraw(s)\n            s.active, s.hasPath, s.doom = false, false, nil\n        else\n            local bx, bz = s.wx or s.gx, s.wz or s.gz\n            if s.segment(s, p.pos.x, p.pos.z, bx, bz) then\n                local ttlEnd = math.min(s.deadline, now + (403.2 - TensorReactions_CurrentTimer) * 1000)\n                s.draw(s, 1, p.pos.x, p.pos.y, p.pos.z, bx, bz, ttlEnd, now)\n            else\n                s.block(s, \"Trajet à recalculer\")\n            end\n        end\n    end\n    self.used = true\n    return\nend\nif not s then\n    s = {arrows = {}, born = {}, obstacles = {}, goals = {}, native = {}, naelGroup = {contentid = 2612}}\n    data.ucob_path_preview = s\n    function s.clearDraw(v)\n        if v.goalUUID then Argus.deleteTimedShape(v.goalUUID); v.goalUUID = nil end\n        for i = 1, 2 do\n            if v.arrows[i] then Argus.deleteTimedShape(v.arrows[i]) end\n            v.arrows[i], v.born[i] = nil, nil\n        end\n    end\n    function s.block(v, message)\n        v.clearDraw(v)\n        v.status, v.ok, v.validSince = message, false, nil\n        v.hasPath = false\n    end\n    function s.circle(v, x, z, radius)\n        v.n = v.n + 1\n        local c = v.obstacles[v.n]\n        if not c then c = {}; v.obstacles[v.n] = c end\n        c.x, c.z, c.r2 = x, z, radius * radius\n    end\n    function s.segment(v, ax, az, bx, bz)\n        -- Convex arena: if both endpoints are inside, the entire segment is inside.\n        if ax * ax + az * az > 400 or bx * bx + bz * bz > 400 then return false end\n        local dx, dz = bx - ax, bz - az\n        local len2 = dx * dx + dz * dz\n        for i = 1, v.n do\n            local c = v.obstacles[i]\n            local t = len2 > 0 and ((c.x - ax) * dx + (c.z - az) * dz) / len2 or 0\n            t = math.max(0, math.min(1, t))\n            local cx, cz = ax + t * dx - c.x, az + t * dz - c.z\n            if cx * cx + cz * cz <= c.r2 then return false end\n        end\n        return true\n    end\n    function s.distance(ax, az, bx, bz)\n        local dx, dz = bx - ax, bz - az\n        return math.sqrt(dx * dx + dz * dz)\n    end\n    function s.goal(v, x, z)\n        v.ng = v.ng + 1\n        local g = v.goals[v.ng]\n        if not g then g = {}; v.goals[v.ng] = g end\n        g.x, g.z = x, z\n    end\n    function s.find(v, px, pz, maxLength)\n        local best, gx, gz, wx, wz = maxLength, nil, nil, nil, nil\n        if v.ng > 0 and v.distance(px, pz, v.goals[1].x, v.goals[1].z) <= 0.5 and v.segment(v, px, pz, px, pz) then\n            return px, pz, nil, nil, 0\n        end\n        -- Retain a still-valid route so small position changes do not flip the detour.\n        if v.hasPath then\n            local validGoal = v.mode == \"GLAS\" and v.distance(v.gx, v.gz, v.goals[1].x, v.goals[1].z) < 0.2\n            if v.mode == \"IN\" then validGoal = v.distance(v.gx, v.gz, v.bx, v.bz) <= 3.5 end\n            if v.mode == \"OUT\" then validGoal = v.distance(v.gx, v.gz, v.bx, v.bz) >= 9.5 end\n            if validGoal then\n                local length\n                if v.segment(v, px, pz, v.gx, v.gz) then\n                    length = v.distance(px, pz, v.gx, v.gz)\n                    if length <= best then return v.gx, v.gz, nil, nil, length end\n                elseif v.wx and v.segment(v, px, pz, v.wx, v.wz) and v.segment(v, v.wx, v.wz, v.gx, v.gz) then\n                    length = v.distance(px, pz, v.wx, v.wz) + v.distance(v.wx, v.wz, v.gx, v.gz)\n                    if length <= best then return v.gx, v.gz, v.wx, v.wz, length end\n                end\n            end\n        end\n        -- At most 9 goals and 12 one-waypoint alternatives per goal.\n        for i = 1, v.ng do\n            local g = v.goals[i]\n            local length = v.distance(px, pz, g.x, g.z)\n            if length <= best then\n                if v.segment(v, px, pz, g.x, g.z) then\n                    best, gx, gz, wx, wz = length, g.x, g.z, nil, nil\n                elseif length > 0.05 then\n                    local nx, nz = -(g.z - pz) / length, (g.x - px) / length\n                    local mx, mz = (px + g.x) * 0.5, (pz + g.z) * 0.5\n                    for offset = 2, 12, 2 do\n                        for side = -1, 1, 2 do\n                            local x, z = mx + nx * offset * side, mz + nz * offset * side\n                            local total = v.distance(px, pz, x, z) + v.distance(x, z, g.x, g.z)\n                            if total < best and v.segment(v, px, pz, x, z) and v.segment(v, x, z, g.x, g.z) then\n                                best, gx, gz, wx, wz = total, g.x, g.z, x, z\n                            end\n                        end\n                    end\n                end\n            end\n        end\n        return gx, gz, wx, wz, best\n    end\n    function s.draw(v, i, ax, ay, az, bx, bz, expires, tick)\n        local d = v.distance(ax, az, bx, bz)\n        if d < 0.15 then\n            if v.arrows[i] then Argus.deleteTimedShape(v.arrows[i]) end\n            v.arrows[i], v.born[i] = nil, nil\n            return\n        end\n        v.from.x, v.from.y, v.from.z = ax, ay, az\n        v.to.x, v.to.y, v.to.z = bx, ay, bz\n        local heading = TensorCore.getHeadingToTarget(v.from, v.to)\n        local tip = math.min(1.1, d * 0.4)\n        if v.arrows[i] and not v.drawer:updateTimedArrow(v.arrows[i], nil, ax, ay, az, heading, d - tip, 0.55, tip, 1.3) then\n            v.arrows[i], v.born[i] = nil, nil\n        end\n        if not v.arrows[i] then\n            v.born[i] = tick\n            v.arrows[i] = v.drawer:addTimedArrow(math.max(1, math.floor(expires - tick)), ax, ay, az, heading, d - tip, 0.55, tip, 1.3)\n        end\n    end\n    s.from, s.to = {}, {}\n    s.drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\n    s.drawer:setGradient(0.25, 0.4, 1.5)\nend\nif not s.goalCleanupV1 then\n    function s.clearDraw(v)\n        if v.goalUUID then Argus.deleteTimedShape(v.goalUUID); v.goalUUID = nil end\n        for i = 1, 2 do\n            if v.arrows[i] then Argus.deleteTimedShape(v.arrows[i]) end\n            v.arrows[i], v.born[i] = nil, nil\n        end\n    end\n    s.goalCleanupV1 = true\nend\ns.nextPlanAt = now + 100\ns.pulse = now\nlocal p = TensorCore.mGetPlayer()\nif not p or not p.alive or p.hp.current <= 0 then\n    s.clearDraw(s)\n    s.active, s.hasPath, s.doom = false, false, nil\n    if q then q.routeMode = nil end\n    self.used = true return\nend\nlocal buff = TensorCore.getBuff(p, 210)\nlocal hasDoom = doom and doom.expires and doom.expires > now and buff and buff.duration > 0\nif q and q.routeMode then\n    local resolved = data.ucob_path_casts and data.ucob_path_casts[q.routeSpell]\n    if now >= q.routeUntil or (resolved and resolved >= q.routeStarted) then q.routeMode = nil end\nend\nlocal mode, token, deadline\nif hasDoom then\n    mode, token, deadline = \"GLAS\", doom, now + buff.duration * 1000\nelseif q and q.routeMode then\n    mode, token, deadline = q.routeMode, q.routeStarted, q.routeDeadline\nend\nif not mode then\n    s.clearDraw(s)\n    s.active, s.hasPath, s.doom = false, false, nil\n    self.used = true return\nend\nif s.token ~= token or s.mode ~= mode then\n    s.clearDraw(s)\n    s.hasPath, s.validSince = false, nil\n    s.token, s.mode = token, mode\nend\ns.active, s.doom, s.deadline = true, hasDoom and doom or nil, deadline\ns.title = mode == \"GLAS\" and \"GLAS · trajet proposé\" or mode .. \" · trajet proposé\"\nif hasDoom and q and q.routeMode then\n    s.block(s, \"Consignes simultanées : trajet non vérifié\")\n    self.used = true return\nend\nif hasDoom and not doom.position then\n    s.block(s, \"En attente de ta zone de purification\")\n    self.used = true return\nend\nlocal ownThunder = TensorCore.getBuff(p, 466)\nif ownThunder and ownThunder.duration > 0 then\n    s.block(s, \"Foudre sur toi : placement manuel\")\n    self.used = true return\nend\ns.n, s.ng = 0, 0\nlocal px, pz = p.pos.x, p.pos.z\nlocal boss\nif mode == \"GLAS\" then\n    s.goal(s, doom.position.x, doom.position.z)\nelse\n    boss = TensorCore.getEntityByGroup(\"ContentID\", s.naelGroup)\n    if not boss or not boss.alive then\n        s.block(s, \"Position de Nael indisponible\")\n        self.used = true return\n    end\n    s.bx, s.bz = boss.pos.x, boss.pos.z\n    local dx, dz = px - s.bx, pz - s.bz\n    local distance = math.sqrt(dx * dx + dz * dz)\n    if (mode == \"IN\" and distance <= 3.5) or (mode == \"OUT\" and distance >= 9.5) then s.goal(s, px, pz) end\n    if distance < 0.01 then\n        dx, dz = -s.bx, -s.bz\n        distance = math.sqrt(dx * dx + dz * dz)\n        if distance < 0.01 then dx, dz, distance = 0, -1, 1 end\n    end\n    dx, dz = dx / distance, dz / distance\n    local radius = mode == \"IN\" and 3 or 10\n    for i = 0, 7 do\n        local angle = i * math.pi / 4\n        local c, n = math.cos(angle), math.sin(angle)\n        s.goal(s, s.bx + radius * (dx * c - dz * n), s.bz + radius * (dx * n + dz * c))\n    end\nend\n-- Direct party status read covers a lost/delayed thunder draw event.\nlocal party = TensorCore.getEntityGroupList(\"Party\")\nif not party or next(party) == nil then\n    s.block(s, \"État du groupe indisponible\")\n    self.used = true return\nend\nlocal partyCount = 0\nfor _, member in pairs(party) do\n    partyCount = partyCount + 1\n    if member.id ~= p.id and member.alive and member.hp.current > 0 then\n        local thunder = TensorCore.getBuff(member, 466)\n        if thunder and thunder.duration > 0 then\n            if TensorCore.getEntitySpeed(member) > 0.5 then\n                s.block(s, \"Porteur de foudre en mouvement\")\n                self.used = true return\n            end\n            s.circle(s, member.pos.x, member.pos.z, 5.8)\n        end\n    end\nend\nif partyCount ~= 8 then\n    s.block(s, \"État du groupe incomplet\")\n    self.used = true return\nend\nif data.ucob_path_poolOverflow then\n    s.block(s, \"Zones de purification incomplètes\")\n    self.used = true return\nend\n-- Avoid other cleanse puddles; only the assigned Glas destination is exempt.\nlocal pools = data.ucob_path_pools\nif pools then\n    for i = 1, #pools do\n        local pool = pools[i]\n        if not hasDoom or s.distance(pool.x, pool.z, doom.position.x, doom.position.z) > 0.25 then\n            s.circle(s, pool.x, pool.z, 1.6)\n        end\n    end\nend\nlocal aoes = Argus.getCurrentAOEs()\nif not aoes or #aoes > 32 then\n    s.block(s, \"Lecture des AOE indisponible\")\n    self.used = true return\nend\nfor i = 1, #aoes do\n    local a = aoes[i]\n    if a.friendly ~= true then\n        local ownQuote = boss and a.entityID == boss.id and a.aoeID == q.routeSpell\n        if not ownQuote then\n            -- v1 supports ground circles (type 2). Other shapes are deliberately unresolved.\n            if a.aoeCastType ~= 2 or type(a.aoeLength) ~= \"number\" or a.aoeLength <= 0 or type(a.x) ~= \"number\" or type(a.z) ~= \"number\" then\n                s.unknownUntil = now + 400\n            else\n                local key = tostring(a.entityID) .. \":\" .. tostring(a.aoeID) .. \":\" .. tostring(a.startTime)\n                local c = s.native[key]\n                if not c then c = {}; s.native[key] = c end\n                c.x, c.z, c.r, c.seen = a.x, a.z, a.aoeLength + 0.8, now\n            end\n        end\n    end\nend\nfor key, c in pairs(s.native) do\n    if now - c.seen > 400 then s.native[key] = nil\n    else s.circle(s, c.x, c.z, c.r) end\nend\nif s.n > 48 then\n    s.block(s, \"Trop de dangers simultanés\")\n    self.used = true return\nend\nif s.unknownUntil and now < s.unknownUntil then\n    s.block(s, \"AOE non couverte : trajet non vérifié\")\n    self.used = true return\nend\nlocal speed = math.min(TensorCore.getSpeed(), 6)\nif speed <= 0 then\n    s.block(s, \"Vitesse de déplacement indisponible\")\n    self.used = true return\nend\n-- 0.5s budget reserve; no Sprint assumption, no claim of future ally prediction.\nlocal budget = math.max(0, (deadline - now) / 1000 - 0.5) * speed\nlocal gx, gz, wx, wz, length = s.find(s, px, pz, budget)\nif not gx then\n    s.block(s, \"Aucun trajet vérifié dans le temps restant\")\n    self.used = true return\nend\ns.gx, s.gz, s.wx, s.wz, s.hasPath = gx, gz, wx, wz, true\ns.validSince = s.validSince or now\ns.eta = length / speed\nif now - s.validSince < 200 then\n    s.status, s.ok = \"Vérification du passage…\", false\n    self.used = true return\nend\ns.ok = true\nif mode ~= \"GLAS\" then\n    local remaining = math.floor(math.min(deadline - now, (403.2 - TensorReactions_CurrentTimer) * 1000))\n    if remaining > 0 then\n        local marker = TensorCore.getCachedDrawer(0xFFFFF060, nil, 0xFFFFF060, 4279504646, 4)\n        if s.goalUUID and not marker:updateTimedDonut(s.goalUUID, nil, gx, p.pos.y, gz, 0.55, 0.95, 0, false, true) then s.goalUUID = nil end\n        if not s.goalUUID then s.goalUUID = marker:addTimedDonut(remaining, gx, p.pos.y, gz, 0.55, 0.95, 0, false, true) end\n    end\nend\nif length <= 0.5 then\n    for i = 1, 2 do\n        if s.arrows[i] then Argus.deleteTimedShape(s.arrows[i]); s.arrows[i] = nil end\n    end\n    s.status = \"Déjà placé · reste attentif aux nouveaux dangers\"\nelse\n    s.status = string.format(\"Trajet estimé %.1f s · dangers détectés\", s.eta)\n    local ttlEnd = math.min(deadline, now + math.max(0, 403.2 - TensorReactions_CurrentTimer) * 1000)\n    if wx then\n        s.draw(s, 1, px, p.pos.y, pz, wx, wz, ttlEnd, now)\n        s.draw(s, 2, wx, p.pos.y, wz, gx, gz, ttlEnd, now)\n    else\n        s.draw(s, 1, px, p.pos.y, pz, gx, gz, ttlEnd, now)\n        if s.arrows[2] then Argus.deleteTimedShape(s.arrows[2]); s.arrows[2] = nil end\n    end\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
		
		{
			data = 
			{
				name = "P2 - État du trajet",
				uuid = "b26a1042-3cb7-6c9e-9b6f-62884a72c040",
				version = 2,
			},
			inheritedObjectUUID = "551cffb1-544d-4333-9a9c-8ce290a37750",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Afficher prévisualisation",
								uuid = "5b24fb2c-ed18-9150-be6f-b47dec07ee63",
								version = 2.1,
							},
							inheritedObjectUUID = "c29351c0-7716-498a-98ba-c37844e7527c",
							inheritedOverwrites = 
							{
								actionLua = "if data.ucob_guide then self.used = true return end\nlocal s = data.ucob_path_preview\nif s and s.active and s.pulse and Now() - s.pulse < 500 then\n    s.hudFlags = GUI.WindowFlags_NoResize + GUI.WindowFlags_NoCollapse + GUI.WindowFlags_AlwaysAutoResize + GUI.WindowFlags_NoFocusOnAppearing\n    local width, height = GUI:GetScreenSize()\n    GUI:SetNextWindowPos(width * 0.5, height * 0.33, GUI.SetCond_FirstUseEver, 0.5, 0)\n    local visible = GUI:Begin(\"Trajet##ucob_path_preview\", true, s.hudFlags)\n    if visible then\n        GUI:SetWindowFontScale(1.2)\n        GUI:TextColored(0.35, 0.9, 1, 1, s.title)\n        if s.ok then GUI:TextUnformatted(s.status)\n        else GUI:TextColored(1, 0.75, 0.3, 1, s.status) end\n        GUI:TextUnformatted(\"Prévisualisation · déplacement manuel\")\n    end\n    GUI:End()\nend\nself.used = true",
							},
						},
					},
				},
			},
		},
	},
	[49] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "82a51df3-56dd-c39f-9a75-4fc180e0c363",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Foudre - Maintien des cercles",
				uuid = "99dc31c2-7fda-22c2-8d3b-9b81cc3dca16",
				version = 2,
			},
			inheritedObjectUUID = "4afc65cc-6e31-98e9-a8db-6b5fca916fd6",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Maintenir et retirer les cercles",
								uuid = "5ebc0441-417a-24a7-b8dc-73513a3b72e2",
								version = 2.1,
							},
							inheritedObjectUUID = "71314c63-72f0-904c-b72c-3049410c2ff2",
							inheritedOverwrites = 
							{
								actionLua = "local entries = data.ucob_visual_thunder\nlocal now = Now()\nlocal player = TensorCore.mGetPlayer()\nif entries then\n    local drawer = TensorCore.getCachedDrawer(1207910566, nil, 1207910566, 4076832209, 2)\n    drawer:setGradient(0.6, 0.65, 1.5)\n    for id, state in pairs(entries) do\n        local entity = TensorCore.mGetEntity(id)\n        local buff = entity and TensorCore.getBuff(entity, 466)\n        local remove = entity and (not entity.alive or entity.hp.current <= 0)\n        if not remove and buff and buff.duration > 0 then\n            local dx = player and player.pos.x - entity.pos.x or 100\n            local dz = player and player.pos.z - entity.pos.z or 100\n            local close = player and player.alive and (player.id == id or dx * dx + dz * dz <= (state.emphasis and 30.25 or 25))\n            state.emphasis = close and true or false\n            local activeDrawer = close and TensorCore.getCachedDrawer(0x403F7FFF, nil, 0x403F7FFF, 0xFF3F7FFF, 4) or drawer\n            local remaining = math.floor(buff.duration * 1000)\n            if remaining > 0 then\n                state.missingSince = nil\n                state.expires = now + remaining\n                local timeout = math.floor(state.expires - state.added)\n                if state.uuid and not activeDrawer:updateTimedCircleOnEnt(state.uuid, timeout, id, 5, 0, false, true) then\n                    state.uuid = nil\n                end\n                if not state.uuid then\n                    state.added = now\n                    state.uuid = activeDrawer:addTimedCircleOnEnt(remaining, id, 5, 0, false, true)\n                end\n            else\n                remove = true\n            end\n        elseif not remove then\n            -- Ignore a brief missing entity/status sample; retain the same draw.\n            state.missingSince = state.missingSince or now\n            remove = now >= state.expires or now - state.missingSince >= 300\n        end\n        if remove then\n            if state.uuid then Argus.deleteTimedShape(state.uuid) end\n            entries[id] = nil\n        end\n    end\nend\nself.used = true",
							},
						},
					},
				},
			},
		},
	},
	[50] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "2360c9e1-c81f-7aed-97da-d31f79926891",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Glas 1 - Zone",
				uuid = "4cab04f4-dff0-b697-b5a1-b7eeedaaafa4",
				version = 2,
			},
			inheritedObjectUUID = "358814db-0446-0da0-bb35-0cae27efc026",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Reperer purification assignee",
								uuid = "f86e5463-52ec-a966-80dc-55bdc58b86e9",
								version = 2.1,
							},
							inheritedObjectUUID = "026ae7ab-d5ed-775a-b010-a9b13405d9dd",
							inheritedOverwrites = 
							{
								actionLua = "-- Salvation 26CA: one cleanse in order per resolved cast.\nlocal state = data.ucob_doom_arrow_1\nstate.count = state.count + 1\nif state.count == state.order then\n    if eventArgs.castPosX ~= nil and eventArgs.castPosY ~= nil and eventArgs.castPosZ ~= nil then\n        state.position = {x = eventArgs.castPosX, y = eventArgs.castPosY, z = eventArgs.castPosZ}\n        local player = TensorCore.mGetPlayer()\n        local buff = TensorCore.getBuff(player, 210)\n        local remaining = math.floor(math.min(buff and buff.duration or 0, 261.1 - TensorReactions_CurrentTimer) * 1000)\n        if player.alive and player.hp.current > 0 and remaining > 0 then\n            -- Small destination marker; not the Salvation hitbox.\n            local drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 4)\n            drawer:setGradient(0.12, 0.4, 1.5)\n            state.destinationUUID = drawer:addTimedDonut(remaining, state.position.x, state.position.y, state.position.z, 0.55, 0.95, 0, false, true)\n        end\n    end\nend\nself.used = true",
							},
						},
					},
				},
			},
		},
		
		{
			data = 
			{
				name = "Glas 1 - Fleche",
				uuid = "a0796277-1842-e640-aed6-0c7f84cddb42",
				version = 2,
			},
			inheritedObjectUUID = "fc28f95d-576a-7bf3-95fe-71a59f71ab8d",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Actualiser fleche Glas",
								uuid = "a93b3e4e-73f3-4548-8a21-37adf421e742",
								version = 2.1,
							},
							inheritedObjectUUID = "c96571d3-4391-b8d6-b32e-0f1236498408",
							inheritedOverwrites = 
							{
								actionLua = "local state = data.ucob_doom_arrow_1\nlocal player = TensorCore.mGetPlayer()\nif not player or not player.alive or player.hp.current <= 0 then\n    if state.uuid ~= nil then\n        Argus.deleteTimedShape(state.uuid)\n        state.uuid = nil\n    end\n    if state.destinationUUID ~= nil then\n        Argus.deleteTimedShape(state.destinationUUID)\n        state.destinationUUID = nil\n    end\n    state.position = nil\n    self.used = true\n    return\nend\n-- Direct bearing to the assigned cleanse zone; not a collision-free route.\nlocal position = player.pos\nlocal dx = state.position.x - position.x\nlocal dz = state.position.z - position.z\nlocal distance = math.sqrt(dx * dx + dz * dz)\nlocal drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\nif distance > 0.5 then\n    local heading = TensorCore.getHeadingToTarget(position, state.position)\n    local tipLength = math.min(1.1, distance * 0.4)\n    local length = distance - tipLength\n    local baseWidth = math.min(0.55, distance * 0.25)\n    local tipWidth = math.min(1.3, distance * 0.6)\n    drawer:setGradient(baseWidth * 0.5, 0.4, 1.5)\n    if state.uuid ~= nil then\n        local updated = drawer:updateTimedArrow(state.uuid, nil, position.x, position.y, position.z, heading, length, baseWidth, tipLength, tipWidth)\n        if not updated then state.uuid = nil end\n    end\n    if state.uuid == nil then\n        local buff = TensorCore.getBuff(player, 210)\n        local remaining = math.floor(math.min(buff and buff.duration or 0, 261.1 - TensorReactions_CurrentTimer) * 1000)\n        if remaining > 0 then\n            state.uuid = drawer:addTimedArrow(remaining, position.x, position.y, position.z, heading, length, baseWidth, tipLength, tipWidth)\n        end\n    end\nelseif state.uuid ~= nil then\n    Argus.deleteTimedShape(state.uuid)\n    state.uuid = nil\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
		
		{
			data = 
			{
				name = "Glas - Ordre et compte a rebours",
				uuid = "053db35b-ee1b-4a34-bcfe-bb3ae745b25d",
				version = 2,
			},
			inheritedObjectUUID = "8e512a49-c3fe-1a9d-b1e6-b19dc46df77e",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Afficher suivi personnel Glas",
								uuid = "b3c1a6bd-12c2-938f-9594-4c69df82a1c1",
								version = 2.1,
							},
							inheritedObjectUUID = "9f584229-bd38-5f84-ad08-c82386dac332",
							inheritedOverwrites = 
							{
								actionLua = "local state = data.ucob_doom_hud\nif not state then self.used = true return end\nlocal now = Now()\nif not state.hudNextUpdate or now >= state.hudNextUpdate then\n    state.hudNextUpdate = now + 100\n    local player = TensorCore.mGetPlayer()\n    if not player.alive or player.hp.current <= 0 then\n        state.hudVisible = false\n        state.hudStopped = true\n        state.hudUntil = nil\n    elseif state.hudStopped then\n        state.hudVisible = state.hudUntil ~= nil and now < state.hudUntil\n    else\n        local buff = TensorCore.getBuff(player, 210)\n        if buff and buff.duration > 0 then\n            state.hudMissingSince = nil\n            state.hudWasActive = true\n            state.hudVisible = true\n            local tenths = math.ceil(buff.duration * 10)\n            if state.hudTenths ~= tenths then\n                state.hudTenths = tenths\n                state.hudText = string.format(\"GLAS %d  |  %.1f s\", state.order, tenths / 10)\n            end\n            if state.position then\n                local dx = state.position.x - player.pos.x\n                local dz = state.position.z - player.pos.z\n                state.hudStatus = dx * dx + dz * dz <= 0.25 and \"Dans la zone\" or \"Rejoins ta zone\"\n            else\n                state.hudStatus = \"Zone en attente\"\n            end\n        else\n            state.hudVisible = false\n            state.hudMissingSince = state.hudMissingSince or now\n            if now - state.hudMissingSince >= 200 then\n                state.hudStopped = true\n                if state.hudWasActive and state.expires and now < state.expires - 500 then\n                    state.hudComplete = true\n                    state.hudVisible = true\n                    state.hudUntil = now + 1500\n                    state.hudText = \"GLAS \" .. state.order\n                    state.hudStatus = \"Glas retiré\"\n                end\n            end\n        end\n    end\nend\nif data.ucob_guide then self.used = true return end\nif state.hudVisible then\n    state.hudFlags = GUI.WindowFlags_NoResize + GUI.WindowFlags_NoCollapse + GUI.WindowFlags_AlwaysAutoResize + GUI.WindowFlags_NoFocusOnAppearing\n    local width, height = GUI:GetScreenSize()\n    GUI:SetNextWindowPos(width * 0.5, height * 0.25, GUI.SetCond_FirstUseEver, 0.5, 0)\n    local visible = GUI:Begin(\"Glas##ucob_doom_hud\", true, state.hudFlags)\n    if visible then\n        GUI:SetWindowFontScale(1.15)\n        GUI:TextColored(0.25, 0.9, 1, 1, state.hudText)\n        if state.hudComplete then\n            GUI:TextColored(0.35, 1, 0.55, 1, state.hudStatus)\n        else\n            GUI:TextUnformatted(state.hudStatus)\n        end\n    end\n    GUI:End()\nend\nself.used = true",
							},
						},
					},
				},
			},
		},
	},
	[51] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "9b4f9d0e-99e6-8d3a-73a4-adf42d20027e",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Feu personnel",
				uuid = "4c3c1e55-0c50-8e35-9ccf-34dc76fa0663",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local n = 1\nlocal f = data.ucob_guide_fire\nif not f then\n    f = {hits = {}, seen = {}}\n    data.ucob_guide_fire = f\nend\nlocal hits = f.hits[n]\nif not hits then hits = {}; f.hits[n] = hits end\nlocal targets = eventArgs.hitTargets\nif type(targets) == \"table\" then\n    for _, id in ipairs(targets) do\n        if type(id) == \"number\" and id > 0 then\n            hits[id] = true\n            f.seen[n] = true\n        end\n    end\nend\nf.resolved = f.resolved or {}\nf.resolved[n] = true\nif f.wave == n then\n    f.expires = 0\nend\nself.used = true",
							conditions = 
							{
								
								{
									"144400f5-0c53-ba6e-9aaa-fa5bc05e1e03",
									true,
								},
							},
							name = "Mémoriser les joueurs touchés",
							uuid = "c159cb26-6aae-e967-812c-037fa6a6fede",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 9925,
							name = "Feu 9925",
							uuid = "144400f5-0c53-ba6e-9aaa-fa5bc05e1e03",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Feu personnel",
				eventType = 2,
				loop = true,
				mechanicTime = 241.1,
				name = "P2 Feu 1 - Impacts confirmés",
				timeRange = true,
				timelineIndex = 51,
				timerEndOffset = 6,
				timerStartOffset = -6,
				uuid = "886ba29d-aa58-306e-a718-89f911ed0eb8",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local n = 1\nlocal now = Now()\nlocal f = data.ucob_guide_fire\nif not f then\n    f = {hits = {}, seen = {}}\n    data.ucob_guide_fire = f\nend\nif f.resolved and f.resolved[n] then\n    if f.wave == n then f.expires = 0 end\n    self.used = true\n    return\nend\nlocal player = TensorCore.mGetPlayer()\nif not player then self.used = true; return end\nlocal title, detail, decision\nif TensorCore.getBuff(player, 466) then\n    title = \"FOUDRE — RESTE ÉCARTÉ\"\n    detail = \"Feu \" .. n .. \" : attends la résolution de ta foudre.\"\n    decision = \"thunder\"\nelse\n    local known = true\n    for i = 1, n - 1 do\n        if not f.seen[i] then known = false; break end\n    end\n    if not known then\n        title = \"FEU \" .. n .. \" — HISTORIQUE INCOMPLET\"\n        detail = \"Participation non confirmée : vérifie tes buffs et le porteur.\"\n        decision = \"unknown\"\n    elseif n == 1 then\n        title = \"FEU 1 — PARTAGE LE FEU\"\n        detail = \"Rejoins le porteur pour le premier feu.\"\n        decision = \"in\"\n    elseif n == 2 then\n        if f.hits[1][player.id] then\n            title = \"FEU 2 — ÉVITE LE FEU\"\n            detail = \"Le porteur sort du groupe. Si c'est toi, reste à l'écart.\"\n            decision = \"out\"\n        else\n            title = \"FEU 2 — REJOINS LE PORTEUR\"\n            detail = \"Premier feu manqué : prends ce feu avec le porteur.\"\n            decision = \"catchup\"\n        end\n    elseif n == 3 then\n        if f.hits[1][player.id] and f.hits[2][player.id] then\n            title = \"FEU 3 — RESTE À L'ÉCART\"\n            detail = \"Tu as pris les feux 1 et 2 : évite le partage.\"\n            decision = \"out\"\n        else\n            title = \"FEU 3 — PARTAGE LE FEU\"\n            detail = \"Rejoins le porteur ; laisse les doubles porteurs à l'écart.\"\n            decision = \"in\"\n        end\n    else\n        if f.hits[1][player.id] and f.hits[2][player.id] and f.hits[3][player.id] then\n            title = \"FEU 4 — RESTE À L'ÉCART\"\n            detail = \"Tu as pris les trois feux : évite ce partage.\"\n            decision = \"out\"\n        else\n            title = \"FEU 4 — PARTAGE LE FEU\"\n            detail = \"Rejoins le porteur pour le dernier feu.\"\n            decision = \"in\"\n        end\n    end\nend\nf.wave = n\nf.title = title\nf.detail = detail\nf.expires = now + 450\nf.priority = 75\nf.key = \"p2_fire_\" .. n .. \"_\" .. decision\nself.used = true",
							name = "Actualiser la consigne de feu",
							uuid = "a857d5cb-392c-b950-ad55-f7edbbdaef65",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Feu personnel",
				loop = true,
				mechanicTime = 241.1,
				name = "P2 Feu 1 - Consigne personnelle",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 51,
				timerEndOffset = 3,
				timerStartOffset = -6,
				uuid = "1571a0ad-1434-e0d1-b850-f02e282af7d1",
				version = 2,
			},
		},
	},
	[53] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "7ab5c3ca-c9cd-775c-b1f0-f125379af767",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.put([==[tankPrep]==],[==[BAHAMUT'S CLAW — 5 COUPS]==],[==[Tanks : gardez votre mitigation pendant les cinq coups]==],nil,62,7000)\nself.used=true",
				executeType = 2,
				mechanicTime = 249.3,
				name = "P2 - BAHAMUT'S CLAW — 5 COUPS (249.3s)",
				timeRange = true,
				timelineIndex = 53,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "577ab7b8-cbbe-667e-b324-85ee6a1e7ba1",
				version = 2,
			},
		},
	},
	[54] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "d1901845-835d-0909-8cb1-b8b334628675",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Feu personnel",
				uuid = "6348c21b-9cdb-bd04-9bd2-eb0cc6f89859",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local n = 2\nlocal f = data.ucob_guide_fire\nif not f then\n    f = {hits = {}, seen = {}}\n    data.ucob_guide_fire = f\nend\nlocal hits = f.hits[n]\nif not hits then hits = {}; f.hits[n] = hits end\nlocal targets = eventArgs.hitTargets\nif type(targets) == \"table\" then\n    for _, id in ipairs(targets) do\n        if type(id) == \"number\" and id > 0 then\n            hits[id] = true\n            f.seen[n] = true\n        end\n    end\nend\nf.resolved = f.resolved or {}\nf.resolved[n] = true\nif f.wave == n then\n    f.expires = 0\nend\nself.used = true",
							conditions = 
							{
								
								{
									"eeddc546-4af4-1138-abb3-3dbb3992195b",
									true,
								},
							},
							name = "Mémoriser les joueurs touchés",
							uuid = "1057520a-96df-9233-bbb6-b5d669677d54",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 9925,
							name = "Feu 9925",
							uuid = "eeddc546-4af4-1138-abb3-3dbb3992195b",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Feu personnel",
				eventType = 2,
				loop = true,
				mechanicTime = 256,
				name = "P2 Feu 2 - Impacts confirmés",
				timeRange = true,
				timelineIndex = 54,
				timerEndOffset = 6,
				timerStartOffset = -6,
				uuid = "85800cc3-51d2-39be-9726-866672337c7f",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local n = 2\nlocal now = Now()\nlocal f = data.ucob_guide_fire\nif not f then\n    f = {hits = {}, seen = {}}\n    data.ucob_guide_fire = f\nend\nif f.resolved and f.resolved[n] then\n    if f.wave == n then f.expires = 0 end\n    self.used = true\n    return\nend\nlocal player = TensorCore.mGetPlayer()\nif not player then self.used = true; return end\nlocal title, detail, decision\nif TensorCore.getBuff(player, 466) then\n    title = \"FOUDRE — RESTE ÉCARTÉ\"\n    detail = \"Feu \" .. n .. \" : attends la résolution de ta foudre.\"\n    decision = \"thunder\"\nelse\n    local known = true\n    for i = 1, n - 1 do\n        if not f.seen[i] then known = false; break end\n    end\n    if not known then\n        title = \"FEU \" .. n .. \" — HISTORIQUE INCOMPLET\"\n        detail = \"Participation non confirmée : vérifie tes buffs et le porteur.\"\n        decision = \"unknown\"\n    elseif n == 1 then\n        title = \"FEU 1 — PARTAGE LE FEU\"\n        detail = \"Rejoins le porteur pour le premier feu.\"\n        decision = \"in\"\n    elseif n == 2 then\n        if f.hits[1][player.id] then\n            title = \"FEU 2 — ÉVITE LE FEU\"\n            detail = \"Le porteur sort du groupe. Si c'est toi, reste à l'écart.\"\n            decision = \"out\"\n        else\n            title = \"FEU 2 — REJOINS LE PORTEUR\"\n            detail = \"Premier feu manqué : prends ce feu avec le porteur.\"\n            decision = \"catchup\"\n        end\n    elseif n == 3 then\n        if f.hits[1][player.id] and f.hits[2][player.id] then\n            title = \"FEU 3 — RESTE À L'ÉCART\"\n            detail = \"Tu as pris les feux 1 et 2 : évite le partage.\"\n            decision = \"out\"\n        else\n            title = \"FEU 3 — PARTAGE LE FEU\"\n            detail = \"Rejoins le porteur ; laisse les doubles porteurs à l'écart.\"\n            decision = \"in\"\n        end\n    else\n        if f.hits[1][player.id] and f.hits[2][player.id] and f.hits[3][player.id] then\n            title = \"FEU 4 — RESTE À L'ÉCART\"\n            detail = \"Tu as pris les trois feux : évite ce partage.\"\n            decision = \"out\"\n        else\n            title = \"FEU 4 — PARTAGE LE FEU\"\n            detail = \"Rejoins le porteur pour le dernier feu.\"\n            decision = \"in\"\n        end\n    end\nend\nf.wave = n\nf.title = title\nf.detail = detail\nf.expires = now + 450\nf.priority = 75\nf.key = \"p2_fire_\" .. n .. \"_\" .. decision\nself.used = true",
							name = "Actualiser la consigne de feu",
							uuid = "d8570ff0-665d-2d39-84f0-b3bdb7f0b2d1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Feu personnel",
				loop = true,
				mechanicTime = 256,
				name = "P2 Feu 2 - Consigne personnelle",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 54,
				timerEndOffset = 3,
				timerStartOffset = -6,
				uuid = "a281caf0-2c7a-6cff-84e6-feede3500147",
				version = 2,
			},
		},
	},
	[55] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "4b5dbf32-54b0-b396-c3b8-b968748c56e2",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[56] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "d65691ab-6707-5eff-d633-070ddcc33e1b",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[57] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "687d2400-3eea-04d4-b100-6f5a7083cd70",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Glas 2 - Zone",
				uuid = "4ce63933-2479-7c85-94e5-443681260a06",
				version = 2,
			},
			inheritedObjectUUID = "92006654-e21f-6da6-9224-1b3a9f1a8913",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Reperer purification assignee",
								uuid = "9ebab507-0ad7-4333-8494-6bb2e5f635e1",
								version = 2.1,
							},
							inheritedObjectUUID = "57d07a54-e899-ffd4-9f9e-4c3f193f0525",
							inheritedOverwrites = 
							{
								actionLua = "-- Salvation 26CA: one cleanse in order per resolved cast.\nlocal state = data.ucob_doom_arrow_2\nstate.count = state.count + 1\nif state.count == state.order then\n    if eventArgs.castPosX ~= nil and eventArgs.castPosY ~= nil and eventArgs.castPosZ ~= nil then\n        state.position = {x = eventArgs.castPosX, y = eventArgs.castPosY, z = eventArgs.castPosZ}\n        local player = TensorCore.mGetPlayer()\n        local buff = TensorCore.getBuff(player, 210)\n        local remaining = math.floor(math.min(buff and buff.duration or 0, 290 - TensorReactions_CurrentTimer) * 1000)\n        if player.alive and player.hp.current > 0 and remaining > 0 then\n            -- Small destination marker; not the Salvation hitbox.\n            local drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 4)\n            drawer:setGradient(0.12, 0.4, 1.5)\n            state.destinationUUID = drawer:addTimedDonut(remaining, state.position.x, state.position.y, state.position.z, 0.55, 0.95, 0, false, true)\n        end\n    end\nend\nself.used = true",
							},
						},
					},
				},
			},
		},
		
		{
			data = 
			{
				name = "Glas 2 - Fleche",
				uuid = "34a3093c-178d-adbd-b7a5-0f9cb929498c",
				version = 2,
			},
			inheritedObjectUUID = "b41e7463-339a-ea8b-b98a-c151a92f2d81",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Actualiser fleche Glas",
								uuid = "9a58d50b-3873-8561-b26e-a79354960e7d",
								version = 2.1,
							},
							inheritedObjectUUID = "615fb0c5-1c73-12b3-a086-285e772dd666",
							inheritedOverwrites = 
							{
								actionLua = "local state = data.ucob_doom_arrow_2\nlocal player = TensorCore.mGetPlayer()\nif not player or not player.alive or player.hp.current <= 0 then\n    if state.uuid ~= nil then\n        Argus.deleteTimedShape(state.uuid)\n        state.uuid = nil\n    end\n    if state.destinationUUID ~= nil then\n        Argus.deleteTimedShape(state.destinationUUID)\n        state.destinationUUID = nil\n    end\n    state.position = nil\n    self.used = true\n    return\nend\n-- Direct bearing to the assigned cleanse zone; not a collision-free route.\nlocal position = player.pos\nlocal dx = state.position.x - position.x\nlocal dz = state.position.z - position.z\nlocal distance = math.sqrt(dx * dx + dz * dz)\nlocal drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\nif distance > 0.5 then\n    local heading = TensorCore.getHeadingToTarget(position, state.position)\n    local tipLength = math.min(1.1, distance * 0.4)\n    local length = distance - tipLength\n    local baseWidth = math.min(0.55, distance * 0.25)\n    local tipWidth = math.min(1.3, distance * 0.6)\n    drawer:setGradient(baseWidth * 0.5, 0.4, 1.5)\n    if state.uuid ~= nil then\n        local updated = drawer:updateTimedArrow(state.uuid, nil, position.x, position.y, position.z, heading, length, baseWidth, tipLength, tipWidth)\n        if not updated then state.uuid = nil end\n    end\n    if state.uuid == nil then\n        local buff = TensorCore.getBuff(player, 210)\n        local remaining = math.floor(math.min(buff and buff.duration or 0, 290 - TensorReactions_CurrentTimer) * 1000)\n        if remaining > 0 then\n            state.uuid = drawer:addTimedArrow(remaining, position.x, position.y, position.z, heading, length, baseWidth, tipLength, tipWidth)\n        end\n    end\nelseif state.uuid ~= nil then\n    Argus.deleteTimedShape(state.uuid)\n    state.uuid = nil\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
	},
	[59] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "5ed53826-0f91-6b22-d331-c4bc00142c56",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[60] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "16666faa-1638-d146-8269-417c4390e55a",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Feu personnel",
				uuid = "32af8cbd-08fc-6120-853f-495e8661e0f1",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local n = 3\nlocal f = data.ucob_guide_fire\nif not f then\n    f = {hits = {}, seen = {}}\n    data.ucob_guide_fire = f\nend\nlocal hits = f.hits[n]\nif not hits then hits = {}; f.hits[n] = hits end\nlocal targets = eventArgs.hitTargets\nif type(targets) == \"table\" then\n    for _, id in ipairs(targets) do\n        if type(id) == \"number\" and id > 0 then\n            hits[id] = true\n            f.seen[n] = true\n        end\n    end\nend\nf.resolved = f.resolved or {}\nf.resolved[n] = true\nif f.wave == n then\n    f.expires = 0\nend\nself.used = true",
							conditions = 
							{
								
								{
									"959aca84-7a81-603c-bdbe-9b1d3156f5c9",
									true,
								},
							},
							name = "Mémoriser les joueurs touchés",
							uuid = "fcc5265f-c9ad-b929-91d8-a8b6607645d0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 9925,
							name = "Feu 9925",
							uuid = "959aca84-7a81-603c-bdbe-9b1d3156f5c9",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Feu personnel",
				eventType = 2,
				loop = true,
				mechanicTime = 281.9,
				name = "P2 Feu 3 - Impacts confirmés",
				timeRange = true,
				timelineIndex = 60,
				timerEndOffset = 6,
				timerStartOffset = -6,
				uuid = "d1d43023-740d-7e41-8b11-32e2b86adcf2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local n = 3\nlocal now = Now()\nlocal f = data.ucob_guide_fire\nif not f then\n    f = {hits = {}, seen = {}}\n    data.ucob_guide_fire = f\nend\nif f.resolved and f.resolved[n] then\n    if f.wave == n then f.expires = 0 end\n    self.used = true\n    return\nend\nlocal player = TensorCore.mGetPlayer()\nif not player then self.used = true; return end\nlocal title, detail, decision\nif TensorCore.getBuff(player, 466) then\n    title = \"FOUDRE — RESTE ÉCARTÉ\"\n    detail = \"Feu \" .. n .. \" : attends la résolution de ta foudre.\"\n    decision = \"thunder\"\nelse\n    local known = true\n    for i = 1, n - 1 do\n        if not f.seen[i] then known = false; break end\n    end\n    if not known then\n        title = \"FEU \" .. n .. \" — HISTORIQUE INCOMPLET\"\n        detail = \"Participation non confirmée : vérifie tes buffs et le porteur.\"\n        decision = \"unknown\"\n    elseif n == 1 then\n        title = \"FEU 1 — PARTAGE LE FEU\"\n        detail = \"Rejoins le porteur pour le premier feu.\"\n        decision = \"in\"\n    elseif n == 2 then\n        if f.hits[1][player.id] then\n            title = \"FEU 2 — ÉVITE LE FEU\"\n            detail = \"Le porteur sort du groupe. Si c'est toi, reste à l'écart.\"\n            decision = \"out\"\n        else\n            title = \"FEU 2 — REJOINS LE PORTEUR\"\n            detail = \"Premier feu manqué : prends ce feu avec le porteur.\"\n            decision = \"catchup\"\n        end\n    elseif n == 3 then\n        if f.hits[1][player.id] and f.hits[2][player.id] then\n            title = \"FEU 3 — RESTE À L'ÉCART\"\n            detail = \"Tu as pris les feux 1 et 2 : évite le partage.\"\n            decision = \"out\"\n        else\n            title = \"FEU 3 — PARTAGE LE FEU\"\n            detail = \"Rejoins le porteur ; laisse les doubles porteurs à l'écart.\"\n            decision = \"in\"\n        end\n    else\n        if f.hits[1][player.id] and f.hits[2][player.id] and f.hits[3][player.id] then\n            title = \"FEU 4 — RESTE À L'ÉCART\"\n            detail = \"Tu as pris les trois feux : évite ce partage.\"\n            decision = \"out\"\n        else\n            title = \"FEU 4 — PARTAGE LE FEU\"\n            detail = \"Rejoins le porteur pour le dernier feu.\"\n            decision = \"in\"\n        end\n    end\nend\nf.wave = n\nf.title = title\nf.detail = detail\nf.expires = now + 450\nf.priority = 75\nf.key = \"p2_fire_\" .. n .. \"_\" .. decision\nself.used = true",
							name = "Actualiser la consigne de feu",
							uuid = "5c03c7f6-f9d0-fad8-8242-b573c510efb2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Feu personnel",
				loop = true,
				mechanicTime = 281.9,
				name = "P2 Feu 3 - Consigne personnelle",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 60,
				timerEndOffset = 3,
				timerStartOffset = -6,
				uuid = "d7079e89-660c-16ec-8677-f68afd15b873",
				version = 2,
			},
		},
	},
	[62] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "74202de9-294c-0e76-8dd7-afd158454c3f",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.put([==[tankPrep]==],[==[BAHAMUT'S CLAW — 5 COUPS]==],[==[Tanks : gardez votre mitigation pendant les cinq coups]==],nil,62,7000)\nself.used=true",
				executeType = 2,
				mechanicTime = 284.7,
				name = "P2 - BAHAMUT'S CLAW — 5 COUPS (284.7s)",
				timeRange = true,
				timelineIndex = 62,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "c6a8539f-5307-9816-a608-4075bc7ff631",
				version = 2,
			},
		},
	},
	[63] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "07ce49c3-72b3-05ef-e5ea-94b11f422eb3",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Feu personnel",
				uuid = "177eef9e-5a4d-8b25-bd9d-713968841e55",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local n = 4\nlocal f = data.ucob_guide_fire\nif not f then\n    f = {hits = {}, seen = {}}\n    data.ucob_guide_fire = f\nend\nlocal hits = f.hits[n]\nif not hits then hits = {}; f.hits[n] = hits end\nlocal targets = eventArgs.hitTargets\nif type(targets) == \"table\" then\n    for _, id in ipairs(targets) do\n        if type(id) == \"number\" and id > 0 then\n            hits[id] = true\n            f.seen[n] = true\n        end\n    end\nend\nf.resolved = f.resolved or {}\nf.resolved[n] = true\nif f.wave == n then\n    f.expires = 0\nend\nself.used = true",
							conditions = 
							{
								
								{
									"41722aba-2633-7ad0-b15f-55f9f70f19e6",
									true,
								},
							},
							name = "Mémoriser les joueurs touchés",
							uuid = "f8c8a70c-109d-6394-9243-aafdc28b661a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 9925,
							name = "Feu 9925",
							uuid = "41722aba-2633-7ad0-b15f-55f9f70f19e6",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Feu personnel",
				eventType = 2,
				loop = true,
				mechanicTime = 302.9,
				name = "P2 Feu 4 - Impacts confirmés",
				timeRange = true,
				timelineIndex = 63,
				timerEndOffset = 6,
				timerStartOffset = -6,
				uuid = "00186a71-8800-eaff-be88-b4c325c74558",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local n = 4\nlocal now = Now()\nlocal f = data.ucob_guide_fire\nif not f then\n    f = {hits = {}, seen = {}}\n    data.ucob_guide_fire = f\nend\nif f.resolved and f.resolved[n] then\n    if f.wave == n then f.expires = 0 end\n    self.used = true\n    return\nend\nlocal player = TensorCore.mGetPlayer()\nif not player then self.used = true; return end\nlocal title, detail, decision\nif TensorCore.getBuff(player, 466) then\n    title = \"FOUDRE — RESTE ÉCARTÉ\"\n    detail = \"Feu \" .. n .. \" : attends la résolution de ta foudre.\"\n    decision = \"thunder\"\nelse\n    local known = true\n    for i = 1, n - 1 do\n        if not f.seen[i] then known = false; break end\n    end\n    if not known then\n        title = \"FEU \" .. n .. \" — HISTORIQUE INCOMPLET\"\n        detail = \"Participation non confirmée : vérifie tes buffs et le porteur.\"\n        decision = \"unknown\"\n    elseif n == 1 then\n        title = \"FEU 1 — PARTAGE LE FEU\"\n        detail = \"Rejoins le porteur pour le premier feu.\"\n        decision = \"in\"\n    elseif n == 2 then\n        if f.hits[1][player.id] then\n            title = \"FEU 2 — ÉVITE LE FEU\"\n            detail = \"Le porteur sort du groupe. Si c'est toi, reste à l'écart.\"\n            decision = \"out\"\n        else\n            title = \"FEU 2 — REJOINS LE PORTEUR\"\n            detail = \"Premier feu manqué : prends ce feu avec le porteur.\"\n            decision = \"catchup\"\n        end\n    elseif n == 3 then\n        if f.hits[1][player.id] and f.hits[2][player.id] then\n            title = \"FEU 3 — RESTE À L'ÉCART\"\n            detail = \"Tu as pris les feux 1 et 2 : évite le partage.\"\n            decision = \"out\"\n        else\n            title = \"FEU 3 — PARTAGE LE FEU\"\n            detail = \"Rejoins le porteur ; laisse les doubles porteurs à l'écart.\"\n            decision = \"in\"\n        end\n    else\n        if f.hits[1][player.id] and f.hits[2][player.id] and f.hits[3][player.id] then\n            title = \"FEU 4 — RESTE À L'ÉCART\"\n            detail = \"Tu as pris les trois feux : évite ce partage.\"\n            decision = \"out\"\n        else\n            title = \"FEU 4 — PARTAGE LE FEU\"\n            detail = \"Rejoins le porteur pour le dernier feu.\"\n            decision = \"in\"\n        end\n    end\nend\nf.wave = n\nf.title = title\nf.detail = detail\nf.expires = now + 450\nf.priority = 75\nf.key = \"p2_fire_\" .. n .. \"_\" .. decision\nself.used = true",
							name = "Actualiser la consigne de feu",
							uuid = "e17baa0b-6f9d-1c46-8965-70174663b85f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Feu personnel",
				loop = true,
				mechanicTime = 302.9,
				name = "P2 Feu 4 - Consigne personnelle",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 63,
				timerEndOffset = 3,
				timerStartOffset = -6,
				uuid = "b6ad378d-f3f3-a8a2-8392-5a8eaf539843",
				version = 2,
			},
		},
	},
	[64] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "3ab56606-414c-8eea-bdd9-5b10746fd6b6",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Glas 3 - Zone",
				uuid = "b488c850-2ca1-f2bf-86b6-ef3416cc60fd",
				version = 2,
			},
			inheritedObjectUUID = "07592d84-37ff-762f-9675-b05d04f4e5d2",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Reperer purification assignee",
								uuid = "bc41c271-206e-3c95-b75b-33179f22bfd4",
								version = 2.1,
							},
							inheritedObjectUUID = "8de10986-eab7-f5b1-8b10-43752ee76ff2",
							inheritedOverwrites = 
							{
								actionLua = "-- Salvation 26CA: one cleanse in order per resolved cast.\nlocal state = data.ucob_doom_arrow_3\nstate.count = state.count + 1\nif state.count == state.order then\n    if eventArgs.castPosX ~= nil and eventArgs.castPosY ~= nil and eventArgs.castPosZ ~= nil then\n        state.position = {x = eventArgs.castPosX, y = eventArgs.castPosY, z = eventArgs.castPosZ}\n        local player = TensorCore.mGetPlayer()\n        local buff = TensorCore.getBuff(player, 210)\n        local remaining = math.floor(math.min(buff and buff.duration or 0, 325.9 - TensorReactions_CurrentTimer) * 1000)\n        if player.alive and player.hp.current > 0 and remaining > 0 then\n            -- Small destination marker; not the Salvation hitbox.\n            local drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 4)\n            drawer:setGradient(0.12, 0.4, 1.5)\n            state.destinationUUID = drawer:addTimedDonut(remaining, state.position.x, state.position.y, state.position.z, 0.55, 0.95, 0, false, true)\n        end\n    end\nend\nself.used = true",
							},
						},
					},
				},
			},
		},
		
		{
			data = 
			{
				name = "Glas 3 - Fleche",
				uuid = "fc5a997b-94c5-a841-878f-3b274dcf9c6f",
				version = 2,
			},
			inheritedObjectUUID = "1c413e7d-dd0e-6a21-9a39-818b8c445383",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Actualiser fleche Glas",
								uuid = "83dba461-94f1-da93-995f-a29450e9ddbd",
								version = 2.1,
							},
							inheritedObjectUUID = "ce221a47-a772-7560-81dc-bac5b968dfe6",
							inheritedOverwrites = 
							{
								actionLua = "local state = data.ucob_doom_arrow_3\nlocal player = TensorCore.mGetPlayer()\nif not player or not player.alive or player.hp.current <= 0 then\n    if state.uuid ~= nil then\n        Argus.deleteTimedShape(state.uuid)\n        state.uuid = nil\n    end\n    if state.destinationUUID ~= nil then\n        Argus.deleteTimedShape(state.destinationUUID)\n        state.destinationUUID = nil\n    end\n    state.position = nil\n    self.used = true\n    return\nend\n-- Direct bearing to the assigned cleanse zone; not a collision-free route.\nlocal position = player.pos\nlocal dx = state.position.x - position.x\nlocal dz = state.position.z - position.z\nlocal distance = math.sqrt(dx * dx + dz * dz)\nlocal drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\nif distance > 0.5 then\n    local heading = TensorCore.getHeadingToTarget(position, state.position)\n    local tipLength = math.min(1.1, distance * 0.4)\n    local length = distance - tipLength\n    local baseWidth = math.min(0.55, distance * 0.25)\n    local tipWidth = math.min(1.3, distance * 0.6)\n    drawer:setGradient(baseWidth * 0.5, 0.4, 1.5)\n    if state.uuid ~= nil then\n        local updated = drawer:updateTimedArrow(state.uuid, nil, position.x, position.y, position.z, heading, length, baseWidth, tipLength, tipWidth)\n        if not updated then state.uuid = nil end\n    end\n    if state.uuid == nil then\n        local buff = TensorCore.getBuff(player, 210)\n        local remaining = math.floor(math.min(buff and buff.duration or 0, 325.9 - TensorReactions_CurrentTimer) * 1000)\n        if remaining > 0 then\n            state.uuid = drawer:addTimedArrow(remaining, position.x, position.y, position.z, heading, length, baseWidth, tipLength, tipWidth)\n        end\n    end\nelseif state.uuid ~= nil then\n    Argus.deleteTimedShape(state.uuid)\n    state.uuid = nil\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
	},
	[65] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "0f131339-a7fe-445d-e6e7-fbbb98fa6129",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[67] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "aa80b5d8-0845-d5ef-8a47-73f6a34bf235",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.put([==[tankPrep]==],[==[RAVENSBEAK — TANKBUSTER]==],[==[Tanks : préparez la mitigation et l'échange prévus]==],nil,62,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 323.3,
				name = "P2 - RAVENSBEAK — TANKBUSTER (323.3s)",
				timeRange = true,
				timelineIndex = 67,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "93c03e60-b19c-8b37-b52a-0f11eede6ee4",
				version = 2,
			},
		},
	},
	[68] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "014c6312-93c8-372e-b0b2-9eb48f472ec2",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[69] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "1fedfd25-5ccb-be81-5e0b-79dfb719d7d5",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "P2 Divebomb - Placement Cactbot",
				uuid = "0eaa7609-6e0b-1830-b705-97c3ba007b6a",
				version = 2,
			},
			inheritedObjectUUID = "5967611d-66fc-111b-85d7-7b8c205af269",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Guider le placement Cactbot",
								uuid = "bae78eb6-af94-3ce9-9c46-c3107d832431",
								version = 2.1,
							},
							inheritedObjectUUID = "df039bf4-6f06-afcb-b1d8-656a0c2e5056",
							inheritedOverwrites = 
							{
								actionLua = "local s = data.ucob_p2_dive\nif not s then self.used = true return end\nlocal now = Now()\nif not s.initialized then\n    s.initialized = true\n    s.wanted = {[2630] = true, [2631] = true, [2632] = true, [6957] = true, [6958] = true}\n    s.dragons, s.contentSeen, s.directionSeen, s.wave = {}, {}, {}, {}\n    s.attempts, s.nextScan = 0, now\n    s.points = {{x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0}}\n    s.impactSeen, s.firstImpactCount = {}, 0\n    s.directions = {\"N\", \"NE\", \"E\", \"SE\", \"S\", \"SO\", \"O\", \"NO\"}\n    s.clear = function()\n        if s.ring then Argus.deleteTimedShape(s.ring) s.ring = nil end\n        if s.arrow then Argus.deleteTimedShape(s.arrow) s.arrow = nil end\n    end\n    s.collect = function(id)\n        local e = TensorCore.mGetEntity(id)\n        if e and s.wanted[e.contentid] then\n            local p = e.pos\n            local radius2 = p.x * p.x + p.z * p.z\n            local model = Argus.getEntityModel(e)\n            if model and model ~= 6358 and radius2 >= 484 and radius2 <= 676 then\n                local dir = math.floor(math.atan2(p.x, -p.z) / (math.pi / 4) + 8.5) % 8\n                if s.contentSeen[e.contentid] or s.directionSeen[dir] then\n                    s.invalid = true\n                else\n                    s.contentSeen[e.contentid], s.directionSeen[dir] = true, true\n                    s.dragons[#s.dragons + 1] = {id = id, dir = dir}\n                end\n            end\n        end\n        return true\n    end\n    s.sort = function(a, b) return a.dir < b.dir end\nend\nif not s.solved and s.canCollect and s.attempts < 3 and now >= s.nextScan and now < s.opened + 1100 then\n    s.attempts, s.nextScan = s.attempts + 1, now + 250\n    for k in pairs(s.contentSeen) do s.contentSeen[k] = nil end\n    for k in pairs(s.directionSeen) do s.directionSeen[k] = nil end\n    for k in pairs(s.dragons) do s.dragons[k] = nil end\n    s.invalid = false\n    TensorCore.forEachEntity(\"\", s.collect)\n    if not s.invalid and #s.dragons == 5 then\n        table.sort(s.dragons, s.sort)\n        -- Cactbot findDragonMarks: N=0, clockwise, five distinct dragons.\n        local d0, d1, d2, d3, d4 = s.dragons[1].dir, s.dragons[2].dir, s.dragons[3].dir, s.dragons[4].dir, s.dragons[5].dir\n        local m1 = d0 + 1 == d1 and (d0 + 7) % 8 or math.floor((d0 + d1) / 2)\n        local m2 = d1 == d2 - 1 and d2 + 1 or d2 - 1\n        local m3\n        s.wideThird = false\n        if d3 + 1 == d4 then\n            m3 = (d4 + 1) % 8\n            local gap = m2 == d2 - 1 and 2 or 4\n            if d3 >= d2 + gap then m3 = d3 - 1 end\n        else\n            m3 = math.ceil((d3 + d4) / 2)\n            if m2 == d3 and m3 == m2 + 1 then\n                m3 = (d4 + 1) % 8\n                s.wideThird = true\n            end\n        end\n        s.marks = {m1, m2, m3}\n        for i = 1, 3 do\n            local angle = s.marks[i] * math.pi / 4\n            s.points[i].x, s.points[i].z = 20 * math.sin(angle), -20 * math.cos(angle)\n        end\n        for i = 1, 5 do s.wave[s.dragons[i].id] = i <= 2 and 1 or i == 3 and 2 or 3 end\n        s.solved = true\n    end\nend\nif not s.number then self.used = true return end\nlocal p = TensorCore.mGetPlayer()\nif not p or not p.alive or p.hp.current <= 0 then\n    s.stopped = true\nend\nif s.stopped or now >= s.expires then\n    s.clear()\n    s.hudVisible = false\n    self.used = true\n    return\nend\nif s.locks[s.number] then\n    s.clear()\n    s.hudVisible = now < s.locks[s.number] + 1200\n    s.hudStatus = \"Placement verrouillé : quitte le point\"\n    self.used = true\n    return\nend\ns.hudVisible = true\nif not s.solved then\n    s.hudStatus = \"Dragons non identifiés : suis ta stratégie\"\n    self.used = true\n    return\nend\nif s.titleNumber ~= s.number then\n    s.titleNumber = s.number\n    s.hudTitle = \"DIVEBOMB \" .. s.number .. \" | \" .. s.directions[s.marks[s.number] + 1]\n    s.hudNote = s.number == 3 and s.wideThird and \"Plongeon large : attention au centre\" or nil\nend\nlocal target = s.points[s.number]\nlocal remaining = math.floor(math.min(s.expires - now, (349 - TensorReactions_CurrentTimer) * 1000))\nif remaining <= 0 then\n    s.clear()\n    s.hudVisible = false\n    self.used = true\n    return\nend\nif not s.drawer then\n    s.drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\n    s.drawer:setGradient(0.25, 0.4, 1.5)\n    target.y = p.pos.y\nend\nlocal threshold = s.number == 1 and 1 or s.number == 2 and 3 or 4\nlocal ready = (s.number ~= 3 or s.firstWaveDone) and s.novas >= threshold\nlocal ringDrawer = TensorCore.getCachedDrawer(ready and 0xFFFFF060 or 0xFF40BFFF, nil, ready and 0xFFFFF060 or 0xFF40BFFF, 4279504646, 4)\nif s.ring and not ringDrawer:updateTimedDonut(s.ring, nil, target.x, target.y, target.z, 0.5, 0.95, 0, false, true) then s.ring = nil end\nif not s.ring then s.ring = ringDrawer:addTimedDonut(remaining, target.x, target.y, target.z, 0.5, 0.95, 0, false, true) end\nif s.number == 3 and not s.firstWaveDone then\n    s.hudStatus = \"Destination indiquée : attends le passage des deux premiers dragons\"\n    self.used = true\n    return\nend\nlocal threshold = s.number == 1 and 1 or s.number == 2 and 3 or 4\nif s.novas < threshold then\n    s.hudStatus = s.waitText\n    self.used = true\n    return\nend\nlocal dx, dz = target.x - p.pos.x, target.z - p.pos.z\nlocal distance = math.sqrt(dx * dx + dz * dz)\nif distance <= 0.30 then\n    s.arrived = true\nelseif distance >= 0.45 then\n    s.arrived = false\nend\nif not s.hudNextUpdate or now >= s.hudNextUpdate then\n    s.hudNextUpdate = now + 100\n    s.hudStatus = s.arrived and \"Bien placé : attends le verrouillage\" or string.format(\"Rejoins le centre du repère | %.1f m\", distance)\nend\nif s.arrived then\n    if s.arrow then Argus.deleteTimedShape(s.arrow) s.arrow = nil end\nelse\n    local tip = math.min(1.1, distance * 0.45)\n    local base = math.max(0.05, distance - tip)\n    local width = math.min(0.55, distance * 0.3)\n    local tipWidth = math.min(1.3, distance * 0.70)\n    local heading = TensorCore.getHeadingToTarget(p.pos, target)\n    if s.arrow and not s.drawer:updateTimedArrow(s.arrow, nil, p.pos.x, p.pos.y, p.pos.z, heading, base, width, tip, tipWidth, 0, false) then s.arrow = nil end\n    if not s.arrow then s.arrow = s.drawer:addTimedArrow(remaining, p.pos.x, p.pos.y, p.pos.z, heading, base, width, tip, tipWidth, 0, false) end\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
		
		{
			data = 
			{
				name = "P2 Divebomb - Numéro et consigne",
				uuid = "ac58dac5-49c2-d2da-bbe6-1e27b555a62b",
				version = 2,
			},
			inheritedObjectUUID = "755f2cda-2a9f-bd8e-89a6-6af99493cab7",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Afficher le suivi divebomb",
								uuid = "86f6c595-e1c1-bed8-8975-8fc4a1f0670e",
								version = 2.1,
							},
							inheritedObjectUUID = "2da4760f-d46b-7c73-af58-49e0fbd4a2f8",
							inheritedOverwrites = 
							{
								actionLua = "if data.ucob_guide then self.used = true return end\nlocal s = data.ucob_p2_dive\nif s and s.hudVisible and s.hudTitle and s.hudStatus then\n    s.hudFlags = GUI.WindowFlags_NoResize + GUI.WindowFlags_NoCollapse + GUI.WindowFlags_AlwaysAutoResize + GUI.WindowFlags_NoFocusOnAppearing\n    local width, height = GUI:GetScreenSize()\n    GUI:SetNextWindowPos(width * 0.5, height * 0.25, GUI.SetCond_FirstUseEver, 0.5, 0)\n    local visible = GUI:Begin(\"Divebomb##ucob_p2_dive\", true, s.hudFlags)\n    if visible then\n        GUI:SetWindowFontScale(1.15)\n        GUI:TextColored(0.25, 0.9, 1, 1, s.hudTitle)\n        GUI:TextUnformatted(s.hudStatus)\n        if s.hudNote then GUI:TextColored(1, 0.75, 0.25, 1, s.hudNote) end\n    end\n    GUI:End()\nend\nself.used = true",
							},
						},
					},
				},
			},
		},
	},
	[70] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "9752d833-d0ad-7ddf-c0d0-242d46a271a3",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[71] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "ce59d8e8-2354-a2b4-2a44-557a427b1098",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[73] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "bba18eda-59dc-9676-78a3-af88004f0f8a",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[77] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "ec808036-d3c7-1a1a-16a4-9c14627c47e6",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "ede68008-7035-826b-9bc1-78bb06614093",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.put([==[tankPrep]==],[==[BAHAMUT'S CLAW — 5 COUPS]==],[==[Tanks : gardez votre mitigation pendant les cinq coups]==],nil,62,7000)\nself.used=true",
				executeType = 2,
				mechanicTime = 349.7,
				name = "P2 - BAHAMUT'S CLAW — 5 COUPS (349.7s)",
				timeRange = true,
				timelineIndex = 77,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "fee10914-992a-cb58-8591-478933e7566f",
				version = 2,
			},
		},
	},
	[80] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "ff5b3e06-b202-93cb-ade6-beed601a9e66",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.put([==[tankPrep]==],[==[RAVENSBEAK — TANKBUSTER]==],[==[Tanks : préparez la mitigation et l'échange prévus]==],nil,62,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 388.7,
				name = "P2 - RAVENSBEAK — TANKBUSTER (388.7s)",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "cca1f278-d8ba-2a39-8ddb-ff910889d5b7",
				version = 2,
			},
		},
	},
	[81] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P2",
				uuid = "dc0ebbb3-fc61-9776-9b5e-59c678ea4075",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P2",
				execute = "local s=data.ucob_guide\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.put([==[tankPrep]==],[==[BAHAMUT'S CLAW — 5 COUPS]==],[==[Tanks : gardez votre mitigation pendant les cinq coups]==],nil,62,7000)\nself.used=true",
				executeType = 2,
				mechanicTime = 395.7,
				name = "P2 - BAHAMUT'S CLAW — 5 COUPS (395.7s)",
				timeRange = true,
				timelineIndex = 81,
				timerEndOffset = 5,
				timerStartOffset = -2,
				uuid = "6abb7ff0-236c-9fca-8a9c-e55d85cf91f2",
				version = 2,
			},
		},
	},
	[82] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "f390756e-b35e-a3b2-bad2-f9a8f613c2de",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[84] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "b36c7060-50d0-fcac-9ad9-a5f6cc3e0cd0",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "ff204fca-e5c9-7eb4-86c8-ced9842daef5",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=3\ns.put([==[recul]==],[==[TRANSITION — PRÉPARE LE RECUL]==],[==[Regroupe-toi selon le placement de transition]==],[==[Dégâts de groupe successifs]==],60,6000)\nself.used=true",
				executeType = 2,
				mechanicTime = 500,
				name = "P3 - TRANSITION — PRÉPARE LE RECUL (500s)",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = 2,
				timerStartOffset = -4,
				uuid = "75f7fcf3-9ee2-8d6c-9c55-02f81610f9ed",
				version = 2,
			},
		},
	},
	[85] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "23c4578b-4ec4-6c97-734b-48699085b47b",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "888325db-c526-00da-a514-15ea65c1a84c",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=3\ns.put([==[raidPrep]==],[==[DÉGÂTS DE GROUPE — 3 VAGUES]==],[==[Reste avec le groupe ; soins et mitigations prévus]==],[==[Calamitous Blaze]==],40,7000)\nself.used=true",
				executeType = 2,
				mechanicTime = 503,
				name = "P3 - DÉGÂTS DE GROUPE — 3 VAGUES (503s)",
				timeRange = true,
				timelineIndex = 85,
				timerEndOffset = 6,
				timerStartOffset = -1,
				uuid = "9559f515-efa3-4f99-9a25-1da794711cce",
				version = 2,
			},
		},
	},
	[86] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "11a7507e-79d3-264b-a0c1-1a86427f27b2",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=3\ns.put([==[raidPrep]==],[==[CALAMITOUS BLAZE]==],[==[Reste regroupé pour la transition]==],nil,45,3000)\nself.used=true",
				executeType = 2,
				mechanicTime = 508,
				name = "P3 - CALAMITOUS BLAZE (508s)",
				timeRange = true,
				timelineIndex = 86,
				timerEndOffset = 1,
				timerStartOffset = -2,
				uuid = "45caa567-a24a-c710-b653-05ca7989f4e5",
				version = 2,
			},
		},
	},
	[87] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "6c4ee9a5-8b61-ae61-11aa-8d5f037ac455",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[88] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "7912fb04-6d55-d958-cecb-e20252961074",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Flare Breath",
				uuid = "9deedaa6-99ef-dfdd-9b17-e8809434460f",
				version = 2,
			},
			inheritedObjectUUID = "e96b8ee0-2a83-37cc-b2ee-95334cb12487",
			inheritedOverwrites = 
			{
				displayPath = "store\\anyone\\ucob\\universal",
				enabled = false,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Visuels P3",
				uuid = "7c1d4bd3-3162-c8b9-96c8-98459134cfac",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local id = eventArgs.spellID\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nif id == 9951 then\n    local t = s.towers[eventArgs.entityID]\n    if t and t.uuid then Argus.deleteTimedShape(t.uuid) end\n    s.towers[eventArgs.entityID] = nil\nelse\n    s.bossID = eventArgs.entityID\n    if id == 9940 and s.flareUUID then\n        s.flareRemaining = (s.flareRemaining or 1) - 1\n        if s.flareRemaining <= 0 then\n            Argus.deleteTimedShape(s.flareUUID)\n            s.flareUUID = nil\n            s.flareExpires = nil\n        end\n    elseif id >= 9954 and id <= 9959 then\n        if s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\n        s.flareUUID = nil\n        s.flareExpires = nil\n        s.flareRemaining = nil\n        for source, t in pairs(s.towers) do\n            if t.uuid then Argus.deleteTimedShape(t.uuid) end\n            s.towers[source] = nil\n        end\n    end\nend\nself.used = true",
							conditions = 
							{
								
								{
									"62e51979-00ec-6f24-bee9-49720e2f2c20",
									true,
								},
							},
							name = "Dessins stables et resolution",
							uuid = "2b3b93ac-7f5c-aeef-93be-314146dcdbb8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Casts des dessins P3",
							spellIDList = 
							{
								9936,
								9940,
								9941,
								9942,
								9951,
								9954,
								9955,
								9956,
								9957,
								9958,
								9959,
							},
							uuid = "62e51979-00ec-6f24-bee9-49720e2f2c20",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Visuels P3",
				eventType = 2,
				execute = "local id = eventArgs.spellID\nif id ~= 9936 and id ~= 9940 and id ~= 9941 and id ~= 9942 and id ~= 9951 and (id < 9954 or id > 9959) then self.used = true return end\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nif id == 9951 then\n    local t = s.towers[eventArgs.entityID]\n    if t and t.uuid then Argus.deleteTimedShape(t.uuid) end\n    s.towers[eventArgs.entityID] = nil\nelse\n    s.bossID = eventArgs.entityID\n    if id == 9940 and s.flareUUID then\n        s.flareRemaining = (s.flareRemaining or 1) - 1\n        if s.flareRemaining <= 0 then\n            Argus.deleteTimedShape(s.flareUUID)\n            s.flareUUID = nil\n            s.flareExpires = nil\n        end\n    elseif id >= 9954 and id <= 9959 then\n        if s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\n        s.flareUUID = nil\n        s.flareExpires = nil\n        s.flareRemaining = nil\n        for source, t in pairs(s.towers) do\n            if t.uuid then Argus.deleteTimedShape(t.uuid) end\n            s.towers[source] = nil\n        end\n    end\nend\nself.used = true",
				loop = true,
				mechanicTime = 517,
				name = "P3 - Sources et resolution des dessins",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 326.3,
				timerStartOffset = -37,
				uuid = "becaa8da-82e8-69cc-9a8a-f22eb128568d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				eventType = 9,
				execute = "local old = eventArgs.oldData\nlocal s = old and old.ucobP3DrawFix\nif s then\n    if s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\n    if s.towers then\n        for _, t in pairs(s.towers) do\n            if t.uuid then Argus.deleteTimedShape(t.uuid) end\n        end\n    end\nend\nlocal towers = old and old.ucob_tower_visual\nif towers and towers.arrow then Argus.deleteTimedShape(towers.arrow) end\nif towers and towers.goalUUID then Argus.deleteTimedShape(towers.goalUUID) end\nif towers and towers.beaconUUID then Argus.deleteTimedShape(towers.beaconUUID) end\nlocal route = old and old.ucob_path_preview\nif route and route.goalUUID then Argus.deleteTimedShape(route.goalUUID) end\nlocal extra = old and old.ucob_p3_stack_visual\nif extra then\n    for _, key in ipairs({\"mega\",\"fire\",\"goal\",\"arrow\"}) do\n        if extra[key] then Argus.deleteTimedShape(extra[key]) end\n    end\nend\nself.used = true",
				executeType = 2,
				mechanicTime = 517,
				name = "P3 - Nettoyage des dessins au wipe",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 326.4,
				timerStartOffset = -517,
				uuid = "8037f09c-dfb2-b266-aa48-649562e3166a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				execute = "-- Direction cue only: this arrow is NOT the exact cone boundary.\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nif not s.bossID then return end\nlocal boss = TensorCore.mGetEntity(s.bossID)\nif not boss then return end\nif s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\nlocal drawer = TensorCore.getCachedDrawer(4283453695, nil, 4283453695, 4279504646, 3)\ns.flareUUID = drawer:addTimedArrowOnEnt(3000, boss.id, 8, 0.65, 2, 2.2)\ns.flareRemaining = 1\ns.flareExpires = Now() + 3000\nself.used = true",
				executeType = 2,
				mechanicTime = 517,
				name = "P3 - Sens du souffle 517",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 0.5,
				timerStartOffset = -2.5,
				uuid = "a1173bfd-f87c-6080-9dc9-1689ba39a516",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				eventType = 12,
				execute = "-- Personal P3 stack ranges and Heavensfall center rendezvous.\nlocal now,g,p=Now(),data.ucob_guide,TensorCore.mGetPlayer()\nlocal v=data.ucob_p3_stack_visual\nif not v then\n    v={point={x=0,y=0,z=0}}\n    data.ucob_p3_stack_visual=v\n    function v.remove(s,key)\n        if s[key] then Argus.deleteTimedShape(s[key]);s[key]=nil end\n    end\n    function v.clear(s)\n        s.remove(s,\"mega\");s.remove(s,\"fire\");s.remove(s,\"goal\");s.remove(s,\"arrow\")\n        s.kind,s.arrived=nil,nil\n    end\nend\nif v.trio~=(g and g.trio) then v.clear(v);v.trio=g and g.trio;v.dead=false end\nif not p or not p.alive or p.hp.current<=0 then v.dead=true end\nif not g or g.phase~=3 or not p or v.dead then v.clear(v);self.used=true;return end\nlocal waiting=data.ucob_twister_until and now<data.ucob_twister_until\nlocal fill=waiting and 0x10AAAAAA or 0x18FFF060\nlocal outline=waiting and 0xFFAAAAAA or 0xFFFFF060\nlocal ring=TensorCore.getCachedDrawer(fill,nil,fill,outline,4)\nif g.personalMegaUntil and g.personalMegaUntil>now then\n    if v.mega and not ring:updateTimedCircleOnEnt(v.mega,nil,p.id,5,0,false,true) then v.mega=nil end\n    if not v.mega then v.mega=ring:addTimedCircleOnEnt(g.personalMegaUntil-now,p.id,5,0,false,true) end\nelse v.remove(v,\"mega\") end\nlocal f=data.ucob_fireball_guide\nlocal kind,expires\nlocal target=g.trio==9957 and f and f.expires>now and now<f.started+5300 and TensorCore.mGetEntity(f.target)\nif target and target.alive and target.hp.current>0 then\n    expires=math.min(f.expires,f.started+5300)\n    kind=\"fireball\"\n    if v.fire and not ring:updateTimedCircleOnEnt(v.fire,nil,target.id,4,0,false,true) then v.fire=nil end\n    if not v.fire then v.fire=ring:addTimedCircleOnEnt(expires-now,target.id,4,0,false,true) end\nelse\n    v.remove(v,\"fire\")\n    if g.trio==9957 and g.hfBaitUntil and g.hfBaitUntil>now then kind,expires=\"bait\",g.hfBaitUntil end\nend\nif not kind or waiting then\n    v.remove(v,\"goal\");v.remove(v,\"arrow\");v.kind,v.arrived=nil,nil\n    self.used=true;return\nend\nif kind~=v.kind then v.arrived=nil;v.kind=kind end\nlocal drawer=TensorCore.getCachedDrawer(0xFFFFF060,nil,0xFFFFF060,4279504646,4)\nif v.goal and not drawer:updateTimedDonut(v.goal,nil,0,0,0,1.65,2,0,false,true) then v.goal=nil end\nif not v.goal then v.goal=drawer:addTimedDonut(expires-now,0,0,0,1.65,2,0,false,true) end\nlocal distance=math.sqrt(p.pos.x*p.pos.x+p.pos.z*p.pos.z)\nif distance<=1.3 then v.arrived=true elseif distance>=1.7 then v.arrived=false end\nif v.arrived then v.remove(v,\"arrow\");self.used=true;return end\nlocal heading=TensorCore.getHeadingToTarget(p.pos,v.point)\nlocal tip=math.min(1.1,distance*0.4)\nlocal arrow=TensorCore.getCachedDrawer(4294963296,nil,4294963296,4279504646,3)\nif v.arrow and not arrow:updateTimedArrowOnEnt(v.arrow,nil,p.id,distance-tip,0.55,tip,1.3,nil,0,false,heading,true) then v.arrow=nil end\nif not v.arrow then v.arrow=arrow:addTimedArrowOnEnt(expires-now,p.id,distance-tip,0.55,tip,1.3,nil,0,false,heading,true) end\nself.used=true",
				executeType = 2,
				loop = true,
				mechanicTime = 517,
				name = "P3 - Partages et regroupements au sol",
				throttleTime = 16,
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 326.3,
				timerStartOffset = -20,
				uuid = "8575ffdb-b310-2b6f-b409-1198233d684d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				eventType = 22,
				execute = "-- Capture the trio reference even while Nael cannot be targeted.\nlocal g=data.ucob_guide\nif eventArgs.entityContentID~=2612 or not eventArgs.isVisible or not g\n    or (g.trio~=9955 and g.trio~=9957) then self.used=true;return end\nlocal observed=data.ucob_tower_nael\nif not observed or observed.trio~=g.trio then\n    observed={trio=g.trio}\n    data.ucob_tower_nael=observed\nend\nobserved.id=eventArgs.entityID\nlocal nael=TensorCore.mGetEntity(eventArgs.entityID)\nif nael and nael.pos.x*nael.pos.x+nael.pos.z*nael.pos.z>=400 then\n    observed.angle=math.atan2(nael.pos.x,-nael.pos.z)\nend\nself.used=true",
				executeType = 2,
				loop = true,
				mechanicTime = 517,
				name = "P3 - Reference Nael hors ciblage",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 184.4,
				timerStartOffset = -20,
				uuid = "ff81de54-3854-e54b-bb89-aea64af6943d",
				version = 2,
			},
		},
	},
	[89] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "0d3bd22f-60f2-5163-19fa-b51576cc359f",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "92a5a507-f2f6-2117-8f0d-2e51a1a0cc1d",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.phase=3\ns.put([==[tankPrep]==],[==[FLATTEN — TANKBUSTER]==],[==[Tanks : préparez votre mitigation]==],nil,65,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 525,
				name = "P3 - FLATTEN — TANKBUSTER (525s)",
				timeRange = true,
				timelineIndex = 89,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "aa63a74d-3a11-c1fe-9231-1f1f0dcbfc25",
				version = 2,
			},
		},
	},
	[91] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "dcc27a0a-0d31-907e-ae52-e8d8b9d4ff3a",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[92] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "2315dc23-d2cb-d447-d778-fc3da99d5613",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[93] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "30aff5b2-3121-2977-bff6-2414373849e7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9954 then self.used=true return end\ns.phase=3\ns.put([==[spreadPrep]==],[==[SPREAD — ÉCARTEZ-VOUS]==],[==[Garde ton espace après le passage des dives]==],[==[Ensuite : zones au sol puis partage]==],75,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 544,
				name = "P3 - SPREAD — ÉCARTEZ-VOUS (544s)",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "a7030b5b-9bab-5e73-b0db-8b3ee6213256",
				version = 2,
			},
		},
	},
	[94] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "352f2519-1474-1475-c179-30cfa34b7b09",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[95] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "90281236-97eb-f470-a10c-022bcdecebe2",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9954 then self.used=true return end\ns.phase=3\ns.put([==[groundPrep]==],[==[DÉPOSE LES ZONES — PUIS BOUGE]==],[==[Libère les emplacements au sol]==],[==[Ensuite : STACK]==],77,1300)\nself.used=true",
				executeType = 2,
				mechanicTime = 546,
				name = "P3 - DÉPOSE LES ZONES — PUIS BOUGE (546s)",
				timeRange = true,
				timelineIndex = 95,
				timerEndOffset = 0.3,
				timerStartOffset = -1,
				uuid = "71f94a88-1bb0-de36-bb1d-09f722aef2b3",
				version = 2,
			},
		},
	},
	[96] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "e271e1b9-6991-4f00-bc96-18c726b3c1ac",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9954 then self.used=true return end\ns.phase=3\ns.put([==[stackPrep]==],[==[STACK — REGROUPEMENT]==],[==[Rejoins le partage après avoir quitté les zones au sol]==],[==[Earthshakers ensuite]==],78,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 548,
				name = "P3 - STACK — REGROUPEMENT (548s)",
				timeRange = true,
				timelineIndex = 96,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "0710c4a2-1f15-a75d-874b-ce502810e1e6",
				version = 2,
			},
		},
	},
	[97] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "24cc5064-5095-5b70-07d3-2c265ed876d4",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[98] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "3b2f3385-56f5-b0c9-7f54-85ab7c4961b5",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "95086487-0103-871b-8eb5-7671921e935c",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9954 then self.used=true return end\ns.phase=3\ns.put([==[tetherPrep]==],[==[TEMPEST WING — LIENS TANKS]==],[==[Tanks : prenez vos liens ; restez à l'écart du groupe]==],nil,65,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 552,
				name = "P3 - TEMPEST WING — LIENS TANKS (552s)",
				timeRange = true,
				timelineIndex = 98,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "2e210db2-826d-74c8-9a6f-6e66371fbc78",
				version = 2,
			},
		},
	},
	[99] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "80850772-e025-ba56-117b-18002f7fdd22",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Flare Breath",
				uuid = "afc5407e-9288-6a0a-909e-6a50ccc46066",
				version = 2,
			},
			inheritedObjectUUID = "69f8189c-fb29-296c-a1f1-c56a5fa5721d",
			inheritedOverwrites = 
			{
				displayPath = "store\\anyone\\ucob\\universal",
				enabled = false,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Visuels P3",
				uuid = "2573cb9e-3f9e-ff9a-b1e9-ac3955760375",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				execute = "-- Direction cue only: this arrow is NOT the exact cone boundary.\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nif not s.bossID then return end\nlocal boss = TensorCore.mGetEntity(s.bossID)\nif not boss then return end\nif s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\nlocal drawer = TensorCore.getCachedDrawer(4283453695, nil, 4283453695, 4279504646, 3)\ns.flareUUID = drawer:addTimedArrowOnEnt(3000, boss.id, 8, 0.65, 2, 2.2)\ns.flareRemaining = 1\ns.flareExpires = Now() + 3000\nself.used = true",
				executeType = 2,
				mechanicTime = 555.9,
				name = "P3 - Sens du souffle 555.9",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 0.5,
				timerStartOffset = -2.5,
				uuid = "d63cfcc3-3d17-ff55-a151-103927c77b97",
				version = 2,
			},
		},
	},
	[100] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "c65c1e51-bf12-3d3d-8482-9b93063fe6c1",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "fbd439a7-98f9-974e-b1e6-0897d5d8bd6d",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.phase=3\ns.put([==[tankPrep]==],[==[FLATTEN — TANKBUSTER]==],[==[Tanks : préparez votre mitigation]==],nil,65,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 563.9,
				name = "P3 - FLATTEN — TANKBUSTER (563.9s)",
				timeRange = true,
				timelineIndex = 100,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "9fc4b9bb-1716-a9ab-bdde-2fdf9b020854",
				version = 2,
			},
		},
	},
	[102] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "8fced507-8988-a1e3-c2f3-326dcaf782f7",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[103] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "cdf3151c-95ec-29d8-94ba-44ba0179170c",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "b70d463d-09cd-e49f-9fe4-510bfea14cb3",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9955 then self.used=true return end\ns.phase=3\ns.put([==[baitPrep]==],[==[LIQUID HELL — BAIT EN GROUPE]==],[==[Suis le déplacement de bait prévu ; ne coupe pas le groupe]==],[==[STACK sur Nael ensuite]==],55,6000)\nself.used=true",
				executeType = 2,
				mechanicTime = 576,
				name = "P3 - LIQUID HELL — BAIT EN GROUPE (576s)",
				timeRange = true,
				timelineIndex = 103,
				timerEndOffset = 4,
				timerStartOffset = -2,
				uuid = "55b73e77-bf3c-2533-b46f-8788fda670e5",
				version = 2,
			},
		},
	},
	[104] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "0d796e35-354e-b9d9-61db-167f811774a5",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "c7a84485-1dba-fb07-af90-ac45fef458af",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9955 then self.used=true return end\ns.phase=3\ns.put([==[stackPrep]==],[==[STACK — RAYON THERMOÏONIQUE]==],[==[Rejoins le partage sur Nael]==],[==[Évite le dive suivant]==],80,2300)\nself.used=true",
				executeType = 2,
				mechanicTime = 579,
				name = "P3 - STACK — RAYON THERMOÏONIQUE (579s)",
				timeRange = true,
				timelineIndex = 104,
				timerEndOffset = 0.3,
				timerStartOffset = -2,
				uuid = "13cacbfa-11a6-d9fd-a181-6d3f45810f6d",
				version = 2,
			},
		},
	},
	[106] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "9ee762db-a912-71cf-7e30-c089388ce28b",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "0f97595b-d19e-8fdf-8bb6-76d7bd98d6a4",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9955 then self.used=true return end\ns.phase=3\ns.put([==[hyperPrep]==],[==[HYPERNOVAS — DÉPOSE PUIS BOUGE]==],[==[Suis le bait ; garde les flaques hors du partage]==],[==[Ensuite : partage / tours]==],70,6500)\nself.used=true",
				executeType = 2,
				mechanicTime = 586.1,
				name = "P3 - HYPERNOVAS — DÉPOSE PUIS BOUGE (586.1s)",
				timeRange = true,
				timelineIndex = 106,
				timerEndOffset = 4.5,
				timerStartOffset = -2,
				uuid = "3442f5dd-a54a-deaa-9ea9-dbafaff0f9e0",
				version = 2,
			},
		},
	},
	[107] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "4a745405-7e34-f687-b09a-398dd18c95ec",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9955 then self.used=true return end\nif s.stackCount ~= 4 then self.used=true return end\nif not s.mineStack then self.used=true return end\ns.phase=3\ns.put([==[stackPrep]==],[==[BLACKFIRE — RÉSOLUTION DU PARTAGE]==],[==[Termine le bait avant de rejoindre ton affectation]==],nil,79,1500)\nself.used=true",
				executeType = 2,
				mechanicTime = 588,
				name = "P3 - BLACKFIRE — RÉSOLUTION DU PARTAGE (588s)",
				timeRange = true,
				timelineIndex = 107,
				timerEndOffset = 0.3,
				timerStartOffset = -1.2,
				uuid = "24a72120-2b39-df65-9808-9e9c70f282d0",
				version = 2,
			},
		},
	},
	[108] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "347b8789-6227-4d45-e89c-9bdb703c8ab9",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "83be7140-c546-d33a-889d-14f5edf7977e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9955 then self.used=true return end\nif s.stackCount ~= 4 or s.mineStack then self.used=true return end\ns.phase=3\ns.put([==[towerPrep]==],[==[BLACKFIRE — TOURS]==],[==[Entre dans ta tour attribuée après le partage]==],nil,79,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 590,
				name = "P3 - BLACKFIRE — TOURS (590s)",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "ff98324f-cb44-0fb0-8d7c-d5c12ac73328",
				version = 2,
			},
		},
	},
	[109] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "05cf3216-dbf4-f432-4c8c-f2309bdedd86",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[110] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "03945040-c5c6-2bcc-3f97-160a61bfc2f0",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "617b3d0d-6bc0-ff64-9e3f-565a9fea20fd",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=3\ns.put([==[raidPrep]==],[==[GIGAFLARE — DÉGÂTS DE GROUPE]==],[==[Prépare les soins et mitigations prévus]==],nil,40,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 596,
				name = "P3 - GIGAFLARE — DÉGÂTS DE GROUPE (596s)",
				timeRange = true,
				timelineIndex = 110,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "7b922332-4210-7af2-b17f-f0979cec5796",
				version = 2,
			},
		},
	},
	[113] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "544e9685-6d60-3a81-85ea-7823259e7bf5",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Flare Breath",
				uuid = "39200c30-45ad-065d-b95a-751e6d259141",
				version = 2,
			},
			inheritedObjectUUID = "d68ae422-6216-396b-8246-416424a43dda",
			inheritedOverwrites = 
			{
				displayPath = "store\\anyone\\ucob\\universal",
				enabled = false,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Visuels P3",
				uuid = "f574e38c-7cbe-b2d4-8465-7872821628dc",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				execute = "-- Direction cue only: this arrow is NOT the exact cone boundary.\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nif not s.bossID then return end\nlocal boss = TensorCore.mGetEntity(s.bossID)\nif not boss then return end\nif s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\nlocal drawer = TensorCore.getCachedDrawer(4283453695, nil, 4283453695, 4279504646, 3)\ns.flareUUID = drawer:addTimedArrowOnEnt(7000, boss.id, 8, 0.65, 2, 2.2)\ns.flareRemaining = 3\ns.flareExpires = Now() + 7000\nself.used = true",
				executeType = 2,
				mechanicTime = 609,
				name = "P3 - Sens du souffle 609",
				timeRange = true,
				timelineIndex = 113,
				timerEndOffset = 0.5,
				timerStartOffset = -6.5,
				uuid = "e47fc121-57b7-afb0-b0d2-3025794d177e",
				version = 2,
			},
		},
	},
	[115] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "3a63ce57-9106-8e4b-9803-c119e3f63bc7",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[116] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "9156874e-cdc0-1352-87a0-ec641e5bf7fe",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Quotes",
				uuid = "ff2fc658-accf-826f-9914-49329f733fca",
				version = 2,
			},
			inheritedObjectUUID = "b4e2b7f4-32dc-e84d-9e23-be87fc62b78f",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"IN puis SPREAD\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"IN puis SPREAD\", 1, 2, true, 100)\nend\nself.used = true",
								alertPriority = 2,
								alertScale = 1,
								alertTTS = true,
								alertText = "IN puis SPREAD",
								alertVolume = 100,
								conditions = 
								{
									
									{
										"ebd54194-c501-bc57-a314-f33351c82dff",
										true,
									},
									
									{
										"ce533cc3-db10-d3ad-9715-1bd3192ffb59",
										true,
									},
								},
								name = "Voix - IN puis SPREAD",
								uuid = "d0906b6e-faae-7396-a504-d543bc3f6a19",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "local cfg = data.ucob_guide_settings\nif data.ucob_guide then\n    if cfg and cfg.voice then TensorCore.sendTTS(\"SPREAD puis IN\", 100) end\nelse\n    TensorCore.addAlertText(5000, \"SPREAD puis IN\", 1, 2, true, 100)\nend\nself.used = true",
								alertPriority = 2,
								alertScale = 1,
								alertTTS = true,
								alertText = "SPREAD puis IN",
								alertVolume = 100,
								conditions = 
								{
									
									{
										"c58c682d-8591-00f9-8b46-a0be1e53d6fa",
										true,
									},
									
									{
										"ce533cc3-db10-d3ad-9715-1bd3192ffb59",
										true,
									},
								},
								name = "Voix - SPREAD puis IN",
								uuid = "fdd9690a-0d24-ce70-8672-a4eed15f9ab7",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"IN\", \"SPREAD\"\ns.firstSpell, s.finalSpell = 9916, 9918\ns.followup = \"SPREAD\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 3\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\nself.used = true",
								conditions = 
								{
									
									{
										"ebd54194-c501-bc57-a314-f33351c82dff",
										true,
									},
									
									{
										"ce533cc3-db10-d3ad-9715-1bd3192ffb59",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite IN puis SPREAD",
								uuid = "de55de58-3da4-5c2f-be20-22d77678fbd2",
								version = 2.1,
							},
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								aType = "Lua",
								actionLua = "data.ucob_nael_calls = data.ucob_nael_calls or {}\nlocal s = data.ucob_nael_calls\nlocal now = Now()\ns.current, s.next = \"SPREAD\", \"IN\"\ns.firstSpell, s.finalSpell = 9918, 9916\ns.followup = \"IN\"\ns.started, s.lastLine = now, eventArgs.line.line\ns.expires, s.hudUntil = now + 12000, now + 10000\ns.phase = 3\ns.routeMode, s.routeSpell = nil, nil\ns.routeStarted, s.routeDeadline, s.routeUntil = nil, nil, nil\ns.routeEstimated = true\nself.used = true",
								conditions = 
								{
									
									{
										"c58c682d-8591-00f9-8b46-a0be1e53d6fa",
										true,
									},
									
									{
										"ce533cc3-db10-d3ad-9715-1bd3192ffb59",
										true,
									},
								},
								endIfUsed = true,
								name = "Suite SPREAD puis IN",
								uuid = "12a95c44-2b43-596b-ba77-d79afcc6367c",
								version = 2.1,
							},
						},
					},
				},
				conditions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								category = "Lua",
								conditionLua = "local s = data.ucob_nael_calls\nlocal line = eventArgs.line and eventArgs.line.line\nif type(line) ~= \"string\" then return false end\nreturn not s or s.lastLine ~= line or not s.started or Now() - s.started > 2000",
								dequeueIfLuaFalse = true,
								name = "Citation nouvelle",
								uuid = "ce533cc3-db10-d3ad-9715-1bd3192ffb59",
								version = 3,
							},
						},
					},
				},
			},
		},
	},
	[117] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "b73ae6e1-fb83-62e6-ad47-0c83c3f41b73",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9956 then self.used=true return end\ns.phase=3\ns.put([==[tetherPrep]==],[==[TEMPEST WING — LIENS TANKS]==],[==[Tanks : liens à l'écart ; groupe à son abri]==],nil,70,2300)\nself.used=true",
				executeType = 2,
				mechanicTime = 637.1,
				name = "P3 - TEMPEST WING — LIENS TANKS (637.1s)",
				timeRange = true,
				timelineIndex = 117,
				timerEndOffset = 0.3,
				timerStartOffset = -2,
				uuid = "6cfd8208-1970-3fef-973d-9a15f649ad24",
				version = 2,
			},
		},
	},
	[118] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "380dde18-fe92-f8c4-e359-a372e46e4688",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "56bce25b-fc16-d404-85f0-14cce1bf3c2e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9956 then self.used=true return end\ns.phase=3\ns.put([==[shelterPrep]==],[==[ABRI — NEUROLIEN]==],[==[Rejoins le neurolien prévu ; attends l'impact]==],[==[Ensuite : SPREAD]==],86,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 638.1,
				name = "P3 - ABRI — NEUROLIEN (638.1s)",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "4f1dc27b-54bd-2ad1-927f-8a55c3e3d6e9",
				version = 2,
			},
		},
	},
	[119] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "3c353f23-8347-81ef-9e03-cf85139ca253",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[120] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "51aa2d31-52be-9e8c-b1f9-7ce4f99f72e9",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9956 then self.used=true return end\ns.phase=3\ns.put([==[spreadPrep]==],[==[SPREAD — METEOR STREAM]==],[==[Sors du regroupement après Excès d'éther]==],nil,82,3000)\nself.used=true",
				executeType = 2,
				mechanicTime = 641.1,
				name = "P3 - SPREAD — METEOR STREAM (641.1s)",
				timeRange = true,
				timelineIndex = 120,
				timerEndOffset = 0.5,
				timerStartOffset = -2.5,
				uuid = "23744f62-3802-61d5-b6a0-a98b5731d6ad",
				version = 2,
			},
		},
	},
	[121] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "ad4edca5-55e9-092e-a703-3f0f6b351bbf",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=3\ns.put([==[raidPrep]==],[==[GIGAFLARE — DÉGÂTS DE GROUPE]==],[==[Prépare les soins et mitigations prévus]==],nil,40,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 646.1,
				name = "P3 - GIGAFLARE — DÉGÂTS DE GROUPE (646.1s)",
				timeRange = true,
				timelineIndex = 121,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "fa003930-2384-694d-88bf-821c83ddbe3b",
				version = 2,
			},
		},
	},
	[122] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "5f9c3fbd-87a8-73b9-1903-93f774e7216d",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Flare Breath",
				uuid = "bdd4cff4-5506-0240-809a-9ecd8ac0b96e",
				version = 2,
			},
			inheritedObjectUUID = "fb839f4c-3829-c315-ba02-dc7547b618d0",
			inheritedOverwrites = 
			{
				displayPath = "store\\anyone\\ucob\\universal",
				enabled = false,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Visuels P3",
				uuid = "ade362cf-6321-4fce-b100-2e2d8678c05e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				execute = "-- Direction cue only: this arrow is NOT the exact cone boundary.\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nif not s.bossID then return end\nlocal boss = TensorCore.mGetEntity(s.bossID)\nif not boss then return end\nif s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\nlocal drawer = TensorCore.getCachedDrawer(4283453695, nil, 4283453695, 4279504646, 3)\ns.flareUUID = drawer:addTimedArrowOnEnt(3000, boss.id, 8, 0.65, 2, 2.2)\ns.flareRemaining = 1\ns.flareExpires = Now() + 3000\nself.used = true",
				executeType = 2,
				mechanicTime = 651.4,
				name = "P3 - Sens du souffle 651.4",
				timeRange = true,
				timelineIndex = 122,
				timerEndOffset = 0.5,
				timerStartOffset = -2.5,
				uuid = "fa8aa3e7-ae10-71d3-af35-fe65ed653039",
				version = 2,
			},
		},
	},
	[123] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "340f8b4a-b34a-c686-4f85-280c46ae33ba",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "532b707e-7a09-8e81-8016-0afd97232a88",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.phase=3\ns.put([==[tankPrep]==],[==[FLATTEN — TANKBUSTER]==],[==[Tanks : préparez votre mitigation]==],nil,65,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 660.4,
				name = "P3 - FLATTEN — TANKBUSTER (660.4s)",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "38e07313-ed90-ca16-9fe8-58e9e6774349",
				version = 2,
			},
		},
	},
	[124] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "499c744f-8063-aa43-cf23-85a513cf057f",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Flare Breath",
				uuid = "d528ccec-1efc-1378-b842-d9949d1fa411",
				version = 2,
			},
			inheritedObjectUUID = "a61cff86-6b0f-72a2-9dc7-fe0a3a904dfe",
			inheritedOverwrites = 
			{
				displayPath = "store\\anyone\\ucob\\universal",
				enabled = false,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Visuels P3",
				uuid = "038468d6-b174-c609-9baf-969efa8fd825",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				execute = "-- Direction cue only: this arrow is NOT the exact cone boundary.\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nif not s.bossID then return end\nlocal boss = TensorCore.mGetEntity(s.bossID)\nif not boss then return end\nif s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\nlocal drawer = TensorCore.getCachedDrawer(4283453695, nil, 4283453695, 4279504646, 3)\ns.flareUUID = drawer:addTimedArrowOnEnt(3000, boss.id, 8, 0.65, 2, 2.2)\ns.flareRemaining = 1\ns.flareExpires = Now() + 3000\nself.used = true",
				executeType = 2,
				mechanicTime = 665.4,
				name = "P3 - Sens du souffle 665.4",
				timeRange = true,
				timelineIndex = 124,
				timerEndOffset = 0.5,
				timerStartOffset = -2.5,
				uuid = "98af77dd-7ca4-0656-89d9-4f154eb0d2df",
				version = 2,
			},
		},
	},
	[126] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "d5d8bc59-8ea3-dd9d-8698-f38b3024af89",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[127] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "8ff66fa6-8efb-d02a-1641-0c6001785a16",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Tower",
				uuid = "e4168def-3c14-d857-8148-3c410a35d981",
				version = 2,
			},
			inheritedObjectUUID = "8809dde0-bf27-b929-93c5-bedb48d987d2",
			inheritedOverwrites = 
			{
				displayPath = "store\\anyone\\ucob\\universal",
				enabled = false,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Visuels P3",
				uuid = "b2f2c67c-c258-023b-af14-41e00ef1f083",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Radius, position and lifetime come from the real Megaflare tower event.\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nlocal old = s.towers[eventArgs.entityID]\nif old and old.startTime == eventArgs.startTime then self.used = true return end\nif old and old.uuid then Argus.deleteTimedShape(old.uuid) end\nlocal duration = eventArgs.duration * 1000\nlocal radius = eventArgs.aoeLength\nlocal drawer = TensorCore.getCachedDrawer(0x80AAAAAA, nil, 0x80AAAAAA, 4279504646, 1.5)\nlocal uuid = drawer:addTimedDonut(duration, eventArgs.x, eventArgs.y, eventArgs.z, math.max(0, radius - 0.18), radius, 0, false, true)\ns.towers[eventArgs.entityID] = {x = eventArgs.x, y = eventArgs.y, z = eventArgs.z, radius = radius, expires = Now() + duration, startTime = eventArgs.startTime, uuid = uuid}\nself.used = true",
							conditions = 
							{
								
								{
									"70b2bc22-8851-abbd-b7c6-36d5946b2e58",
									true,
								},
							},
							name = "Dessins stables et resolution",
							uuid = "a1a8f4a3-175e-f841-83c3-0907484f25f6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return eventArgs.aoeID == 9951 and type(eventArgs.entityID) == \"number\" and type(eventArgs.x) == \"number\" and type(eventArgs.y) == \"number\" and type(eventArgs.z) == \"number\" and type(eventArgs.aoeLength) == \"number\" and type(eventArgs.duration) == \"number\" and eventArgs.aoeLength > 0 and eventArgs.duration > 0",
							dequeueIfLuaFalse = true,
							name = "Tour 9951 - donnees valides",
							uuid = "70b2bc22-8851-abbd-b7c6-36d5946b2e58",
							version = 3,
						},
					},
				},
				displayPath = "LPDU - Visuels P3",
				eventType = 18,
				execute = "-- Radius, position and lifetime come from the real Megaflare tower event.\nif eventArgs.aoeID ~= 9951 then self.used = true return end\nif type(eventArgs.entityID) ~= \"number\" or type(eventArgs.x) ~= \"number\" or type(eventArgs.y) ~= \"number\" or type(eventArgs.z) ~= \"number\" or type(eventArgs.aoeLength) ~= \"number\" or type(eventArgs.duration) ~= \"number\" or eventArgs.aoeLength <= 0 or eventArgs.duration <= 0 then self.used = true return end\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nlocal old = s.towers[eventArgs.entityID]\nif old and old.startTime == eventArgs.startTime then self.used = true return end\nif old and old.uuid then Argus.deleteTimedShape(old.uuid) end\nlocal duration = eventArgs.duration * 1000\nlocal radius = eventArgs.aoeLength\nlocal drawer = TensorCore.getCachedDrawer(4283812095, nil, 4283812095, 4279504646, 3)\nlocal uuid = drawer:addTimedDonut(duration, eventArgs.x, eventArgs.y, eventArgs.z, math.max(0, radius - 0.18), radius, 0, false, true)\ns.towers[eventArgs.entityID] = {x = eventArgs.x, y = eventArgs.y, z = eventArgs.z, radius = radius, expires = Now() + duration, startTime = eventArgs.startTime, uuid = uuid}\nself.used = true",
				loop = true,
				mechanicTime = 681.4,
				name = "P3 - Tours observees stables",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 161.9,
				timerStartOffset = -184.4,
				uuid = "acb9af2c-15a7-cecb-a50e-992b8ae3fcb8",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				eventType = 12,
				execute = "-- LPDU: clockwise towers from Nael, R1 R2 R3 R4 L4 L3 L2 L1.\n-- Only confirmed personal destinations get a movement arrow.\nlocal g,fix,now = data.ucob_guide,data.ucobP3DrawFix,Now()\nlocal v = data.ucob_tower_visual\nif not v or v.version ~= 4 then\n    if v then\n        if v.arrow then Argus.deleteTimedShape(v.arrow) end\n        if v.goalUUID then Argus.deleteTimedShape(v.goalUUID) end\n        if v.beaconUUID then Argus.deleteTimedShape(v.beaconUUID) end\n    end\n    v = {version=4,list={},naelGroup={contentid=2612},slots={8,7,6,5,1,2,3,4},point={}}\n    data.ucob_tower_visual = v\n    v.sort = function(a,b) return a.order < b.order end\n    function v.clearArrow(s)\n        if s.arrow then Argus.deleteTimedShape(s.arrow); s.arrow=nil end\n    end\n    function v.clearGoal(s)\n        s.clearArrow(s)\n        if s.goalUUID then Argus.deleteTimedShape(s.goalUUID); s.goalUUID=nil end\n        s.goalKind,s.arrived=nil,nil\n    end\n    function v.role(p)\n        local j=p.job\n        if j==19 or j==21 or j==32 or j==37 then return 1 end\n        if j==24 or j==28 or j==33 or j==40 then return 2 end\n        return 3\n    end\n    function v.style(t,style)\n        if t.style == style then return end\n        local personal=style==3 or style==4\n        local color=style==3 and 0x60FFF060 or style==4 and 0x5040BFFF\n            or style==5 and 0x40909090 or style==2 and 0xFFFFF060 or style==1 and 0xFF40BFFF or 0x80AAAAAA\n        local outline=personal and 0xFFFFFFFF or 4279504646\n        local thickness=personal and 6 or style==5 and 1 or style==0 and 1.5 or 4\n        local inner=personal and 0 or math.max(0,t.radius-((style==0 or style==5) and 0.18 or 0.8))\n        local drawer=TensorCore.getCachedDrawer(color,nil,color,outline,thickness)\n        if t.uuid and drawer:updateTimedDonut(t.uuid,nil,t.x,t.y,t.z,inner,t.radius,0,false,true) then t.style=style end\n    end\nend\nlocal p=TensorCore.mGetPlayer()\nlocal trio=g and g.trio\nif v.trio ~= trio then\n    v.clearGoal(v)\n    if v.beaconUUID then Argus.deleteTimedShape(v.beaconUUID);v.beaconUUID=nil end\n    v.trio,v.selected,v.assigned,v.dead=trio,nil,false,false\n    v.naelAngle,v.nextCheck,v.eligible,v.candidateA,v.candidateB=nil,0,nil,nil,nil\n    v.referenceLocked=nil\n    v.otherTower,v.otherTowerSince=nil,nil\nend\nif not p or not p.alive or p.hp.current<=0 then v.dead=true end\nlocal enabled=p and p.alive and p.hp.current>0 and not v.dead and (trio==9955 or trio==9957)\nif now >= (v.nextCheck or 0) then\n    v.nextCheck=now+100\n    local towers=fix and fix.towers\n    local n=0\n    if towers then\n        for id,t in pairs(towers) do\n            if t.expires<=now then\n                if t.uuid then Argus.deleteTimedShape(t.uuid) end\n                towers[id]=nil\n            else\n                n=n+1;v.list[n]=t;t.source=id\n                t.angle=math.atan2(t.x,-t.z)\n            end\n        end\n    end\n    for i=#v.list,n+1,-1 do v.list[i]=nil end\n    if enabled and not v.assigned then\n        -- Nael is untargetable during trios; use her observed entity ID.\n        local observed=data.ucob_tower_nael\n        if not v.referenceLocked and observed and observed.trio==trio then\n            local nael=TensorCore.mGetEntity(observed.id)\n            if nael and nael.pos.x*nael.pos.x+nael.pos.z*nael.pos.z>=400 then\n                observed.angle=math.atan2(nael.pos.x,-nael.pos.z)\n            end\n            if observed.angle then v.naelAngle=observed.angle end\n        elseif not v.referenceLocked then\n            local nael=TensorCore.getEntityByGroup(\"ContentID\",v.naelGroup)\n            if nael and nael.pos.x*nael.pos.x+nael.pos.z*nael.pos.z>=400 then\n                v.naelAngle=math.atan2(nael.pos.x,-nael.pos.z)\n            end\n        end\n        if trio==9957 then\n            local slot=data.ucob_guide_settings and data.ucob_guide_settings.slot\n            if n==8 and v.naelAngle and slot and v.slots[slot] then\n                for i=1,n do\n                    local a=(v.list[i].angle-v.naelAngle)%(2*math.pi)\n                    if a>2*math.pi-math.pi/36 then a=a-2*math.pi end\n                    v.list[i].order=a\n                end\n                table.sort(v.list,v.sort)\n                local unique=true\n                for i=2,8 do if v.list[i].order-v.list[i-1].order<0.01 then unique=false end end\n                if unique then v.selected,v.assigned=v.list[v.slots[slot]].source,true end\n            end\n        elseif n==4 and v.naelAngle then\n            -- Validate one tower per quadrant in Nael-relative coordinates.\n            local nx,nz=math.sin(v.naelAngle),-math.cos(v.naelAngle)\n            local tn,hn,dn,df,valid=nil,nil,nil,nil,true\n            for i=1,n do\n                local t=v.list[i]\n                local forward=t.x*nx+t.z*nz\n                local right=-t.x*nz+t.z*nx\n                if math.abs(forward)<1 or math.abs(right)<1 then valid=false\n                elseif right>0 and forward>0 then if tn then valid=false end;tn=t.source\n                elseif right>0 then if hn then valid=false end;hn=t.source\n                elseif forward>0 then if dn then valid=false end;dn=t.source\n                else if df then valid=false end;df=t.source end\n            end\n            v.selected,v.eligible,v.candidateA,v.candidateB=nil,false,nil,nil\n            if valid and tn and hn and dn and df then v.referenceLocked=true end\n            if valid and tn and hn and dn and df and not g.stacks[p.id] then\n                local party=TensorCore.getEntityGroupList(\"Party\")\n                local count,roleCount,marked=0,0,0\n                local otherDPS,otherCount=nil,0\n                local role=v.role(p)\n                if party then\n                    for _,member in pairs(party) do\n                        count=count+1\n                        if v.role(member)==role then\n                            roleCount=roleCount+1\n                            if g.stacks[member.id] then marked=marked+1\n                            elseif role==3 and member.id~=p.id then otherDPS=member;otherCount=otherCount+1 end\n                        end\n                    end\n                end\n                local expected=role==3 and 2 or 1\n                if count==8 and roleCount==expected*2 and marked==expected then\n                    v.eligible=true\n                    if role==1 then v.selected=tn\n                    elseif role==2 then v.selected=hn\n                    else\n                        v.candidateA,v.candidateB=dn,df\n                        -- Blackfire has no fixed L4 tower. Resolve only from the\n                        -- other eligible DPS actually holding one DPS tower.\n                        local occupied\n                        if otherCount==1 and otherDPS.alive and otherDPS.hp.current>0 then\n                            local near,far=towers[dn],towers[df]\n                            local dx,dz=otherDPS.pos.x-near.x,otherDPS.pos.z-near.z\n                            local fx,fz=otherDPS.pos.x-far.x,otherDPS.pos.z-far.z\n                            local nr=near.radius*(v.otherTower==dn and 0.9 or 0.75)\n                            local fr=far.radius*(v.otherTower==df and 0.9 or 0.75)\n                            local inNear,inFar=dx*dx+dz*dz<=nr*nr,fx*fx+fz*fz<=fr*fr\n                            if inNear~=inFar then occupied=inNear and dn or df end\n                        end\n                        if occupied~=v.otherTower then\n                            v.otherTower,v.otherTowerSince=occupied,occupied and now or nil\n                        end\n                        if occupied and v.otherTowerSince and now-v.otherTowerSince>=300 then\n                            v.selected=occupied==dn and df or dn\n                            v.candidateA,v.candidateB=nil,nil\n                        end\n                    end\n                end\n            end\n        end\n    end\n    for i=1,n do\n        local t=v.list[i]\n        local style=0\n        if enabled and t.source==v.selected then style=2\n        elseif enabled and (t.source==v.candidateA or t.source==v.candidateB) then style=1 end\n        if trio==9957 then\n            if enabled and t.source==v.selected then style=g.towerKnockback and 3 or 4\n            else style=5 end\n        end\n        v.style(t,style)\n    end\nend\nlocal target=enabled and fix and fix.towers[v.selected]\n-- A steady white bullseye makes the assigned tower identifiable before knockback.\nif target and trio==9957 and target.expires>now then\n    local beacon=TensorCore.getCachedDrawer(0xFFFFFFFF,nil,0xFFFFFFFF,0xFF101010,3)\n    if v.beaconUUID and not beacon:updateTimedDonut(v.beaconUUID,nil,target.x,target.y,target.z,0.25,0.65,0,false,true) then v.beaconUUID=nil end\n    if not v.beaconUUID then v.beaconUUID=beacon:addTimedDonut(target.expires-now,target.x,target.y,target.z,0.25,0.65,0,false,true) end\nelseif v.beaconUUID then Argus.deleteTimedShape(v.beaconUUID);v.beaconUUID=nil end\nlocal x,y,z,expires,kind,radius,move\nlocal twister=data.ucob_twister_until and now<data.ucob_twister_until\nif target and target.expires>now then\n    expires,y=target.expires,target.y\n    if trio==9957 then\n        if g.towerKnockback then\n            if now>=g.towerKnockback+350 and not twister then\n                x,z,kind,radius,move=target.x,target.z,\"tower\",target.radius,true\n            end\n        elseif g.hfDiveDone and not twister then\n            local length=math.sqrt(target.x*target.x+target.z*target.z)\n            if length>0 then x,z,kind,radius,move=target.x*9/length,target.z*9/length,\"prepare\",1,true end\n        end\n    elseif g.towerReady and (g.blackfireNovas or 0)>=2 then\n        x,z,kind,radius,move=target.x,target.z,\"tower\",target.radius,true\n    end\nelseif enabled and trio==9955 and g.mineStack and not g.towerReady and v.naelAngle\n    and g.markerExpires and g.markerExpires>now then\n    x,y,z=-math.sin(v.naelAngle)*8,p.pos.y,math.cos(v.naelAngle)*8\n    expires,kind,radius=g.markerExpires,\"stack\",2.5\n    move=(g.blackfireNovas or 0)>=2\nend\nif not x then v.clearGoal(v);self.used=true;return end\nif v.goalKind~=kind then v.arrived=nil;v.goalKind=kind end\nv.point.x,v.point.y,v.point.z=x,y,z\nlocal color=move and 0xFFFFF060 or 0xFF40BFFF\nlocal drawer=TensorCore.getCachedDrawer(color,nil,color,trio==9957 and 0xFFFFFFFF or 4279504646,trio==9957 and 6 or 4)\nlocal goalRadius=kind==\"stack\" and 2.5 or 0.95\nif v.goalUUID and not drawer:updateTimedDonut(v.goalUUID,nil,x,y,z,goalRadius-0.4,goalRadius,0,false,true) then v.goalUUID=nil end\nif not v.goalUUID then v.goalUUID=drawer:addTimedDonut(math.floor(expires-now),x,y,z,goalRadius-0.4,goalRadius,0,false,true) end\nlocal dx,dz=x-p.pos.x,z-p.pos.z\nlocal distance=math.sqrt(dx*dx+dz*dz)\nif distance<=radius*0.65 then v.arrived=true\nelseif distance>=radius*0.85 then v.arrived=false end\nif v.arrived or not move or twister then v.clearArrow(v);self.used=true;return end\nlocal heading=TensorCore.getHeadingToTarget(p.pos,v.point)\nlocal bold=trio==9957\nlocal tip=math.min(bold and 1.6 or 1.1,distance*0.4)\nlocal shaft,tipWidth=bold and 0.95 or 0.55,bold and 2.1 or 1.3\nlocal arrowDrawer=TensorCore.getCachedDrawer(4294963296,nil,4294963296,4279504646,bold and 4 or 3)\nif v.arrow and not arrowDrawer:updateTimedArrowOnEnt(v.arrow,nil,p.id,distance-tip,shaft,tip,tipWidth,nil,0,false,heading,true) then v.arrow=nil end\nif not v.arrow then v.arrow=arrowDrawer:addTimedArrowOnEnt(math.floor(expires-now),p.id,distance-tip,shaft,tip,tipWidth,nil,0,false,heading,true) end\nself.used=true",
				executeType = 2,
				loop = true,
				mechanicTime = 681.4,
				name = "P3 - Tours personnelles LPDU",
				throttleTime = 16,
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 20,
				timerStartOffset = -121.4,
				uuid = "ed9cfda9-7109-333f-8d2b-358a3dd1011e",
				version = 2,
			},
		},
	},
	[128] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "0777c92b-e263-6bf7-be48-9bb99a908adb",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "47b77945-1f25-4bf1-bcd7-7b48a548e6e1",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9957 then self.used=true return end\ns.phase=3\ns.put([==[recul]==],[==[HEAVENSFALL — PRÉPARE LE RECUL]==],[==[Conserve ton placement avant le recul]==],[==[Ensuite : ta tour attribuée]==],76,4800)\nself.used=true",
				executeType = 2,
				mechanicTime = 686.9,
				name = "P3 - HEAVENSFALL — PRÉPARE LE RECUL (686.9s)",
				timeRange = true,
				timelineIndex = 128,
				timerEndOffset = 2.3,
				timerStartOffset = -2.5,
				uuid = "3c4e4c5c-594a-e1be-b520-98f71a5edb97",
				version = 2,
			},
		},
	},
	[131] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "d9042488-575b-41d5-b170-a11a5d0c546f",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9957 then self.used=true return end\ns.phase=3\ns.put([==[towerPrep]==],[==[ENTRE DANS TA TOUR ATTRIBUÉE]==],[==[Les anneaux dorés montrent les tours réelles ; respecte l'ordre LPDU]==],nil,84,2500)\nself.used=true",
				executeType = 2,
				mechanicTime = 691.4,
				name = "P3 - ENTRE DANS TA TOUR ATTRIBUÉE (691.4s)",
				timeRange = true,
				timelineIndex = 131,
				timerEndOffset = 0.3,
				timerStartOffset = -2.2,
				uuid = "70f56d59-424e-1ac5-96ed-3f3d6b43c206",
				version = 2,
			},
		},
	},
	[132] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "549fce78-3a5c-aca6-a856-a0f987682bb9",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9957 then self.used=true return end\ns.phase=3\ns.put([==[hyperPrep]==],[==[HYPERNOVAS — DÉPOSE PUIS BOUGE]==],[==[Reste dans le déplacement prévu pour les baits]==],[==[Évite les rafales au sol]==],76,4700)\nself.used=true",
				executeType = 2,
				mechanicTime = 694.5,
				name = "P3 - HYPERNOVAS — DÉPOSE PUIS BOUGE (694.5s)",
				timeRange = true,
				timelineIndex = 132,
				timerEndOffset = 3.2,
				timerStartOffset = -1.5,
				uuid = "4c0a5704-381d-e164-951a-a1b71eb39740",
				version = 2,
			},
		},
	},
	[133] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "797f43f4-1121-d626-b82b-e0510f5de3e0",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9957 then self.used=true return end\ns.phase=3\ns.put([==[groundPrep]==],[==[ÉVITE LES RAFALES AU SOL]==],[==[Continue le déplacement prévu ; garde les Hypernovas à l'écart]==],nil,65,5500)\nself.used=true",
				executeType = 2,
				mechanicTime = 696,
				name = "P3 - ÉVITE LES RAFALES AU SOL (696s)",
				timeRange = true,
				timelineIndex = 133,
				timerEndOffset = 5,
				timerStartOffset = -0.5,
				uuid = "1fcc9f9b-198f-799f-b466-a1a38e2c61fd",
				version = 2,
			},
		},
	},
	[134] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "22fce976-ad7a-d57a-51a1-89dc53b83d66",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[135] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "fb6e8be9-4406-a42d-3202-4cc749f7b019",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Boule de feu - Cible du partage",
				uuid = "d2507777-42bc-2a95-a05f-cf4ec5bffdc7",
				version = 2,
			},
			inheritedObjectUUID = "14bd91bf-7589-c3cf-9100-98b9841a4913",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "d4c6439c-b3c8-2a1e-ab1a-53a46ae96112",
								version = 2.1,
							},
							inheritedObjectUUID = "56ad87ce-a221-57f9-b643-61c3f8913598",
						},
					},
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "",
								uuid = "9358fabc-7ee8-587f-809e-5fc4f8016009",
								version = 2.1,
							},
							inheritedObjectUUID = "8c9e23ca-70d8-39b4-a6bd-6cdfd02ea0a3",
						},
					},
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Suivre cible du partage",
								uuid = "3730a676-abca-7f7f-8535-74103314c4cb",
								version = 2.1,
							},
							inheritedObjectUUID = "35e926c4-78e1-138d-bc54-a904a76c2d53",
							inheritedOverwrites = 
							{
								actionLua = "data.ucob_twin_fire_135 = data.ucob_twin_fire_135 or {}\nlocal s = data.ucob_twin_fire_135\nif s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\nif s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\ns.target = eventArgs.entityID\ns.arrived = nil\ns.holdUntil = Now() + 500\ns.expires = Now() + 15000\nself.used = true",
							},
						},
					},
				},
				conditions = 
				{
					
					{
						type = "remove",
						value = 
						{
							data = 
							{
								name = "Cible : moi",
								uuid = "347ce113-8293-3f16-ada3-5c6b89770b2e",
								version = 3,
							},
							inheritedObjectUUID = "a5b5e252-da8d-212b-b718-2fad5b08c520",
						},
					},
				},
				name = "Boule de feu - Cible du partage",
			},
		},
		
		{
			data = 
			{
				name = "Boule de feu - Distance",
				uuid = "c8da04f9-4a4b-667d-8532-14b6115a7e6d",
				version = 2,
			},
			inheritedObjectUUID = "2187ad3a-41de-86b3-806a-e8b359b19511",
			inheritedOverwrites = 
			{
				actions = 
				{
					
					{
						type = "add",
						value = 
						{
							data = 
							{
								name = "Cercle et fleche de partage",
								uuid = "02f0099b-1f9c-adbf-a1a7-4f888567cb14",
								version = 2.1,
							},
							inheritedObjectUUID = "c3ad175d-f904-6760-bd29-04a9be105058",
							inheritedOverwrites = 
							{
								actionLua = "local s = data.ucob_twin_fire_135\nif not s or not s.target then self.used = true; return end\nlocal remaining = math.floor(math.min(s.expires - Now(), (708.5 - TensorReactions_CurrentTimer) * 1000))\nlocal p = TensorCore.mGetPlayer()\nlocal target = TensorCore.mGetEntity(s.target)\nif not p or not p.alive or p.hp.current <= 0 or not target or not target.alive or target.hp.current <= 0 or remaining <= 0 then\n    if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n    if s.circle then Argus.deleteTimedShape(s.circle); s.circle = nil end\n    s.target = nil\n    self.used = true\n    return\nend\nlocal dx, dz = p.pos.x - target.pos.x, p.pos.z - target.pos.z\nlocal distanceSquared = dx * dx + dz * dz\n-- Two thresholds inside the 4y stack radius prevent boundary flicker.\nif distanceSquared <= 12.25 then\n    s.arrived = true\nelseif distanceSquared >= 14.44 then\n    s.arrived = false\nend\nlocal outside = not s.arrived\nlocal now = Now()\nlocal f = data.ucob_fireball_guide\nlocal holdUntil = f and f.target == s.target and f.holdUntil or s.holdUntil or 0\nlocal waiting = now < holdUntil or (data.ucob_twister_until and now < data.ucob_twister_until)\nlocal fill = waiting and 0x10AAAAAA or 0x30FFF060\nlocal outline = waiting and 0xFFAAAAAA or 0xFFFFF060\nlocal ring = TensorCore.getCachedDrawer(fill, nil, fill, outline, waiting and 2 or 4)\nif s.circle and not ring:updateTimedCircleOnEnt(s.circle, nil, s.target, 4, 0, false, true) then s.circle = nil end\nif not s.circle then s.circle = ring:addTimedCircleOnEnt(remaining, s.target, 4, 0, false, true) end\nif outside and not waiting then\n    local drawer = TensorCore.getCachedDrawer(4294963296, nil, 4294963296, 4279504646, 3)\n    drawer:setGradient(0.25, 0.4, 1.5)\n    -- Explicit distance and absolute heading place the tip at the destination.\n    local distance = math.sqrt(distanceSquared)\n    local tipLength = math.min(1.1, distance * 0.4)\n    local baseLength = distance - tipLength\n    local heading = TensorCore.getHeadingToTarget(p.pos, target.pos)\n    -- Replace an old target-attached arrow once, then keep updating the same shape.\n    if not s.fullLengthArrow then\n        if s.uuid then Argus.deleteTimedShape(s.uuid); s.uuid = nil end\n        s.fullLengthArrow = true\n    end\n    if s.uuid and not drawer:updateTimedArrowOnEnt(s.uuid, nil, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) then s.uuid = nil end\n    if not s.uuid then s.uuid = drawer:addTimedArrowOnEnt(remaining, p.id, baseLength, 0.55, tipLength, 1.3, nil, 0, false, heading, true) end\nelseif s.uuid then\n    Argus.deleteTimedShape(s.uuid); s.uuid = nil\nend\nself.used = true",
							},
						},
					},
				},
				eventType = 12,
				throttleTime = 16,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "232c28e4-ccf2-7d44-beed-a930e23904f8",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9957 then self.used=true return end\ns.phase=3\ns.put([==[stackPrep]==],[==[FIREBALL — PARTAGE]==],[==[Rejoins le groupe de partage prévu]==],nil,75,2300)\nself.used=true",
				executeType = 2,
				mechanicTime = 703.5,
				name = "P3 - FIREBALL — PARTAGE (703.5s)",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = 0.3,
				timerStartOffset = -2,
				uuid = "d6793f9b-7b66-4119-9b4c-594e4a8ee3f9",
				version = 2,
			},
		},
	},
	[136] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "c32be58e-fcc4-b416-ab9e-a1e5e4255c24",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=3\ns.put([==[raidPrep]==],[==[GIGAFLARE — DÉGÂTS DE GROUPE]==],[==[Prépare les soins et mitigations prévus]==],nil,40,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 708.5,
				name = "P3 - GIGAFLARE — DÉGÂTS DE GROUPE (708.5s)",
				timeRange = true,
				timelineIndex = 136,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "ecf612f2-d4cc-65b1-be63-0361c0bd5fe8",
				version = 2,
			},
		},
	},
	[139] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "a21df895-823a-4711-61a8-b3534ff7be85",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Flare Breath",
				uuid = "db48d7af-307c-c4b6-ad70-f909db6042c3",
				version = 2,
			},
			inheritedObjectUUID = "4e6f366f-931f-3657-8f4b-2b2997afcd4b",
			inheritedOverwrites = 
			{
				displayPath = "store\\anyone\\ucob\\universal",
				enabled = false,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Visuels P3",
				uuid = "1640d298-18d6-fa6d-8ca6-417f7ddcff30",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				execute = "-- Direction cue only: this arrow is NOT the exact cone boundary.\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nif not s.bossID then return end\nlocal boss = TensorCore.mGetEntity(s.bossID)\nif not boss then return end\nif s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\nlocal drawer = TensorCore.getCachedDrawer(4283453695, nil, 4283453695, 4279504646, 3)\ns.flareUUID = drawer:addTimedArrowOnEnt(7000, boss.id, 8, 0.65, 2, 2.2)\ns.flareRemaining = 3\ns.flareExpires = Now() + 7000\nself.used = true",
				executeType = 2,
				mechanicTime = 721.5,
				name = "P3 - Sens du souffle 721.5",
				timeRange = true,
				timelineIndex = 139,
				timerEndOffset = 0.5,
				timerStartOffset = -6.5,
				uuid = "b965a637-25cd-48e1-b17d-cc84226a979c",
				version = 2,
			},
		},
	},
	[141] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "1a6bc612-c978-a1b6-ed3e-c8dc3a967902",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[142] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "f082ce0b-7f74-141f-5477-ae110651a63b",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "9f8b6b00-4f7d-b4bb-88e7-f30dc62765df",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9958 then self.used=true return end\ns.phase=3\ns.put([==[hatchPrep]==],[==[HATCH — PREMIÈRE VAGUE]==],[==[Porteurs : neurolien attribué ; les autres dégagent les trajets]==],[==[Meteor Stream sur les DPS]==],65,6000)\nself.used=true",
				executeType = 2,
				mechanicTime = 740.5,
				name = "P3 - HATCH — PREMIÈRE VAGUE (740.5s)",
				timeRange = true,
				timelineIndex = 142,
				timerEndOffset = 3.5,
				timerStartOffset = -2.5,
				uuid = "a328178f-c472-9817-bf6a-ce5f0b06a776",
				version = 2,
			},
		},
	},
	[143] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "802ae6e0-5b3d-eef4-0805-47fedd430590",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "ea16dfb9-5fcc-377d-a8cc-d4dbd69ead23",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.tank(p) or s.healer(p) then self.used=true return end\nif s.trio ~= 9958 then self.used=true return end\ns.phase=3\ns.put([==[spreadPrep]==],[==[DPS — METEOR STREAM]==],[==[DPS : restez séparés pendant toute la vague]==],[==[Ensuite : tanks et soigneurs]==],85,5400)\nself.used=true",
				executeType = 2,
				mechanicTime = 741.5,
				name = "P3 - DPS — METEOR STREAM (741.5s)",
				timeRange = true,
				timelineIndex = 143,
				timerEndOffset = 3.4,
				timerStartOffset = -2,
				uuid = "22a77bdc-c04d-c963-bfb7-7a06ee17c29d",
				version = 2,
			},
		},
	},
	[144] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "b0c9e67a-342f-eda2-a3db-6f476fda268a",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9958 then self.used=true return end\ns.phase=3\ns.put([==[hatchPrep]==],[==[HATCH — DEUXIÈME VAGUE]==],[==[Nouveaux porteurs : neurolien attribué ; libérez les trajectoires]==],[==[Meteor Stream tanks / soigneurs]==],65,5000)\nself.used=true",
				executeType = 2,
				mechanicTime = 744.5,
				name = "P3 - HATCH — DEUXIÈME VAGUE (744.5s)",
				timeRange = true,
				timelineIndex = 144,
				timerEndOffset = 3.5,
				timerStartOffset = -1.5,
				uuid = "7fc4ab74-3d5d-f868-81a4-91bfa0065d8b",
				version = 2,
			},
		},
	},
	[145] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "d9b52528-92a6-01f5-95ff-e645d8f8f143",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) and not s.healer(p) then self.used=true return end\nif s.trio ~= 9958 then self.used=true return end\ns.phase=3\ns.put([==[spreadPrep]==],[==[TANKS / SOIGNEURS — METEOR STREAM]==],[==[Restez séparés pendant toute la vague]==],nil,85,4900)\nself.used=true",
				executeType = 2,
				mechanicTime = 745.5,
				name = "P3 - TANKS / SOIGNEURS — METEOR STREAM (745.5s)",
				timeRange = true,
				timelineIndex = 145,
				timerEndOffset = 3.4,
				timerStartOffset = -1.5,
				uuid = "980576c0-1b50-3f26-b4d8-90c3e829208c",
				version = 2,
			},
		},
	},
	[146] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "82ed6e77-744a-f9b3-0f47-cbf5cb524a67",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[147] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "3cb1058c-8339-4458-9d67-3f6b6ab87e27",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9958 then self.used=true return end\ns.phase=3\ns.put([==[shakerPrep]==],[==[EARTHSHAKERS — PREMIÈRE VAGUE]==],[==[Les porteurs prennent leurs secteurs ; les autres attendent]==],[==[Ensuite : deuxième vague]==],60,2800)\nself.used=true",
				executeType = 2,
				mechanicTime = 754.4,
				name = "P3 - EARTHSHAKERS — PREMIÈRE VAGUE (754.4s)",
				timeRange = true,
				timelineIndex = 147,
				timerEndOffset = 0.3,
				timerStartOffset = -2.5,
				uuid = "94a36929-4de4-21c7-b6de-32e130da8d2a",
				version = 2,
			},
		},
	},
	[148] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "2f2de01d-9d36-dcf1-b3b8-f93f1427204d",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "9b5466f1-dfc2-1fdb-9595-5cc645a716e9",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9958 then self.used=true return end\ns.phase=3\ns.put([==[shakerPrep]==],[==[EARTHSHAKERS — DEUXIÈME VAGUE]==],[==[Les nouveaux porteurs prennent leurs secteurs]==],nil,65,2300)\nself.used=true",
				executeType = 2,
				mechanicTime = 759.4,
				name = "P3 - EARTHSHAKERS — DEUXIÈME VAGUE (759.4s)",
				timeRange = true,
				timelineIndex = 148,
				timerEndOffset = 0.3,
				timerStartOffset = -2,
				uuid = "27dc3096-17be-b343-a354-7188a981fcde",
				version = 2,
			},
		},
	},
	[149] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "086bac03-cbbc-0d58-80f4-84a6b8ec6a0d",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\ns.phase=3\ns.put([==[raidPrep]==],[==[GIGAFLARE — DÉGÂTS DE GROUPE]==],[==[Prépare les soins et mitigations prévus]==],nil,40,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 767.4,
				name = "P3 - GIGAFLARE — DÉGÂTS DE GROUPE (767.4s)",
				timeRange = true,
				timelineIndex = 149,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "8c49549a-a8e9-e5e4-ad5f-f9c2d3d825d2",
				version = 2,
			},
		},
	},
	[150] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "3a651e94-7c24-8038-fe24-390e9ac62344",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "4132e2cb-d73c-0391-b364-7b2654cad940",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif not s.tank(p) then self.used=true return end\ns.phase=3\ns.put([==[tankPrep]==],[==[FLATTEN — TANKBUSTER]==],[==[Tanks : préparez votre mitigation]==],nil,65,3300)\nself.used=true",
				executeType = 2,
				mechanicTime = 778.4,
				name = "P3 - FLATTEN — TANKBUSTER (778.4s)",
				timeRange = true,
				timelineIndex = 150,
				timerEndOffset = 0.3,
				timerStartOffset = -3,
				uuid = "c8c5002c-42eb-e01c-ae8b-a8546038cb9b",
				version = 2,
			},
		},
	},
	[151] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "820594bf-e4c6-6b43-8635-65e11f7aac6f",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				name = "Draw Flare Breath",
				uuid = "b6b3fd21-e6f7-4216-9351-1989096d4669",
				version = 2,
			},
			inheritedObjectUUID = "84dff798-890a-f3d0-adb3-1d4c30195899",
			inheritedOverwrites = 
			{
				displayPath = "store\\anyone\\ucob\\universal",
				enabled = false,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Visuels P3",
				uuid = "be5744ad-d395-f7c4-97c5-4559bdbe7c2e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Visuels P3",
				execute = "-- Direction cue only: this arrow is NOT the exact cone boundary.\ndata.ucobP3DrawFix = data.ucobP3DrawFix or {towers = {}}\nlocal s = data.ucobP3DrawFix\nif not s.bossID then return end\nlocal boss = TensorCore.mGetEntity(s.bossID)\nif not boss then return end\nif s.flareUUID then Argus.deleteTimedShape(s.flareUUID) end\nlocal drawer = TensorCore.getCachedDrawer(4283453695, nil, 4283453695, 4279504646, 3)\ns.flareUUID = drawer:addTimedArrowOnEnt(3000, boss.id, 8, 0.65, 2, 2.2)\ns.flareRemaining = 1\ns.flareExpires = Now() + 3000\nself.used = true",
				executeType = 2,
				mechanicTime = 781.4,
				name = "P3 - Sens du souffle 781.4",
				timeRange = true,
				timelineIndex = 151,
				timerEndOffset = 0.5,
				timerStartOffset = -2.5,
				uuid = "384674ea-ba86-6a5a-ae9b-fc39942516dc",
				version = 2,
			},
		},
	},
	[153] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "201603c9-f306-9e9d-4998-2417bbfef5f9",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[154] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "9c643208-09aa-3004-ae32-5b3299b55c78",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "5cf17b3b-c4b3-3115-a6b7-f489070fd81f",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9959 then self.used=true return end\ns.phase=3\ns.put([==[octetPrep]==],[==[OCTET — SUIS LA ROTATION PRÉVUE]==],[==[Reste avec le groupe pour déposer les charges]==],[==[Marqueur personnel : prépare ton bait]==],50,10000)\nself.used=true",
				executeType = 2,
				mechanicTime = 797.4,
				name = "P3 - OCTET — SUIS LA ROTATION PRÉVUE (797.4s)",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = 8,
				timerStartOffset = -2,
				uuid = "fe064b88-46ef-70ff-9b61-8fa622bc3953",
				version = 2,
			},
		},
	},
	[156] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "819440e6-215f-1718-8382-45f9ffb63a8d",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9959 then self.used=true return end\ns.phase=3\ns.put([==[octetPrep]==],[==[CHARGES DES DRAGONS — CONTINUE]==],[==[Poursuis la rotation avec le groupe ; évite les charges déjà parties]==],nil,50,11000)\nself.used=true",
				executeType = 2,
				mechanicTime = 808.4,
				name = "P3 - CHARGES DES DRAGONS — CONTINUE (808.4s)",
				timeRange = true,
				timelineIndex = 156,
				timerEndOffset = 9.5,
				timerStartOffset = -1.5,
				uuid = "2d41d47b-6672-6deb-9725-578f36f7bc36",
				version = 2,
			},
		},
	},
	[159] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "9bec2747-b45b-8c8b-078c-20d980833237",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[163] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "81fbae24-04b6-f467-a7d1-a0a833e07223",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9959 then self.used=true return end\ns.phase=3\ns.put([==[octetPrep]==],[==[DERNIER DIVE — GÉMELLIA]==],[==[Le joueur sans marqueur prend le bait final avec le stack]==],[==[Ensuite : TWISTER]==],55,5000)\nself.used=true",
				executeType = 2,
				mechanicTime = 823.4,
				name = "P3 - DERNIER DIVE — GÉMELLIA (823.4s)",
				timeRange = true,
				timelineIndex = 163,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "1bc2eece-7a7d-62f2-b05c-f12dfd390d32",
				version = 2,
			},
		},
	},
	[164] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "f783a52d-6672-5d89-a7f6-eb32b1838cb7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9959 then self.used=true return end\ns.phase=3\ns.put([==[stackPrep]==],[==[OCTET — PARTAGE FINAL]==],[==[Respecte ton groupe et la résolution prévue par votre stratégie]==],[==[TWISTER après le dive]==],75,1800)\nself.used=true",
				executeType = 2,
				mechanicTime = 826.4,
				name = "P3 - OCTET — PARTAGE FINAL (826.4s)",
				timeRange = true,
				timelineIndex = 164,
				timerEndOffset = 0.3,
				timerStartOffset = -1.5,
				uuid = "33c3cabe-99d2-affa-87cb-2cfbb870e288",
				version = 2,
			},
		},
	},
	[165] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "9f318f40-2d69-129c-4e0a-0f9efd5d01f0",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[166] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "LPDU - Guide P3",
				uuid = "6d12da53-f9e1-0106-85ba-9560a8e86a02",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
				},
				conditions = 
				{
				},
				displayPath = "LPDU - Guide P3",
				execute = "local s=data.ucob_guide\nif not s then return end\n\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.alive then self.used=true return end\nif s.trio ~= 9959 then self.used=true return end\ns.phase=3\ns.put([==[towerPrep]==],[==[OCTET — RÉSOLUTION DES TOURS]==],[==[Respecte votre plan de tours / LB tank ; les anneaux sont neutres]==],nil,76,2300)\nself.used=true",
				executeType = 2,
				mechanicTime = 828.4,
				name = "P3 - OCTET — RÉSOLUTION DES TOURS (828.4s)",
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = 0.3,
				timerStartOffset = -2,
				uuid = "fd44ef11-9630-a218-bb4e-d81a4d38a3b7",
				version = 2,
			},
		},
	},
	[168] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "0d2d230f-9a43-6013-6233-314d65ace83f",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[171] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "d95e1e71-b3c4-9405-6d86-bd6f382954e1",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[173] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "dbf7c2a7-3993-e86b-0a0b-06f9fb8c1317",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[174] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "20773b42-f0cc-84ce-e7c1-6d7860264a32",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[181] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "bc71d666-18d1-7462-0b86-135055b2e2d6",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[184] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "d152287d-1dd7-8611-d670-a92790fd7c2d",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[189] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "f5b9484e-4918-147a-e1f2-226882beb8fe",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[193] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "c2b90b8d-d0eb-f8d9-eafb-b48b0c09153d",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[194] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "602ab274-3189-68d8-bac7-d26e6520f324",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[198] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "d9d2aed0-1504-8c2c-29fe-b92a460b3100",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[199] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "9e1a567b-12f7-fc17-29a6-c69db3e49eab",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[200] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "1d00f7c4-5ef6-8100-6830-40c25d534174",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[202] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "453b4c46-41d7-1c32-58c6-3250cb8df436",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[203] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "3e39ca79-c809-7545-1d0d-d9fbf0187ea9",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[205] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "e8d5ee03-dd3c-e517-2117-23f176604c33",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	[206] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "store\\anyone\\ucob\\universal",
				uuid = "704f09ea-91c8-fa0e-3eab-4cbc9aaf02da",
			},
			inheritanceRoot = "store\\anyone\\ucob\\universal",
			objectType = "folder",
		},
	},
	inheritedProfiles = 
	{
		"store\\anyone\\ucob\\universal",
	},
	timelineName = "ucob",
	version = "1.0.3",
}



return tbl