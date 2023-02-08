---@type StaxLocale
Locale = {}

local isServer = IsDuplicityVersion()

if isServer then
  StaxEvent.CreateEvent("STAX::Core::Shared::LocaleListener", function(resource, locale)
    if GetCurrentResourceName() ~= resource then return end
    Locale = StaxLocale.Class(locale)
  end)
else
  StaxEvent.CreateNetEvent("STAX::Core::Shared::LocaleListener", function(resource, locale)
    if GetCurrentResourceName() ~= resource then return end
    Locale = StaxLocale.Class(locale)
  end)
end

print("________________________________________")
print("SHOWING ALL OF YOUR LOCALES HERE")
print("________________________________________")
print(json.encode(Locale.Storage))
print("________________________________________")