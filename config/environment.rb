# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
#config.gem "paperclip"
#config.gem "aws-s3", :version => ">= 0.6.2", :lib => "aws/s3"  (ignore if you are using local storage).
Rails.application.initialize!
require 'RMagick'
