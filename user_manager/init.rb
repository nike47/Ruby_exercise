#!/usr/bin/env ruby

require_relative 'classes/user_manager.rb'

user = UserManager.new('assets/users.csv')
# user.search('nikhil')
# user.sort('id','ASC').search('nikhil').limit(2).show
# user.limit(3)
user.search('nikhil').limit(2).offset(1).write