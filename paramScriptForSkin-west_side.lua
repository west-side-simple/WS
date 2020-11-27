-- paramScriptForSkin west_side (9/6/20)
	if not m_simpleTV.User then
		m_simpleTV.User = {}
	end
	local skinPath = tostring(m_simpleTV.Config.GetValue('skin/path', 'simpleTVConfig') or '')
	skinPath = m_simpleTV.Common.GetMainPath(2) .. skinPath:gsub('^%./', '')
	if skinPath:match('west_side') then
		m_simpleTV.User.paramScriptForSkin_logoYT = skinPath .. '/img/youtube.png'
		m_simpleTV.User.paramScriptForSkin_thumbsSizeFactor = 0.21
		m_simpleTV.User.paramScriptForSkin_thumbsBackColor = 0x00000000
		m_simpleTV.User.paramScriptForSkin_thumbsTextColor = 0xff1231f1
		m_simpleTV.User.paramScriptForSkin_thumbsMarginBottom = 25
		m_simpleTV.User.paramScriptForSkin_thumbsGlowParams = 'glow="7" samples="5" extent="4" color="0xB0F6F7F9"'
		m_simpleTV.User.paramScriptForSkin_buttonNext = skinPath .. '/img/osd/multiaddress/right.png'
		m_simpleTV.User.paramScriptForSkin_buttonPrev = skinPath .. '/img/osd/multiaddress/left.png'
		m_simpleTV.User.paramScriptForSkin_buttonOptions = skinPath .. '/img/osd/multiaddress/options.png'
		m_simpleTV.User.paramScriptForSkin_buttonInfo = skinPath .. '/img/osd/multiaddress/InfoButton.png'
		m_simpleTV.User.paramScriptForSkin_buttonSave = skinPath .. '/img/osd/multiaddress/saveplst.png'
		m_simpleTV.User.paramScriptForSkin_buttonPlst = skinPath .. '/img/osd/multiaddress/plst.png'
		m_simpleTV.User.paramScriptForSkin_buttonClose = skinPath .. '/img/osd/multiaddress/CloseButton.png'
		m_simpleTV.User.paramScriptForSkin_buttonSearch = skinPath .. '/img/osd/multiaddress/search.png'
		m_simpleTV.User.paramScriptForSkin_buttonOk = skinPath .. '/img/osd/multiaddress/select.png'
		m_simpleTV.User.paramScriptForSkin_background_chanel = 'http://sectorradio.com/next-flac'		
-- for 1080p		
		m_simpleTV.User.paramScriptForSkin_masshtab = 1.5
		m_simpleTV.User.paramScriptForSkin_background1 = 'style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG01_1080p.png);"'
		m_simpleTV.User.paramScriptForSkin_background2 = 'style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG02_1080p.jpg);"'
-- for 720p
--		m_simpleTV.User.paramScriptForSkin_masshtab = 1
--		m_simpleTV.User.paramScriptForSkin_background1 = 'style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG01_720p.png);"'
--		m_simpleTV.User.paramScriptForSkin_background2 = 'style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG02_720p.jpg);"'
	end
	-------------------------------------------------------------------
function skin_settings()

m_simpleTV.Control.ExecuteAction(37)

local ws={
{"Theme classic","theme1"},
{"Theme mirror","theme2"},
{"Theme khameleon","theme3"},
}
  
  local t={}
  for i=1,#ws do
    t[i] = {}
    t[i].Id = i
    t[i].Name = ws[i][1]
    t[i].Action = ws[i][2]
  end
  
  local ret,id = m_simpleTV.OSD.ShowSelect_UTF8('Skin settings',0,t,9000,1+4+8)
  if id==nil then return end
  
  if ret==1 then 
 --   t[id].Action
  end
 
end
-------------------------------------------------------------------