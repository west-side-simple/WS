--startup westSide portal 
--saved as utf-8 without bom

if m_simpleTV.User==nil then m_simpleTV.User={} end
if m_simpleTV.User.westSide==nil then m_simpleTV.User.westSide={} end

AddFileToExecute('events', m_simpleTV.MainScriptDir .. "user/westSide/events.lua")
dofile (m_simpleTV.MainScriptDir_UTF8 .. "user/westSide/paramScriptForSkin-west_side.lua")
dofile (m_simpleTV.MainScriptDir_UTF8 .. "user/westSide/testWestSide.lua")
-------------------------------------------------------------------
function play_adr_timeshift(adr, start, background)
  m_simpleTV.Control.Restart(false)
  m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = background, TypeBackColor = 0, UseLogo = 3, Once = 1})
  m_simpleTV.Control.PlayAddressT({address = '$InternationalID=' .. adr, timeshiftOffset = (os.time() - start)*1000})
end
-------------------------------------------------------------------
function play_timeshift_adr(start)
  m_simpleTV.Control.SetNewAddressT({timeshiftOffset = (os.time() - start)*1000})
end
-------------------------------------------------------------------
function show_portal_window()
 if m_simpleTV.User.westSide.PortalTable~=nil then
   local t={}
   t=m_simpleTV.User.westSide.PortalTable
   m_simpleTV.OSD.ShowMessageBox(t)
 end  
end
-------------------------------------------------------------------
function run_westSide_portal()

m_simpleTV.Control.ExecuteAction(37)

local tt={
{"Wink Media","https://wink.rt.ru/333","https://s26037.cdn.ngenix.net/images/bs3gn7loldart9fqrji0.png",''},
{"Wink TV","https://wink.rt.ru/tv","https://s26037.cdn.ngenix.net/images/brqqjiloldaqs7749hp0.png",''},
{"HDRezka","https://rezka.ag","https://smarttvnews.ru/wp-content/uploads/2016/01/115x95-1280x720.png",''},
{"Rezka torrent","https://rezka.cc/","https://rezka.cc/apple-touch-icon.png",''},
{"LostFilm","https://www.lostfilm.tv/new/","https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg",''},
{"NewStudio","http://newstudio.tv/","https://perevodman.com/gallery/img/NewStudio_Logo.gif",''},
{"Rips club","https://rips.club","https://cn816.mooo.com/b5bWrsBAnOu5WBtE/0/lostpix.com/img/2020-02/09/nv5ok70zc5416rx3muyj6syet.jpg",''},
}
  
  local t={}
  for i=1,#tt do
    t[i] = {}
    t[i].Id = i
    t[i].Name = tt[i][1]
    t[i].Action = tt[i][2]
	t[i].InfoPanelLogo = tt[i][3]
	t[i].InfoPanelTitle = 'Guide'
	t[i].InfoPanelDesc = 'Guide' .. tt[i][4]
	t[i].InfoPanelShowTime = 9000
  end
  
  local ret,id = m_simpleTV.OSD.ShowSelect_UTF8('Portal menu',0,t,9000,1+4+8)
  if id==nil then return end
  
  if ret==1 then 
    m_simpleTV.Control.PlayAddressT({address = t[id].Action})
    if not m_simpleTV.Interface.GetFullScreenMode() then
     m_simpleTV.Control.ExecuteAction(14,1)
    end
  end
 
end
-------------------------------------------------------------------
function west_side_substr(str)
 if m_simpleTV.Common.lenUTF8(str) > 30 then
   str = m_simpleTV.Common.midUTF8(str,0,30) .. '...'
 end 
 return str 
end
-------------------------------------------------------------------

 local t={}
 t.utf8 = true
 t.name = 'OSD меню'
 t.luastring = 'run_westSide_portal()'
 t.lua_as_scr = true 
 t.submenu = 'westSide Portal'
 t.imageSubmenu = m_simpleTV.MainScriptDir_UTF8 .. 'user/westSide/icons/Collection_gray.png'
 t.key = string.byte('I') 
 t.ctrlkey = 3
 t.location = 0
 t.image= m_simpleTV.MainScriptDir_UTF8 .. 'user/westSide/icons/Collection_gray.png'
 m_simpleTV.Interface.AddExtMenuT(t)


