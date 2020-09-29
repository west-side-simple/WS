-- видеоскрипт для сайта https://rezka.ag (27/09/20) v.2.4
-- ветка на bugtracker http://iptv.gen12.net/bugtracker/view.php?id=1596
-- авторы nexterr, west_side
-- открывает подобные ссылки:
-- https://rezka.ag/films/comedy/31810-horoshie-malchiki-2019.html
-- https://rezka.ag/series/fiction/34492-porogi-vremeni-1993.html
-- http://nexthdrezka.com/series/fiction/34385-skvoz-sneg-2020.html
-- http://betahdrezka.com/cartoons/adventures/7717-priklyucheniya-kota-v-sapogah-2015.html
-- https://rezka.ag/person/4941-bred-pitt/ и прочие с сайта https://rezka.ag
-- для поиска в видеобазе Rezka #, #город
-- << прокси >>
	local proxy = ''
-- '' нет
-- 'https://proxy-nossl.antizapret.prostovpn.org:29976' (пример)
-- <<>>
		if m_simpleTV.Control.ChangeAddress ~= 'No' then return end
		if not m_simpleTV.Control.CurrentAddress:match('^https?://rezka%.ag')
            and not m_simpleTV.Control.CurrentAddress:match('^https?://%a+hdrezka%.com')
            and not m_simpleTV.Control.CurrentAddress:match('^https?://hdrezka%-ag%.com')
            and not m_simpleTV.Control.CurrentAddress:match('^%$rezka')
            and not m_simpleTV.Control.CurrentAddress:match('^#')
		then
		 return
		end
	local inAdr = m_simpleTV.Control.CurrentAddress
	m_simpleTV.OSD.ShowMessageT({text = '', showTime = 1000, id = 'channelName'})
	local logo = 'https://rezka.ag/templates/hdrezka/images/hdrezka-logo.png'
		local masshtab = m_simpleTV.User.paramScriptForSkin_masshtab or 1
		if m_simpleTV.User.paramScriptForSkin_background_chanel then
			background_chanel = m_simpleTV.User.paramScriptForSkin_background_chanel
		else
			background_chanel = 'https://radio-stream-1.obozrevatel.com/radiorelaxfm128.mp3'
		end
		if m_simpleTV.User.paramScriptForSkin_background1 then
			background1 = m_simpleTV.User.paramScriptForSkin_background1
		else
			background1 = ''
		end
		if m_simpleTV.User.paramScriptForSkin_background2 then
			background2 = m_simpleTV.User.paramScriptForSkin_background2
		else
			background2 = ''
		end
		local titul_rezka = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag\')"><img src="https://rezka.ag/templates/hdrezka/images/hdrezka-logo.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_hevc = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/h265.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_rezka_tor = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc\/\')"><img src="https://rezka.cc/apple-touch-icon.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_lostfilm = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.lostfilm.tv/new\/\')"><img src="https://www.lostfilm.tv/favicon.ico" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_yt = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.youtube.com/feed/channels\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="' .. 36*masshtab .. '" align="top"></a>'
	dataEN = os.date ("%a %d %b %Y %H:%M")
	dataRU = dataEN:gsub('Sun', 'Вс'):gsub('Mon', 'Пн'):gsub('Tue', 'Вт'):gsub('Wed', 'Ср'):gsub('Thu', 'Чт'):gsub('Fri', 'Пт'):gsub('Sat', 'Сб')
	dataRU = dataRU:gsub('Jan', 'Янв'):gsub('Feb', 'Фев'):gsub('Mar', 'Мар'):gsub('Apr', 'Апр'):gsub('May', 'Май'):gsub('Jun', 'Июн'):gsub('Jul', 'Июл'):gsub('Aug', 'Авг'):gsub('Sep', 'Сен'):gsub('Oct', 'Окт'):gsub('Nov', 'Ноя'):gsub('Dec', 'Дек')
	if m_simpleTV.Interface.GetLanguage() == 'ru' then data = dataRU else data = dataEn end
	portal_str = '<table width="99\%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;" colspan="3"><h3><center>' ..
	titul_rezka_tor .. titul_hevc .. ' <font color=#CD7F32><b>' .. data .. ' </b></font>' .. titul_yt .. titul_rezka .. titul_lostfilm .. '</h3></td></tr><hr></table>'
	if not inAdr:match('^%$rezka') then
		if m_simpleTV.Control.MainMode == 0 then
			m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = logo, TypeBackColor = 0, UseLogo = 1, Once = 1})
		end
	end
	local function showError(str)
		m_simpleTV.OSD.ShowMessageT({text = 'hdrezka ошибка: ' .. str, showTime = 5000, color = 0xffff1000, id = 'channelName'})
	end
	m_simpleTV.Control.ChangeAddress = 'Yes'
	m_simpleTV.Control.CurrentAddress = ''
	local session = m_simpleTV.Http.New('Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.3809.87 Safari/537.36', proxy, false)
		if not session then
			showError('1')
		 return
		end
	m_simpleTV.Http.SetTimeout(session, 16000)
	if not m_simpleTV.User then
		m_simpleTV.User = {}
	end
	if not m_simpleTV.User.rezka then
		m_simpleTV.User.rezka = {}
	end
	m_simpleTV.User.rezka.DelayedAddress = nil
	local title
	if m_simpleTV.User.rezka.titleTab then
		local index = m_simpleTV.Control.GetMultiAddressIndex()
		if index then
			title = m_simpleTV.User.rezka.title .. ' (' .. m_simpleTV.User.rezka.titleTab[index].Name .. ')'
		end
	end
	local function rezkaGetStream(adr)
		local url = m_simpleTV.User.rezka.host .. '/ajax/get_cdn_series/?t=' .. os.time()
		local body = adr:gsub('^$rezka', '') .. '&action=get_stream'
		local headers = 'X-Requested-With: XMLHttpRequest'
		local rc, answer = m_simpleTV.Http.Request(session, {url = url, method = 'post', body = body, headers = headers})
			if rc ~= 200 then return end
	 return answer
	end
	local function rezkaIndex(t)
		local lastQuality = tonumber(m_simpleTV.Config.GetValue('rezka_qlty') or 2160)
		local index = #t
			for i = 1, #t do
				if t[i].qlty >= lastQuality then
					index = i
				 break
				end
			end
		if index > 1 then
			if t[index].qlty > lastQuality then
				index = index - 1
			end
		end
	 return index
	end
    local function GetRezkaAdr(urls)
        urls = urls:gsub('\\/', '/')
        local subt = urls:match('"subtitle":"[^"]+')
        if subt then
            local s, j = {}, 1
            for w in subt:gmatch('http.-%.vtt') do
                s[j] = {}
                s[j] = w
                j = j + 1
            end
            subt = '$OPT:sub-track=0$OPT:input-slave=' .. table.concat(s, '#')
        end
        local t, i = {}, 1
        local url = urls:match('"url":"[^"]+') or urls
        local qlty, adr
            for qlty, adr in url:gmatch('%[(.-)](https?://[^%s]+)') do
                t[i] = {}
                t[i].Address = adr
                t[i].Name = qlty
                t[i].qlty = tonumber(qlty:match('%d+'))
                i = i + 1
            end
            if i == 1 then return end
        table.sort(t, function(a, b) return a.qlty < b.qlty end)
        local z = {
                {'1080p Ultra', '1080p'},
                {'1080p', '720p'},
                {'720p', '480p'},
                {'480p', '360p'},
                {'360p', '240p'},
            }
        local h = {}
            for i = 1, #t do
                t[i].Id = i
                t[i].Address = t[i].Address:gsub('^https://', 'http://'):gsub(':hls:manifest%.m3u8', '')
                        .. '$OPT:NO-STIMESHIFT$OPT:demux=mp4,any$OPT:http-referrer=https://rezka.ag/' .. (subt or '')
                for j = 1, #z do
                    if t[i].Name == z[j][1] and not h[i] then
                        t[i].Name = z[j][2]
                        h[i] = true
                    end
                end
                t[i].qlty = tonumber(t[i].Name:match('%d+'))
            end
        m_simpleTV.User.rezka.Tab = t
        local index = rezkaIndex(t)
     return t[index].Address
    end
	function OnMultiAddressOk_rezka(Object, id)
		if id == 0 then
			OnMultiAddressCancel_rezka(Object)
		else
			m_simpleTV.User.rezka.DelayedAddress = nil
		end
	end
	function OnMultiAddressCancel_rezka(Object)
		if m_simpleTV.User.rezka.DelayedAddress then
			local state = m_simpleTV.Control.GetState()
			if state == 0 then
				m_simpleTV.Control.SetNewAddress(m_simpleTV.User.rezka.DelayedAddress)
			end
			m_simpleTV.User.rezka.DelayedAddress = nil
		end
		m_simpleTV.Control.ExecuteAction(36, 0)
	end
	function Qlty_rezka()
		m_simpleTV.Control.ExecuteAction(36, 0)
		local t = m_simpleTV.User.rezka.Tab
			if not t then return end
		local index = rezkaIndex(t)
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			t.OkButton = {ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			t.ExtButton1 = {ButtonEnable = true, ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose}
		else
			t.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		end
		local ret, id = m_simpleTV.OSD.ShowSelect_UTF8('⚙ Качество', index - 1, t, 5000, 1 + 4 + 2)
		if m_simpleTV.User.rezka.isVideo == false then
			if m_simpleTV.User.rezka.DelayedAddress then
				m_simpleTV.Control.ExecuteAction(108)
			else
				m_simpleTV.Control.ExecuteAction(37)
			end
		else
			m_simpleTV.Control.ExecuteAction(37)
		end
		if ret == 1 then
			m_simpleTV.Control.SetNewAddress(t[id].Address, m_simpleTV.Control.GetPosition())
			m_simpleTV.Config.SetValue('rezka_qlty', t[id].qlty)
		end
	end
	local function xren(s)
			if not s then
			 return ''
			end
		s = s:lower()
		s = s:gsub('*', '')
		s = s:gsub('%s+', ' ')
		s = s:gsub('^%s*(.-)%s*$', '%1')
		local a = {
				{'А', 'а'}, {'Б', 'б'}, {'В', 'в'}, {'Г', 'г'}, {'Д', 'д'}, {'Е', 'е'}, {'Ж', 'ж'}, {'З', 'з'},
				{'И', 'и'},	{'Й', 'й'}, {'К', 'к'}, {'Л', 'л'}, {'М', 'м'}, {'Н', 'н'}, {'О', 'о'}, {'П', 'п'},
				{'Р', 'р'}, {'С', 'с'},	{'Т', 'т'}, {'Ч', 'ч'}, {'Ш', 'ш'}, {'Щ', 'щ'}, {'Х', 'х'}, {'Э', 'э'},
				{'Ю', 'ю'}, {'Я', 'я'}, {'Ь', 'ь'},	{'Ъ', 'ъ'}, {'Ё', 'е'},	{'ё', 'е'}, {'Ф', 'ф'}, {'Ц', 'ц'},
				{'У', 'у'}, {'Ы', 'ы'}, {':', ''}
				}
			for _, v in pairs(a) do
				s = s:gsub(v[1], v[2])
			end
	 return s
	end
	local zapros_wink_title, i_id, wink_id = '', '', ''
	if inAdr:match('^#') then
	inAdr = inAdr:gsub('^#', ''):gsub('%+', '%%2B')
	zapros_wink_title = inAdr
	if inAdr:match('^#') then
	zapros_wink_title = inAdr:gsub('^#', ''):gsub('%+', '%%2B')
	if zapros_wink_title:match('%&id=') then
	wink_id = zapros_wink_title:gsub('^.-%&id=', '')
	end
	zapros_wink_title = zapros_wink_title:gsub('%&id=.-$', '')
	m_simpleTV.OSD.ShowMessageT({text = m_simpleTV.Common.multiByteToUTF8(zapros_wink_title) .. ' | ' .. wink_id, color = 0xff9999ff, showTime = 1000 * 5})
	end
	if wink_id == '' then inAdr = m_simpleTV.Common.multiByteToUTF8(inAdr)
--	inAdr = xren(inAdr)
	inAdr = 'https://rezka.ag/index.php?do=search&subaction=search&q=' .. inAdr
	else inAdr = 'https://rezka.ag/index.php?do=search&subaction=search&q=' .. m_simpleTV.Common.multiByteToUTF8(zapros_wink_title) end
	end
	local function play(retAdr, title)
		if retAdr:match('^$rezka') then
			retAdr = rezkaGetStream(retAdr)
				if not retAdr then
					m_simpleTV.Http.Close(session)
					showError('2')
					m_simpleTV.Control.CurrentAddress = 'http://wonky.lostcut.net/vids/error_getlink.avi'
				 return
				end
		end
		retAdr = GetRezkaAdr(retAdr) or background_chanel
			if not retAdr then
				showError('3')
			 return
			end
		m_simpleTV.Control.CurrentTitle_UTF8 = title
		m_simpleTV.OSD.ShowMessageT({text = title, color = 0xff9999ff, showTime = 1000 * 5, id = 'channelName'})
		m_simpleTV.Control.CurrentAddress = retAdr
-- debug_in_file(retAdr .. '\n')
	end

		if inAdr:match('^$rezka') then
			play(inAdr, title)
		 return
		end
	m_simpleTV.User.rezka.isVideo = nil
	m_simpleTV.User.rezka.titleTab = nil
	m_simpleTV.User.rezka.host = inAdr:match('^https?://[^/]+')
	local rc, answer = m_simpleTV.Http.Request(session, {url = inAdr})
		if rc ~= 200 then
			showError('4, Профилактика на сайте')
			m_simpleTV.Http.Close(session)
			m_simpleTV.Control.CurrentAddress = background_chanel
		 return
		end
	answer = answer:gsub('<!%-%-.-%-%->', ''):gsub('/%*.-%*/', '')
	local title = answer:match('<h1 itemprop="name">([^<]+)') or answer:match('<h1><span class="t1" itemprop="name">([^<]+)') or answer:match('<head><title>(.-)</title>') or 'HDrezka'
	title = title:gsub(' смотреть онлайн бесплатно в хорошем качестве', ''):gsub(' %-', ''):gsub('Смотреть онлайн ', ''):gsub(' в хорошем качестве в 720p hd', ''):gsub('Смотреть ', ''):gsub(' в HD онлайн', ''):gsub('&quot;', '"'):gsub(' онлайн в хорошем качестве', ''):gsub(' HD, бесплатно и без регистрации', ''):gsub('720p hd и без регистрации', 'HD Rezka')
	local poster1 = './luaScr/user/westSide/genres_colored/HD REZKA.png'
	if inAdr:match('%/western%/') then poster1 = './luaScr/user/westSide/genres_colored/Western.png' end
	if inAdr:match('%/family%/') then poster1 = './luaScr/user/westSide/genres_colored/Family.png' end
	if inAdr:match('%/fantasy%/') then poster1 = './luaScr/user/westSide/genres_colored/Fantasy.png' end
	if inAdr:match('%/biographical%/') then poster1 = './luaScr/user/westSide/genres_colored/Biography.png' end
	if inAdr:match('%/arthouse%/') then poster1 = './luaScr/user/westSide/genres_colored/Independent.png' end
	if inAdr:match('%/action%/') then poster1 = './luaScr/user/westSide/genres_colored/Action.png' end
	if inAdr:match('%/military%/') then poster1 = './luaScr/user/westSide/genres_colored/War.png' end
	if inAdr:match('%/detective%/') then poster1 = './luaScr/user/westSide/genres_colored/Mystery.png' end
	if inAdr:match('%/crime%/') then poster1 = './luaScr/user/westSide/genres_colored/Crime.png' end
	if inAdr:match('%/adventures%/') then poster1 = './luaScr/user/westSide/genres_colored/Adventure.png' end
	if inAdr:match('%/drama%/') then poster1 = './luaScr/user/westSide/genres_colored/Drama.png' end
	if inAdr:match('%/sport%/') then poster1 = './luaScr/user/westSide/genres_colored/Sport.png' end
	if inAdr:match('%/fiction%/') then poster1 = './luaScr/user/westSide/genres_colored/Science Fiction.png' end
	if inAdr:match('%/comedy%/') then poster1 = './luaScr/user/westSide/genres_colored/Comedy.png' end
	if inAdr:match('%/melodrama%/') then poster1 = './luaScr/user/westSide/genres_colored/Romance.png' end
	if inAdr:match('%/thriller%/') then poster1 = './luaScr/user/westSide/genres_colored/Thriller.png' end
	if inAdr:match('%/horror%/') then poster1 = './luaScr/user/westSide/genres_colored/Horror.png' end
	if inAdr:match('%/musical%/') then poster1 = './luaScr/user/westSide/genres_colored/Musical.png' end
	if inAdr:match('%/historical%/') then poster1 = './luaScr/user/westSide/genres_colored/History.png' end
	if inAdr:match('%/documentary%/') then poster1 = './luaScr/user/westSide/genres_colored/Documentary.png' end
	if inAdr:match('%/erotic%/') then poster1 = './luaScr/user/westSide/genres_colored/Adult.png' end
	if inAdr:match('%/kids%/') then poster1 = './luaScr/user/westSide/genres_colored/Children.png' end
	if inAdr:match('%/foreign%/') then poster1 = './luaScr/user/westSide/genres_colored/Foreign.png' end
	if inAdr:match('%/cognitive%/') then poster1 = './luaScr/user/westSide/genres_colored/Nature.png' end
	if inAdr:match('%/short%/') then poster1 = './luaScr/user/westSide/genres_colored/Short.png' end
	local poster = answer:match('<div class="b%-sidecover"> <a href="([^"]+)') or answer:match('property="og:image" content="([^"]+)') or logo
	if poster == 'https://rezka.ag/i/share.jpg' then poster = poster1 end
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = poster, TypeBackColor = 0, UseLogo = 3, Once = 1})
	end
	local desc = answer:match('"og:description" content="(.-)"%s*/>') or ''
	desc = desc:gsub('"', "'"):gsub('&laquo;', '«'):gsub('&raquo;', '»')
	local desc_text = answer:match('<div class="b%-post__description_text">(.-)</div>') or ''
	desc_text = desc_text:gsub('<a.->', ''):gsub('</a>', '')
	if desc_text ~= '' then
	table_desc = '<table width="99%"><tr><td style="padding: 0px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h5>' .. desc_text .. '</h5></td></tr></table>'
	else table_desc = '' end
------------------
	local name_rus = answer:match('<h1 itemprop="name">(.-)</h1>') or answer:match('<h1><span class="t1" itemprop="name">([^<]+)') or answer:match('<div class="b%-content__htitle"> <h1>(.-)</h1>') or ''
	name_rus = name_rus:gsub(' в HD онлайн', '')
	if name_rus == '' then name_rus = title end
	local titul_page = '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/films/\')" style="color: #7FFFD4; text-decoration: none;">фильмы</a><br>' ..
	                   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/films/?filter=popular\')" style="color: #7FFFD4; text-decoration: none;">фильмы ⭐</a><br>' ..
					   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/films/?filter=watching\')" style="color: #7FFFD4; text-decoration: none;">фильмы 👁</a><br>' ..
					   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/series/\')" style="color: #7FFFD4; text-decoration: none;">сериалы</a><br>' ..
	                   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/series/?filter=popular\')" style="color: #7FFFD4; text-decoration: none;">сериалы ⭐</a><br>' ..
					   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/series/?filter=watching\')" style="color: #7FFFD4; text-decoration: none;">сериалы 👁</a><br>' ..
					   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/cartoons/\')" style="color: #7FFFD4; text-decoration: none;">мультфильмы</a><br>' ..
	                   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/cartoons/?filter=popular\')" style="color: #7FFFD4; text-decoration: none;">мультфильмы ⭐</a><br>' ..
					   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/cartoons/?filter=watching\')" style="color: #7FFFD4; text-decoration: none;">мультфильмы 👁</a><br>' ..
					   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/animation/\')" style="color: #7FFFD4; text-decoration: none;">аниме</a><br>' ..
	                   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/animation/?filter=popular\')" style="color: #7FFFD4; text-decoration: none;">аниме ⭐</a><br>' ..
					   '🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/animation/?filter=watching\')" style="color: #7FFFD4; text-decoration: none;">аниме 👁</a><br>' ..
					   '🔷 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/franchises/\')" style="color: #7FFFD4; text-decoration: none;">франшизы</a><br>' ..
					   '🔷 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag/collections/\')" style="color: #7FFFD4; text-decoration: none;">подборки</a><br>'
	local time_all = answer:match('<h2>Время</h2>:</td> <td itemprop="duration">(.-)</td>') or ''
	if time_all ~= '' then time_all = '<h5><font color=#CD7F32>' .. time_all .. '</font></h5>' end
	local t_rezka = answer:match('<div class="b%-post__status__tracker__download"> <a href="(.-)" target="') or ''
	t_rezka = t_rezka:gsub('//rezka..-/', '//rezka.cc/')
	if t_rezka == 'http://rezka.cc/' or t_rezka == ''
	then t_rezka = ''
	else t_rezka = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t_rezka .. '\')"><img src="https://rezka.cc/assets/images/favicon.ico" height="' .. 36*masshtab .. '" align="top"></a>'
	end
	local name_eng = answer:match('alternativeHeadline">(.-)</div>') or ''
	is_lostfilm = answer:match('%(LostFilm%)')
	if answer:match('<h2>В качестве</h2>') and is_lostfilm or answer:match('id="translators%-list"') and is_lostfilm then poisk_lostfilm = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.lostfilm.tv/search/?q=' .. name_eng .. '\')"><img src="https://www.lostfilm.tv/favicon.ico" height="' .. 36*masshtab .. '" align="top"></a>' else poisk_lostfilm = '' end
	if answer:match('<h2>В качестве</h2>') or answer:match('id="translators%-list"') then poisk_kinopoisk = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'*' .. name_rus .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuKP.png" height="' .. 36*masshtab .. '" align="top"></a>' else poisk_kinopoisk = '' end
	if answer:match('<h2>В качестве</h2>') or answer:match('id="translators%-list"') then poisk_youtube = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'-' .. name_rus .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="' .. 36*masshtab .. '" align="top"></a>' else poisk_youtube = '' end
	str_poisk = ' ' .. t_rezka .. poisk_lostfilm .. poisk_kinopoisk .. poisk_youtube or ''
	local mpaa = answer:match('style="color: #666;">(.-+)') or ''
	local slogan = answer:match('<h2>Слоган</h2>:</td> <td>(.-)</td>') or ''
	slogan = slogan:gsub('&laquo;', '«'):gsub('&raquo;', '»')
	local country = answer:match('<h2>Страна.-">(.-)</tr>') or ''
	country = country:gsub('<a.->', ''):gsub('</td>', ''):gsub('</a>', '')
	countryr = country
	local year = answer:match('Дата выхода.-year/(.-)/') or answer:match('Год:(.-)</tr>') or answer:match('<td class="l">(<h2>Дата рождения</h2>:.-)<div class="b%-person__career">') or ''
	year = year:gsub('<a href="https://rezka.ag/year/.->', ''):gsub('<tr>', ''):gsub('</tr>', ''):gsub('<td.->', ''):gsub('</td>', ''):gsub('</a>', ''):gsub('<h2.->', '<h5>'):gsub('</h2>', ''):gsub('</table>', ''):gsub('<div class="b%-person__gallery_holder">.-</div>', '')
------------------
	local nsp1, sp1, sp1_adr, sp1_str = 1, '', '', 'Входит в списки:'
	answer_sp1 = answer:match('<h2>Входит в списки</h2>:(.-)</tr>')
	if answer_sp1 then
	for w in answer_sp1:gmatch('<a.-</a>') do
	sp1 = w:match('<a href=".-">(.-)</a>')
	sp1_adr = w:match('<a href="(.-)"')
	if sp1 and sp1_adr then
	sp1_str = sp1_str .. '<br>🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. sp1_adr .. 	'\')" style="color: #BBBBBB; text-decoration: none;">' .. sp1 .. '</a>'
	end
	nsp1 = nsp1 + 1
	end
	else sp1_str = ''
	end
------------------
	local nsp2, sp2, sp2_adr, sp2_str = 1, '', '', 'Из серии:'
	answer_sp1 = answer:match('<h2>Из серии</h2>:(.-)</tr>')
	if answer_sp1 then
	for w in answer_sp1:gmatch('<a.-</a>') do
	sp2 = w:match('<a href=".-">(.-)</a>')
	sp2_adr = w:match('<a href="(.-)"')
	if sp2 and sp1_adr then
	sp2_str = sp2_str .. '<br>🔷 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. sp2_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">' .. sp2 .. '</a>'
	end
	nsp2 = nsp2 + 1
	end
	else sp2_str = ''
	end
------------------
	if sp1_str ~= '' or sp2_str ~= ''
	then table_sp = '<table width="99%"><tr><td style="padding: 0px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h5>' .. sp1_str ..
		 '</h5></td><td style="padding: 0px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h5>' .. sp2_str .. '</h5></td></tr></table>'
	else table_sp = ''
	end
------------------
	local k0, genres0, genres_adr, genres_str = 1, '', '', ''
	answer_genres = answer:match('<h2>Жанр</h2>:(.-)</tr>')
	if answer_genres then
	for w in answer_genres:gmatch('<a.-</a>') do
	genres0 = w:match('"genre">(.-)</span></a>')
	genres_adr = w:match('<a href="(.-)"')
	if genres0 and genres_adr then
	genres_str = genres_str .. ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">' .. genres0 .. '</a>'
	end
	k0 = k0 + 1
	end
	else genres_str = answer:match('<td class="l"><h2>Карьера</h2>:(.-)<td class="l">') or ''
	genres_str = genres_str:gsub('<a.->', ''):gsub('</a>', ''):gsub('<td.->', ''):gsub('</td>', ''):gsub('<tr>', ''):gsub('</tr>', '')
	end
	if genres_str == '' and not inAdr:match('%/franchises%/') and not inAdr:match('%/collections%/') then genres_str = titul_page end
	if inAdr == 'https://rezka.ag/franchises/' or inAdr == 'https://rezka.ag/collections/' then poster = 'https://rezka.ag/templates/hdrezka/images/hdrezka-logo.png' end
	local reting = ''
	local reting_kp = answer:match('Кинопоиск</a>: <span class="bold">(.-)</span> <i>') or ''
	if reting_kp ~= '' then reting_kp = string.format('%.' .. (1 or 0) .. 'f', reting_kp) end
	local vote_kp = answer:match('Кинопоиск</a>: <span class="bold">.-%((.-)%)') or ''
	local reting_imdb = answer:match('IMDb.-: <span class="bold">(.-)</span> <i>') or ''
	local vote_imdb = answer:match('IMDb.-: <span class="bold">.-%((.-)%)') or ''
	local reting_rezka = answer:match('class="num" itemprop="average">(.-)</span><span itemprop="worst"') or ''
	if reting_rezka ~= '' then reting_rezka = string.format('%.' .. (1 or 0) .. 'f', reting_rezka) end
	local vote_rezka = answer:match('itemprop="votes">(.-)</span> </div>') or ''
	vote_rezka = vote_rezka:gsub('%)', '')
	if reting_kp ~= '' then
	reting = reting .. '<h5><b><img src="simpleTVImage:./luaScr/user/westSide/icons/menuKP.png" height="' .. masshtab*20 .. '" align="top"><img src="simpleTVImage:./luaScr/user/westSide/stars/' .. reting_kp .. '.png" height="' .. masshtab*20 .. '" align="top"> ' .. vote_kp .. '</b></h5>'
	end
	if reting_imdb ~= '' then
	reting = reting .. '<h5><b><img src="simpleTVImage:./luaScr/user/westSide/icons/menuIMDb.png" height="' .. masshtab*20 .. '" align="top"><img src="simpleTVImage:./luaScr/user/westSide/stars/' .. reting_imdb .. '.png" height="' .. masshtab*20 .. '" align="top"> ' .. vote_imdb .. '</b></h5>'
	end
	if reting_rezka ~= '' then
	reting = reting .. '<h5><b><img src="https://rezka.cc/assets/images/favicon.ico" height="' .. masshtab*20 .. '" align="top"><img src="simpleTVImage:./luaScr/user/westSide/stars/' .. reting_rezka .. '.png" height="' .. masshtab*20 .. '" align="top"> ' .. vote_rezka .. '</b></h5>'
	end
	local k1, k2, person1, person2, person1adr, person2adr, person1str, person2str = 1, 1, '', '', '', '', '', ''
	answer1 = answer:match('<div class="persons%-list%-holder">(.-)</div>')
	if answer1 then
	for w in answer1:gmatch('<span class="person%-name%-item".-</a>') do
	person1 = w:match('"name">(.-)</span></a>')
	person1adr = w:match('<a href="(.-)"')
	if person1 and person1adr then
	person1str = person1str .. ' 🔸 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. person1adr .. '\')" style="color: #BBBBBB; text-decoration: none;">' .. person1 .. '</a>'
	end
	k1 = k1 + 1
	end
	end
	if person1str ~= '' then person1str = 'Режиссер:<font color=#BBBBBB>' .. person1str .. '</font>' end
	answer2 = answer:match('"l inline"(.-)</div>')
	if answer2 then
	for w in answer2:gmatch('<span class="person%-name%-item".-</a>') do
	person2 = w:match('"name">(.-)</span></a>')
	person2adr = w:match('<a href="(.-)"')
	if person2 and person2adr then
	person2str = person2str .. ' 🔹 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. person2adr .. '\')" style="color: #BBBBBB; text-decoration: none;">' .. person2 .. '</a>'
	end
	k2 = k2 + 1
	end
	end
	if person2str ~= '' then person2str = '<br>В ролях:<font color=#BBBBBB>' .. person2str .. '</font>' end
	if person1str ~= '' or person2str ~= '' then
	table_person = '<table width="99%"><tr><td style="padding: 0px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h5>' .. person1str .. person2str .. '</h5></td></tr></table>'
	else table_person = '' end
-- Флаги стран
                            local function get_country_flags(country_ID)
					        country_flag = '<img src="simpleTVImage:./luaScr/user/westSide/country/' .. country_ID .. '.png" height="' .. masshtab*36 .. '" align="top">'
					        return country_flag:gsub('"', "'")
							end
							local tmp_country_ID = ''
							country_ID = ''
							if country and country:match('СССР') then tmp_country_ID = 'ussr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Аргентина') then tmp_country_ID = 'ar' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австрия') then tmp_country_ID = 'at' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австралия') then tmp_country_ID = 'au' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бельгия') then tmp_country_ID = 'be' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бразилия') then tmp_country_ID = 'br' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Канада') then tmp_country_ID = 'ca' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швейцария') then tmp_country_ID = 'ch' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Китай') then tmp_country_ID = 'cn' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Гонконг') then tmp_country_ID = 'hk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Германия') then tmp_country_ID = 'de' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Дания') then tmp_country_ID = 'dk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Испания') then tmp_country_ID = 'es' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Финляндия') then tmp_country_ID = 'fi' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Франция') then tmp_country_ID = 'fr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Великобритания') then tmp_country_ID = 'gb' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Греция') then tmp_country_ID = 'gr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Ирландия') then tmp_country_ID = 'ie' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Израиль') then tmp_country_ID = 'il' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Индия') then tmp_country_ID = 'in' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Исландия') then tmp_country_ID = 'is' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Италия') then tmp_country_ID = 'it' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Япония') then tmp_country_ID = 'jp' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Южная Корея') or country and country:match('Корея Южная') then tmp_country_ID = 'kr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Мексика') then tmp_country_ID = 'mx' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Нидерланды') then tmp_country_ID = 'nl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Норвегия') then tmp_country_ID = 'no' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Польша') then tmp_country_ID = 'pl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Венгрия') then tmp_country_ID = 'hu' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Новая Зеландия') then tmp_country_ID = 'nz' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Португалия') then tmp_country_ID = 'pt' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Румыния') then tmp_country_ID = 'ro' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('ЮАР') then tmp_country_ID = 'rs' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Россия') then tmp_country_ID = 'ru' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швеция') then tmp_country_ID = 'se' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Турция') then tmp_country_ID = 'tr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Украина') then tmp_country_ID = 'ua' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('США') then tmp_country_ID = 'us' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
------------------content plus
	local j, jk, namec, adrc, logoc, infoc, yearc, genrec, ratingc, desc1, desc2, desc_top, desck = 1, 1, '', '', '', '', '', '', '', '', '', '', '<table width="99%"><tr>'
	for w in answer:gmatch('<div class="b%-content__inline_item.-"(.-</div>) </div></div>') do
				namec = w:gsub('<a href=".-"> <img', ''):match('<a href=".-">(.-)</a>'):gsub('&quot;', '"')
				adrc = w:match('<div class="b%-content__inline_item%-link"> <a href="(.-)"')
				if adrc and not adrc:match('https://rezka.ag') then adrc = 'https://rezka.ag' .. adrc end
				if adrc:match('%/films%/') then iscontent = '🎥 '
				elseif adrc:match('%/series%/') then iscontent = '📺 '
				elseif adrc:match('%/cartoons%/') then iscontent = '🐶 '
				elseif adrc:match('%/animation%/') then iscontent = '👀 '
				end
				logoc = w:match('<a href=".-"> <img src="(.-)"') or ''
				infoc = w:match('"misc">(.-)</div>') or w:match('</a> <div>(.-)</div>') or ''
				yearc = infoc:match('(.-),') or ''
				local countryd = infoc:match(', (.-),')
				genrec = infoc:match(',.-, (.-)$') or ''
				ratingc = w:match('"b%-category%-bestrating rating.-">%((.-)%)</i>') or ''
				ratingc = ratingc:gsub('&mdash;', '-')
				if ratingc ~= '' and ratingc ~= '-' then
				rating_strc = string.format('%.' .. (1 or 0) .. 'f', ratingc)
				rating_strc = '<h5><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'*' .. namec ..
				'\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuKP.png" height="' .. masshtab*24 .. '" align="top"></a><img src="simpleTVImage:./luaScr/user/westSide/stars/' .. rating_strc .. '.png" height="' .. masshtab*24 .. '" align="top"></h5>'
				else rating_strc = ''
				end
							local tmp_country_ID, country_ID = '', ''
							if countryd and countryd:match('СССР') then tmp_country_ID = 'ussr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Аргентина') then tmp_country_ID = 'ar' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Австрия') then tmp_country_ID = 'at' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Австралия') then tmp_country_ID = 'au' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Бельгия') then tmp_country_ID = 'be' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Бразилия') then tmp_country_ID = 'br' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Канада') then tmp_country_ID = 'ca' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Швейцария') then tmp_country_ID = 'ch' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Китай') then tmp_country_ID = 'cn' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Гонконг') then tmp_country_ID = 'hk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Германия') then tmp_country_ID = 'de' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Дания') then tmp_country_ID = 'dk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Испания') then tmp_country_ID = 'es' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Финляндия') then tmp_country_ID = 'fi' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Франция') then tmp_country_ID = 'fr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Великобритания') then tmp_country_ID = 'gb' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Греция') then tmp_country_ID = 'gr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Ирландия') then tmp_country_ID = 'ie' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Израиль') then tmp_country_ID = 'il' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Индия') then tmp_country_ID = 'in' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Исландия') then tmp_country_ID = 'is' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Италия') then tmp_country_ID = 'it' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Япония') then tmp_country_ID = 'jp' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Южная Корея') or countryd and countryd:match('Корея Южная') then tmp_country_ID = 'kr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Мексика') then tmp_country_ID = 'mx' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Нидерланды') then tmp_country_ID = 'nl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Норвегия') then tmp_country_ID = 'no' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Польша') then tmp_country_ID = 'pl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Венгрия') then tmp_country_ID = 'hu' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Новая Зеландия') then tmp_country_ID = 'nz' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Португалия') then tmp_country_ID = 'pt' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Румыния') then tmp_country_ID = 'ro' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('ЮАР') then tmp_country_ID = 'rs' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Россия') then tmp_country_ID = 'ru' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Швеция') then tmp_country_ID = 'se' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Турция') then tmp_country_ID = 'tr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('Украина') then tmp_country_ID = 'ua' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if countryd and countryd:match('США') then tmp_country_ID = 'us' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
------------------
				if j == 1 then desc_top = '<td style="padding: 10px 10px 10px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adrc ..
				'\')"><center><img src="' .. logoc .. '" height = "' .. masshtab*320 .. '" width = "' .. masshtab*214 .. '"></a><center>' .. rating_strc .. '<h5><font color=#00FA9A>' .. iscontent .. namec .. '</font></h5><h5><font color=#CD7F32>' .. yearc .. ' </font>'.. country_ID .. ' <font color=#BBBBBB>' .. genrec ..'</h5></td>'
				end
				if j > 1 and j <= 5 then desc1 = desc1 .. '<td style="padding: 10px 10px 10px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adrc ..
				'\')"><center><img src="' .. logoc .. '" height = "' .. masshtab*320 .. '" width = "' .. masshtab*214 .. '"></a><center>' .. rating_strc .. '<h5><font color=#00FA9A>' .. iscontent .. namec .. '</font></h5><h5><font color=#CD7F32>' .. yearc .. ' </font>'.. country_ID .. ' <font color=#BBBBBB>' .. genrec ..'</h5></td>'
				end
				if j > 5 and j <= 9 then desc2 = desc2 .. '<td style="padding: 10px 10px 10px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adrc ..
				'\')"><center><img src="' .. logoc .. '" height = "' .. masshtab*320 .. '" width = "' .. masshtab*214 .. '"></a><center>' .. rating_strc .. '<h5><font color=#00FA9A>' .. iscontent .. namec .. '</font></h5><h5><font color=#CD7F32>' .. yearc .. ' </font>'.. country_ID .. ' <font color=#BBBBBB>' .. genrec ..'</h5></td>'
				end
				if j > 9 then
				if jk == 5 then
				jk = 1 desck = desck .. '</tr></table><table width="99%"><tr>'
				end
				desck = desck .. '<td style="padding: 10px 10px 10px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adrc ..
				'\')"><center><img src="' .. logoc .. '" height = "' .. masshtab*320 .. '" width = "' .. masshtab*214 .. '"></a><center>' .. rating_strc .. '<h5><font color=#00FA9A>' .. iscontent .. namec .. '</font></h5><h5><font color=#CD7F32>' .. yearc .. ' </font>'.. country_ID .. ' <font color=#BBBBBB>' .. genrec ..'</h5></td>'
				jk = jk + 1
				end
				j = j + 1
				end
------------------
	local jj, jjk, adrs, logos, infos, descs = 1, 1, '', '', '', '<table width="99%"><tr>'
	for w in answer:gmatch('<div class="b%-content__collections_item"(.-) </div></div>') do
				names = w:match('class="title">(.-)</a>'):gsub('&quot;', '"')
				adrs = w:match('<a href="(.-)"')
				logos = w:match('src="(.-)"') or ''
				infos = w:match('class="num hd%-tooltip">(.-)</div>') or ''
				if jjk == 5 then
				jjk = 1 descs = descs .. '</tr></table><table width="99%"><tr>'
				end
				descs = descs .. '<td style="padding: 5px 10px 10px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adrs ..
				'\')"><center><img src="' .. logos .. '" height = "' .. masshtab*120 .. '" width = "' .. masshtab*214 .. '"></a><center><h5><font color=#00FA9A>' .. names ..
				'</font><font color=#CD7F32> (' .. infos .. ')</font></h5></td>'
				jjk = jjk + 1
				jj = jj + 1
				end
------------------
	local page_str = ''
	answer_page = answer:match('<div class="b%-navigation">(.-)</div>')
	if answer_page then
	answer_page = answer_page:gsub('&amp;', '&')
	answer_page = m_simpleTV.Common.multiByteToUTF8(answer_page)
	answer_page = answer_page:gsub('<span class="b%-navigation__prev i%-sprt">&nbsp;</span>', '«'):gsub('<span class="b%-navigation__next i%-sprt">&nbsp;</span>', '»')
	answer_page = answer_page:gsub('<a href="', '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress%(\''):gsub('<a rel="nofollow" href="', '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress%(\''):gsub('">', '\'\)" style="color: #BBBBBB; text-decoration: none;">')
	page_str = '<font color=#EBEBEB>Серфинг по страницам: </font>' .. answer_page
	page_str = '<table width="99%"><tr><td style="color: #CD7F32;"><center><h4>' .. page_str .. '</h4></td></tr></table>'
	else page_str = ''
	end
------------------
	local nfrn, name_frn_adr, numb_frn, year_frn, rating_frn, vote_frn, frn, frn_adr, frn_str = 1, '', '', '', '', '', '', '', ''
	name_frn = answer:match('<div class="b%-sidetitle">(.-</a>)')
	if name_frn then
	name_frn_adr = name_frn:match('href="(.-)"') or ''
	name_frn = name_frn:match('class="b%-post__franchise_link_title">(.-)</a>') or ''
	frn_str = 'Части франшизы: <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. name_frn_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">(' .. name_frn .. ')</a>'
	else frn_str = ''
	end
	answer_frn = answer:match('<div class="b%-post__partcontent"> (.-) </div>') or answer:match('<div class="b%-post__partcontent big"> (.-) </div>')
	if answer_frn then
	for w in answer_frn:gmatch('<div class="b%-post__partcontent_item.-</div></div>') do
	numb_frn = w:match('<div class="td num">(.-)</div>')
	if numb_frn ~= '' then numb_frn = numb_frn .. '. ' end
	year_frn = w:match('<div class="td year">(.-)</div>')
	if year_frn ~= '' then year_frn = ' (' .. year_frn:gsub(' год', '') .. ')' end
	rating_frn = w:match('title="Рейтинг Кинопоиска.->(.-)</i></div>')
	if rating_frn and rating_frn ~= '' then rating_frn = ' КП: ' .. rating_frn else rating_frn = '' end
	vote_frn = w:match('title="Рейтинг Кинопоиска на основе (.-) голос')
	if vote_frn and vote_frn ~= '' then vote_frn = ' - ' .. vote_frn else vote_frn = '' end
	frn = w:match('<a href=".-">(.-)</a>') or w:match('<div class="td title">(.-)</div>')
	frn_adr = w:match('<a href="(.-)"')
	if frn and frn_adr then
	frn_str = frn_str .. '<br>🔶 ' .. numb_frn .. ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. frn_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">' .. frn .. '</a>' .. year_frn .. rating_frn .. vote_frn
	else frn_str = frn_str .. '<br>🔷 ' .. numb_frn .. frn .. year_frn .. rating_frn .. vote_frn
	end
	nfrn = nfrn + 1
	end
	frn_str = '<table width="99%"><tr><td style="padding: 5px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h5>' .. frn_str .. '</h5></td></tr></table>'
	else frn_str = ''
	end
------------------блок названий и дат серий
	local function slogan_episode(number)
	answer_episode = answer:match('<table class="b%-post__schedule_table">.-<div id="addcomment%-title"')
	if answer_episode then
	local ie, te = 1, {}
	for w in answer_episode:gmatch('<tr.-</tr>') do
	te[ie] = {}
	te[ie].number_episode = w:match('<td class="td%-1".->(.-)</td>')
	te[ie].name_episode = w:match('<td class="td%-2"><b>(.-)</b>') or ''
	te[ie].name_episode = te[ie].name_episode:gsub('&#237', 'i'):gsub('&#233;', 'e')
	if te[ie].name_episode then te[ie].name_episode = ' | ' .. te[ie].name_episode end
	te[ie].data_episode = w:match('<td class="td%-4">(.-)</td>') or ''
	slog = te[ie].name_episode .. ' | ' .. te[ie].data_episode
	if te[ie].number_episode == number then return slog end
	ie = ie + 1
	end
	end
	return ''
	end
------------------
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(poster, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title, m_simpleTV.Control.ChannelID, false)
	end
	m_simpleTV.Control.SetTitle(title)

------------------блок wink
	local adr_zapros_wink = decode64('aHR0cHM6Ly9pdHYucnQucnUvYXBpL3YxL3NlYXJjaC9hdXRvc3VnZ2VzdD9xPQ==')
	if zapros_wink_title ~= '' then
	zapros_wink0 = zapros_wink_title:gsub('%+', '%%2B')
	zapros_wink0 = m_simpleTV.Common.multiByteToUTF8(zapros_wink0)
	else
	zapros_wink0 = name_rus:gsub('%+', '%%2B') end
--	zapros_wink0 = xren(zapros_wink0)
	if inAdr:match('%/person%/')
	or inAdr:match('%/franchises%/')
	or inAdr:match('%/collections%/')
	or not inAdr:match('%/(%d+)') then
	zapros_wink0 = ''
	end
	if zapros_wink_title ~= '' then
	zapros_wink0 = zapros_wink_title:gsub('%+', '%%2B')
	zapros_wink0 = m_simpleTV.Common.multiByteToUTF8(zapros_wink0)
	end
	zapros_wink = adr_zapros_wink .. zapros_wink0
	local rc, answer_wink = m_simpleTV.Http.Request(session, {url = zapros_wink})
		if rc ~= 200 then
			showError('Wink')
			m_simpleTV.Http.Close(session)
		 return
		end
	require 'json'
	answer_wink = answer_wink:gsub('%[%]', '""')
	answer_wink = answer_wink:gsub('null', '""')
	local tabw = json.decode(answer_wink)
	if not tabw or not tabw.content then return end
		local tw, jw, jkw, x_wink, y_wink, z_wink, inw, country, iscontentw, rating_strw = {}, 1, 1, '0', '0', '0', '0', '', '', ''
		while true do
		if not tabw.content[jw] then break end
		tw[jw] = {}
			tw[jw].Id = tabw.content[jw].id
			tw[jw].namew = tabw.content[jw].name
			tw[jw].adrw =  '##' .. tw[jw].namew .. '&id=' .. tw[jw].Id
			tw[jw].yearw = tabw.content[jw].year or ''
			tw[jw].posterw = tabw.content[jw].poster or ''
				if tw[jw].posterw and tw[jw].posterw ~= '' then tw[jw].posterw = 'http://sdp.svc.iptv.rt.ru:8080/images/' .. tw[jw].posterw else tw[jw].posterw = 'https://wink.rt.ru/apple-touch-icon.png' end
			tw[jw].logow = tabw.content[jw].screenshot or ''
				if tw[jw].logow and tw[jw].logow ~= '' then tw[jw].logow = 'http://sdp.svc.iptv.rt.ru:8080/images/' .. tw[jw].logow else logow = 'https://wink.rt.ru/apple-touch-icon.png' end
			tw[jw].countryw = tabw.content[jw].country or ''
			countryw = tw[jw].countryw
			tw[jw].mpaa = tabw.content[jw].age_level or ''
			tw[jw].rating_w = tabw.content[jw].rating or ''
			tw[jw].rating_imdb_w = tabw.content[jw].rating_imdb or ''
			tw[jw].rating_kinopoisk_w = tabw.content[jw].rating_kinopoisk or ''
			tw[jw].rating_middle_w = tabw.content[jw].rating_middle or ''
			tw[jw].director_w = tabw.content[jw].director or ''
			tw[jw].actors_w = tabw.content[jw].actors or ''
			tw[jw].age_level_w = tabw.content[jw].age_level or ''
			tw[jw].type_w = tabw.content[jw].type or ''
			tw[jw].kind_w = tabw.content[jw].kind or ''
				if tw[jw].kind_w and tw[jw].kind_w == 'film' then iscontentw = '🎥 '
				elseif tw[jw].kind_w and tw[jw].kind_w == 'serial' then iscontentw = '📺 '
				elseif tw[jw].kind_w and tw[jw].kind_w == 'cartoon' then iscontentw = '🐶 '
				end
			tw[jw].iscontentw = iscontentw
			if tabw.content[jw].genres and tabw.content[jw].genres[1]
			then tw[jw].genres_w = tabw.content[jw].genres[1].name:gsub('%/', ', ')
			else tw[jw].genres_w = ''
			end
				if tw[jw].rating_middle_w ~= '' then
				rating_strw = string.format('%.' .. (1 or 0) .. 'f', tw[jw].rating_middle_w)
				rating_strw = '<h5><img src="simpleTVImage:./luaScr/user/westSide/icons/menuWINK.png" height="' .. masshtab*24 .. '" align="top"><img src="simpleTVImage:./luaScr/user/westSide/stars/' .. rating_strw .. '.png" height="' .. masshtab*24 .. '" align="top"></h5>'
				else rating_strw = ''
				end
			tw[jw].rating_strw = rating_strw
            local function get_country_flags(country_ID)
				country_flag = '<img src="simpleTVImage:./luaScr/user/westSide/country/' .. country_ID .. '.png" height="' .. masshtab*36 .. '" align="top">'
				return country_flag:gsub('"', "'")
			end
			local tmp_country_ID, country_ID = '', ''
				if countryw and countryw:match('СССР') then tmp_country_ID = 'ussr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Аргентина') then tmp_country_ID = 'ar' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Австрия') then tmp_country_ID = 'at' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Австралия') then tmp_country_ID = 'au' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Бельгия') then tmp_country_ID = 'be' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Бразилия') then tmp_country_ID = 'br' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Канада') then tmp_country_ID = 'ca' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Швейцария') then tmp_country_ID = 'ch' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Китай') then tmp_country_ID = 'cn' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Гонконг') then tmp_country_ID = 'hk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Германия') then tmp_country_ID = 'de' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Дания') then tmp_country_ID = 'dk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Испания') then tmp_country_ID = 'es' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Финляндия') then tmp_country_ID = 'fi' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Франция') then tmp_country_ID = 'fr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Великобритания') then tmp_country_ID = 'gb' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Греция') then tmp_country_ID = 'gr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Ирландия') then tmp_country_ID = 'ie' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Израиль') then tmp_country_ID = 'il' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Индия') then tmp_country_ID = 'in' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Исландия') then tmp_country_ID = 'is' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Италия') then tmp_country_ID = 'it' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Япония') then tmp_country_ID = 'jp' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Южная Корея') or countryw and countryw:match('Корея Южная') then tmp_country_ID = 'kr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Мексика') then tmp_country_ID = 'mx' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Нидерланды') then tmp_country_ID = 'nl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Норвегия') then tmp_country_ID = 'no' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Польша') then tmp_country_ID = 'pl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Венгрия') then tmp_country_ID = 'hu' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Новая Зеландия') then tmp_country_ID = 'nz' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Португалия') then tmp_country_ID = 'pt' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Румыния') then tmp_country_ID = 'ro' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('ЮАР') then tmp_country_ID = 'rs' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Россия') then tmp_country_ID = 'ru' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Швеция') then tmp_country_ID = 'se' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Турция') then tmp_country_ID = 'tr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('Украина') then tmp_country_ID = 'ua' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
				if countryw and countryw:match('США') then tmp_country_ID = 'us' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
			tw[jw].country_ID = country_ID
				if xren(tw[jw].namew:gsub(':', ''):gsub('%.', ''):gsub(' HD', ''):gsub('и', 'i'):gsub('И', 'I'):gsub('ё', 'е'):gsub('Ё', 'Е'):gsub('%+', '%%2B')):gsub(' %(.-$', '') == xren(zapros_wink0:gsub(':', ''):gsub('%.', ''):gsub('и', 'i'):gsub('И', 'I'):gsub('ё', 'е'):gsub('Ё', 'Е'):gsub('%+', '%%2B')) or
					tw[jw].namew:gsub(':', ''):gsub('%.', ''):gsub(' HD', ''):gsub(' %(.-$', ''):gsub('и', 'i'):gsub('И', 'I'):gsub('ё', 'е'):gsub('Ё', 'Е'):gsub('%+', '%%2B') == zapros_wink0:gsub(':', ''):gsub('%.', ''):gsub('и', 'i'):gsub('И', 'I'):gsub('ё', 'е'):gsub('Ё', 'Е'):gsub('%+', '%%2B')
				then x_wink = '1' else x_wink = '0' end
				year_tmp = year:gsub('%- %.%.%.', ''):gsub('%-.-$', '')
				if tw[jw].yearw and year_tmp and tw[jw].yearw == year_tmp then
				y_wink = '1' else y_wink = '0' end
				if tw[jw].yearw and year_tmp and tw[jw].yearw ~= '' and year  ~= '' and math.abs(tonumber(tw[jw].yearw) - tonumber(year_tmp)) == 1
				then z_wink = '1' else z_wink = '0' end
				if x_wink == '1' and y_wink == '1' and z_wink == '0' then inw = '10' logo = tw[jw].logow end
				if x_wink == '1' and y_wink == '0' and z_wink == '1' then inw = '8' logo = tw[jw].logow end
				if x_wink == '1' and y_wink == '0' and z_wink == '0' then inw = '6' end
				if inw == nill or inw == '' then inw = '0' end
				tw[jw].inw = inw or '0'
		jw = jw + 1
		end
		table.sort(tw, function(a, b) return a.genres_w > b.genres_w end)
		local hash, tw1 = {}, {}
			for i = 1, #tw do
				if not hash[tw[i].namew]
				then
					tw1[#tw1 + 1] = tw[i]
					hash[tw[i].namew] = true
				end
			end
		table.sort(tw1, function(a, b) return a.namew < b.namew end)
--		table.sort(tw1, function(c, d) return c.inw > d.inw end)
	wink_str = '<table width="99%"><tr><td style="color: #C5D0E6"><center><h3>Запрос WINK: <font color=#CD7F32>' ..
	zapros_wink0:gsub('%%2B', '+') .. '</font><br> индекс совпадения: <font color=#CD7F32>' .. inw .. '</font></h3></td></tr></table><table width="99%"><tr>'
			for i = 1, #tw1 do
			if jkw == 5 then
				jkw = 1 wink_str = wink_str .. '</tr></table><table width="99%"><tr>'
			end
				wink_str = wink_str .. '<td style="padding: 10px 10px 10px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. tw1[i].adrw ..
				'\')"><center><img src="' .. tw1[i].posterw .. '" height = "' .. masshtab*320 .. '" width = "' .. masshtab*214 .. '"></a><center>' .. tw1[i].rating_strw .. '<h5><font color=#00FA9A>' .. tw1[i].iscontentw .. tw1[i].namew ..
				'</font></h5><h5><font color=#CD7F32>' .. tw1[i].yearw .. ' </font>'.. tw1[i].country_ID .. ' <font color=#BBBBBB>' .. tw1[i].genres_w ..'</h5></td>'
				jkw = jkw + 1
				if tw1[i].Id == wink_id then i_id = i end
			end
--			if zapros_wink0 ~= '' then
--	m_simpleTV.OSD.ShowMessageT({text = 'Запрос WINK: ' .. zapros_wink0:gsub('%%2B', '+') .. ', индекс совпадения - ' .. inw, showTime = 30000, color = 0xffff1000})
--			end
------------------конец блока WINK
	local tr = answer:match('<ul id="translators%-list".-</ul>')
	if tr then
		local t, i = {}, 1
			for w in tr:gmatch('<li.-</li>') do
				local name = w:match('title="([^"]+)')
				local Adr = w:match('data%-translator_id="([^"]+)')
					if not name or not Adr then break end
				t[i] = {}
				t[i].Id = i
				t[i].Name = name
				t[i].Address = Adr
				i = i + 1
			end
			if i == 1 then return end
		if i > 2 then
		local _, id = m_simpleTV.OSD.ShowSelect_UTF8('Выберите перевод - ' .. title, 0, t, 5000, 1)
			id = id or 1
			tr = t[id].Address
		else
			tr = t[1].Address
		end
	end
	local id = inAdr:match('%/(%d+)') or background_chanel
		if inAdr:match('%/person%/') or inAdr:match('%/franchises%/') or inAdr:match('%/collections%/') then
			id = background_chanel
		end
	if not tr then
		tr = answer:match('initCDNSeriesEvents%(' .. id .. ',%s*(%d+)') or 0
	end
	local url = m_simpleTV.User.rezka.host .. '/ajax/get_cdn_series/?t=' .. os.time()
	local body = 'id=' .. id .. '&translator_id=' .. tr .. '&action=get_episodes'
	local headers = 'X-Requested-With: XMLHttpRequest'
	local rc, answer0 = m_simpleTV.Http.Request(session, {url = url, method = 'post', body = body, headers = headers})
		if rc ~= 200 then
			showError('6')
			m_simpleTV.Http.Close(session)
		 return
		end
	local serial
	if answer0:match('"success":true') then
		serial = true
	else
		serial = answer:match('<li class="b%-simple_episode__item')
		if serial then
			answer0 = answer
		end
	end
	if serial then
		answer0 = unescape3(answer0)
		answer0 = answer0:gsub('\\/', '/')
		answer0 = answer0:gsub('\\', '')
		local t, i = {}, 1
		local data_id, season_id, episode_id
			for w in answer0:gmatch('<li class="b%-simple_episode__item.-</li>') do
				data_id = w:match('data%-id="(%d+)')
				season_id = w:match('season_id="(%d+)')
				episode_id = w:match('episode_id="(%d+)')
				if data_id and season_id and episode_id then
					t[i] = {}
					t[i].Id = i
					t[i].Name = season_id .. ' сезон ' .. episode_id .. ' серия'
					t[i].Address = string.format('$rezkaid=%s&translator_id=%s&season=%s&episode=%s'
								, data_id
								, tr
								, season_id
								, episode_id)
					t[i].InfoPanelDesc = '<html><body bgcolor="#434750" style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG01_1080p.png);"><table width="99%"><tr><td style="padding: 10px 10px 5px;"><img src="' .. poster ..
					'" width="' .. masshtab*300 .. '"></td><td style="padding: 0px 5px 10px; color: #EBEBEB; vertical-align: middle;" width="' .. masshtab*266 .. '"><h5><i><font color=#EBEBEB>' .. slogan .. '</font></i>  <b><font color=#CD7F32>' .. mpaa .. '</font></b></h5><h4><font color=#00FA9A>' .. name_rus .. '</font></h4><h4>' .. str_poisk .. '</h4><h5><font color=#BBBBBB>' .. name_eng ..
					'<h5>' .. country_ID .. ' ' .. countryr .. ' <font color=#CD7F32>' .. year .. '</font></h5><h5><font color=#BBBBBB>' .. genres_str .. '</font></h5>' .. reting .. time_all .. '</td>' .. desc_top ..
					'</tr></table>' .. table_person .. table_sp .. frn_str .. table_desc .. '<table width="99%"><tr>' .. desc1 .. '</tr></table><table width="99%"><tr>' .. desc2 .. '</tr></table>' .. descs .. '</tr></table>' .. wink_str .. '</tr></table>' .. page_str .. '</html>'
					t[i].InfoPanelDesc = t[i].InfoPanelDesc:gsub('"', '\"')
					t[i].InfoPanelName = title .. ' (' .. t[i].Name .. ')'
					if slogan ~= '' then t[i].InfoPanelTitle = slogan else t[i].InfoPanelTitle = desc end
					t[i].InfoPanelTitle = t[i].InfoPanelTitle .. slogan_episode(t[i].Name)
					t[i].InfoPanelShowTime = 30000
					t[i].InfoPanelLogo = poster
					i = i + 1
				end
			end
			if i == 1 then
				showError('7')
			 return
			end
		if #t > 10 then
			t.ExtParams = {FilterType = 1}
		else
			t.ExtParams = {FilterType = 2}
		end
		table.sort(t, function(a, b) return a.Id < b.Id end)
		m_simpleTV.User.rezka.titleTab = t
		if m_simpleTV.User.paramScriptForSkin_buttonOptions then
			t.ExtButton0 = {ButtonEnable = true, ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOptions, ButtonScript = 'Qlty_rezka()'}
		else
			t.ExtButton0 = {ButtonEnable = true, ButtonName = '⚙', ButtonScript = 'Qlty_rezka()'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			t.OkButton = {ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			t.ExtButton1 = {ButtonEnable = true, ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_rezka()'}
		else
			t.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_rezka()'}
		end
		t.ExtParams = {}
		t.ExtParams.LuaOnCancelFunName = 'OnMultiAddressCancel_rezka'
		t.ExtParams.LuaOnOkFunName = 'OnMultiAddressOk_rezka'
		t.ExtParams.LuaOnTimeoutFunName = 'OnMultiAddressCancel_rezka'
		local pl
		if #t > 1 then
			pl = 0
		else
			pl = 32
		end
		m_simpleTV.OSD.ShowSelect_UTF8(title, 0, t, 10000, 2 + 64 + pl)
		local retAdr = rezkaGetStream(t[1].Address)
			if not retAdr then
				m_simpleTV.Http.Close(session)
				showError('7.1')
				m_simpleTV.Control.CurrentAddress = 'http://wonky.lostcut.net/vids/error_getlink.avi'
			 return
			end
		retAdr = GetRezkaAdr(retAdr)
			if not retAdr then
				m_simpleTV.Http.Close(session)
				showError('7.2')
				m_simpleTV.Control.CurrentAddress = 'http://wonky.lostcut.net/vids/error_getlink.avi'
			 return
			end
		m_simpleTV.User.rezka.DelayedAddress = retAdr
		m_simpleTV.User.rezka.title = title
		title = title .. ' - ' .. m_simpleTV.User.rezka.titleTab[1].Name
		if #t > 1 then
			inAdr = 'wait'
			m_simpleTV.User.rezka.isVideo = false
		else
			inAdr = retAdr
		end
		m_simpleTV.Control.CurrentTitle_UTF8 = title
		m_simpleTV.OSD.ShowMessageT({text = title, color = 0xff9999ff, showTime = 1000 * 5, id = 'channelName'})
		m_simpleTV.Control.CurrentAddress = inAdr
	 return
	else
        body = 'id=' .. id .. '&translator_id=' .. tr .. '&action=get_movie'
        rc, inAdr = m_simpleTV.Http.Request(session, {url = url, method = 'post', body = body, headers = headers})
            if rc ~= 200 then
                showError('8')
                m_simpleTV.Http.Close(session)
            return
            end
        if not inAdr:match('"success":true') then
            inAdr = answer:match('data%-translator_id="' .. tr .. '"%s+data%-cdn_url="([^"]+)') or answer:match('"streams":"([^"]+)') or background_chanel
		end
		local t = {}
		if inAdr ~= background_chanel then portal_str = ''  wink_str = wink_str .. '</tr></table>' else wink_str = '' end
		t[1] = {}
		t[1].Id = 1
		t[1].Name = title
		if slogan ~= '' then t[1].InfoPanelTitle = slogan else t[1].InfoPanelTitle = desc end
		t[1].InfoPanelName = title
		t[1].InfoPanelShowTime = 60000
		t[1].InfoPanelLogo = logo or poster
		t[1].InfoPanelDesc = '<html><body bgcolor="#434750" style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG01_1080p.png);">' .. portal_str .. '<table width="99%"><tr><td style="padding: 10px 10px 5px;"><center><img src="' .. poster ..
		'" width="' .. masshtab*300 .. '"></td><td style="padding: 0px 5px 10px; color: #EBEBEB; vertical-align: middle;" width="' .. masshtab*266 .. '"><h5><i><font color=#EBEBEB>' .. slogan .. '</font></i>  <b><font color=#CD7F32>' .. mpaa .. '</font></b></h5><h4><font color=#00FA9A>' .. name_rus .. '</font></h4><h4>' .. str_poisk .. '</h4><h5><font color=#BBBBBB>' .. name_eng ..
		'<h5>' .. country_ID .. ' ' .. countryr .. ' <font color=#CD7F32>' .. year .. '</font></h5><h5><font color=#BBBBBB>' .. genres_str .. '</font></h5>' .. reting .. time_all .. '</td>' .. desc_top ..
		'</tr></table>' .. table_person .. table_sp .. frn_str .. table_desc .. '<table width="99%"><tr>' .. desc1 .. '</tr></table><table width="99%"><tr>' .. desc2 .. '</tr></table>' .. desck .. '</tr></table>' .. descs .. '</tr></table>' .. wink_str .. page_str .. '</html>'
		t[1].InfoPanelDesc = t[1].InfoPanelDesc:gsub('"', '\"')
		t[1].InfoPanelTitle = t[1].InfoPanelTitle:gsub('"', '%%22')
------------------
		if m_simpleTV.User.paramScriptForSkin_buttonOptions then
			t.ExtButton0 = {ButtonEnable = true, ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOptions, ButtonScript = 'Qlty_rezka()'}
		else
			t.ExtButton0 = {ButtonEnable = true, ButtonName = '⚙', ButtonScript = 'Qlty_rezka()'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			t.OkButton = {ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			t.ExtButton1 = {ButtonEnable = true, ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_rezka()'}
		else
			t.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_rezka()'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			t.OkButton = {ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		m_simpleTV.OSD.ShowSelect_UTF8('HDrezka', 0, t, 8000, 32 + 64 + 128)
	end
	play(inAdr, title)
	if inAdr == background_chanel then
	m_simpleTV.Control.ExecuteAction(108,0)
	m_simpleTV.Control.ExecuteAction(108,1) end