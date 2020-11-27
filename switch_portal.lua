if m_simpleTV.User == nil then m_simpleTV.User = {} end
if m_simpleTV.User.WestSide == nil then m_simpleTV.User.WestSide = {} end
if m_simpleTV.User.WestSide.info_portal == nil then m_simpleTV.User.WestSide.info_portal = 0 end

if m_simpleTV.User.WestSide.info_portal == 0 then
    m_simpleTV.Control.ExecuteAction(108,1) --KEY_OSD_SHOW_MULTIADDRESS
elseif m_simpleTV.User.WestSide.info_portal == 1 then
	m_simpleTV.Control.ExecuteAction(37)
	show_portal_window() --KEY_OSD_SHOW_PORTAL_INFO
    m_simpleTV.User.WestSide.info_portal = -1
end

m_simpleTV.User.WestSide.info_portal = m_simpleTV.User.WestSide.info_portal + 1
--m_simpleTV.OSD.ShowMessageT({text='info: ' .. m_simpleTV.User.WestSide.info_portal,id='wsInfo'})

