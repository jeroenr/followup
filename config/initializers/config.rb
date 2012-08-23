# optional external configuration file path:
EXTERNAL_CONFIG_FILE_PATH = "#{::Rails.root.to_s}/config/application.yml"
#
# see if it exists
config_file_exists = FileTest.exists?(EXTERNAL_CONFIG_FILE_PATH)
#
case
when config_file_exists
# if it does exist, load it
Followup::Application.config.application = YAML.load_file(EXTERNAL_CONFIG_FILE_PATH)[::Rails.env]
#
when !config_file_exists && ( ::Rails.env=='development' || ::Rails.env=='test' )
# otherwise use some sensible defaults, but only for dev or test
Followup::Application.config.application = {
    #'a map' => 'of config values'
}
#
else
#if on prod, raise an error
raise "#{EXTERNAL_CONFIG_FILE_PATH} configuration file is missing"
end