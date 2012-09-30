# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require
require 'bubble-wrap/location'
require 'bubble-wrap/reactor'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'DuNordMap'
  app.frameworks += ['CoreLocation']
  #app.info_plist['UIStatusBarHidden'] = true
  app.prerendered_icon = true
  app.icons = %w{Icon-57.png Icon-114.png}
end
