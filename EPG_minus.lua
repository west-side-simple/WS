local val =  tonumber(m_simpleTV.Config.GetValue('controlpanelBase/timeRangeForEpgSlider','simpleTVConfig') or 4)
if val > 2 and val < 13 then
  m_simpleTV.Config.SetValue('controlpanelBase/timeRangeForEpgSlider',val-1,'simpleTVConfig')
end
m_simpleTV.Config.Apply(29)
m_simpleTV.Common.Wait(1000)
val =  tonumber(m_simpleTV.Config.GetValue('controlpanelBase/timeRangeForEpgSlider','simpleTVConfig'))
if m_simpleTV.Interface.GetLanguage() == 'ru' then
if val == 2 or val == 3 or val == 4 then
m_simpleTV.OSD.ShowMessageT({text='Текущее значение EPG слайдера: ' 
.. m_simpleTV.Config.GetValue('controlpanelBase/timeRangeForEpgSlider','simpleTVConfig') .. ' часа',id='wsEpg'})
else
m_simpleTV.OSD.ShowMessageT({text='Текущее значение EPG слайдера: ' 
.. m_simpleTV.Config.GetValue('controlpanelBase/timeRangeForEpgSlider','simpleTVConfig') .. ' часов',id='wsEpg'})
end
elseif m_simpleTV.Interface.GetLanguage() == 'en' then
if val == 2 or val == 3 or val == 4 then
m_simpleTV.OSD.ShowMessageT({text='Current EPG Slider Value: ' 
.. m_simpleTV.Config.GetValue('controlpanelBase/timeRangeForEpgSlider','simpleTVConfig') .. ' hours',id='wsEpg'})
else
m_simpleTV.OSD.ShowMessageT({text='Current EPG Slider Value: ' 
.. m_simpleTV.Config.GetValue('controlpanelBase/timeRangeForEpgSlider','simpleTVConfig') .. ' ghours',id='wsEpg'})
end 
elseif m_simpleTV.Interface.GetLanguage() == 'pl' then
if val == 2 or val == 3 or val == 4 then
m_simpleTV.OSD.ShowMessageT({text='Aktualna wartość suwaka EPG: ' 
.. m_simpleTV.Config.GetValue('controlpanelBase/timeRangeForEpgSlider','simpleTVConfig') .. ' godziny',id='wsEpg'})
else
m_simpleTV.OSD.ShowMessageT({text='Aktualna wartość suwaka EPG: ' 
.. m_simpleTV.Config.GetValue('controlpanelBase/timeRangeForEpgSlider','simpleTVConfig') .. ' godzin',id='wsEpg'})
end
end