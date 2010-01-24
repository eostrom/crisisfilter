require 'yaml'

SETTINGS = YAML::load(File.open("config/settings.yml"))

#.symbolize_keys

SETTINGS.each do |k,v|
  sym = k.respond_to?(:to_sym) ? k.to_sym : k
  SETTINGS[sym] = v
  SETTINGS.delete(k) unless k == sym
end


