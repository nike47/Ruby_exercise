#!/usr/bin/env ruby

require_relative 'classes/user_manager.rb'

user = UserManager.new('assets/users.csv')
# user.search('nikhil')
user.sort('id','DESC').limit(1).write
# user.limit(3)
# user.write