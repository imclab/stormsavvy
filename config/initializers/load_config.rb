# Loads yaml password configuration file based on Railscasts #85
if Rails.env == "development"
	APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
end