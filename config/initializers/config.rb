# optional external configuration file path:
EXTERNAL_CONFIG_FILE_PATH = "#{Rails.root}/config/application.yml"
#
# see if it exists
config_file_exists = FileTest.exists?(EXTERNAL_CONFIG_FILE_PATH)
#
case
when config_file_exists
# if it does exist, load it
APPLICATION_CONFIG = YAML.load_file(EXTERNAL_CONFIG_FILE_PATH)[Rails.env]
#
when !config_file_exists && ( Rails.env=='development' || Rails.env=='test' )
# otherwise use some sensible defaults, but only for dev or test
APPLICATION_CONFIG = {
    #'a map' => 'of config values'
}
#
else
#if on prod, raise an error
raise "#{EXTERNAL_CONFIG_FILE_PATH} configuration file is missing"
end