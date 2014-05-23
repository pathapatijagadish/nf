class Question < ActiveRecord::Base

#attr_accessible :subject,:content

belongs_to :project

end
