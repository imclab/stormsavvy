# Loads yaml password configuration file based on Railscasts #85
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]