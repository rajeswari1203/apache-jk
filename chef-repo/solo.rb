current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
cookbook_path File.join(File.dirname(File.expand_path(__FILE__)), "cookbooks")
json_attribs File.join(File.dirname(File.expand_path(__FILE__)), "node.json")
