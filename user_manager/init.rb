#!/usr/bin/env ruby

require_relative 'classes/user_manager.rb'

user = UserManager.load('assets/users.csv')

# user.sort('id','ASC').search('nikhil').limit(2).show

user.search('nikhil').offset(3).limit(2).write