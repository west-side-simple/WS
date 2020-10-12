-- поиск на https://rezka.ag/ из телепрограмы (9/8/20)
-- необходим видоскрипт: hdrezka_1080p.lua or hdrezka_720p.lua
	function findEPGInRezka(epgId)
			if not epgId then return end
		local t = m_simpleTV.Database.GetTable('SELECT * FROM ChProg WHERE (ChProg.Id=' .. epgId .. ');')
			if not t
				or not t[1]
				or not t[1].Title
			then
			 return
			end
		m_simpleTV.Control.ExecuteAction(38, 0) -- SHOW_OSD_EPG
		m_simpleTV.Control.ExecuteAction(6, 0)
		-- local param = {text='epgID:' .. epgId .. '\n' .. 'Title:' .. t[1].Title,id='testEpgMenu'}
		-- m_simpleTV.OSD.ShowMessageT(param)
		local function clean_title(s)
			s = s:gsub('%(.-%)', ' ')
			s = s:gsub('%[.-%]', ' ')
			s = s:gsub('Х/ф', '')
			s = s:gsub('х/ф', '')
			s = s:gsub('М/ф', '')
			s = s:gsub('м/ф', '')
			s = s:gsub('М/с', '')
			s = s:gsub('м/с', '')
			s = s:gsub('Т/с', '')
			s = s:gsub('т/с', '')
			s = s:gsub('%d+%-.-$', ' ')
			s = s:gsub('Сезон.-$', '')
			s = s:gsub('сезон.-$', '')
			s = s:gsub('Серия.-$', '')
			s = s:gsub('серия.-$', '')
			s = s:gsub('%d+ с%-н.-$', '')
			s = s:gsub('%d+ с[%.]*$', '')
			s = s:gsub('%p', ' ')
			s = s:gsub('«', '')
			s = s:gsub('»', '')
			s = s:gsub('^%s*(.-)%s*$', '%1')
		 return s
		end
		local w = clean_title(t[1].Title)
		w = '#' .. w
		m_simpleTV.Control.PlayAddress_UTF8(w)
	end
	local t = {}
	t.utf8 = true
	t.name = 'Rezka поиск'
	t.lua_as_scr = true
	t.luastring = 'local action,param,extParam = ...;findEPGInRezka(extParam)'
	t.location = 2 -- LOCATION_EPG_MENU
	t.image = m_simpleTV.Common.GetMainPath(0) .. 'Icons/menuRezka.png'
	m_simpleTV.Interface.AddExtMenuT(t)