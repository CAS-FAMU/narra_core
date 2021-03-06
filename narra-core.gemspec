#
# Copyright (C) 2017 CAS / FAMU
#
# This file is part of Narra Core.
#
# Narra Core is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Narra Core is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Narra Core. If not, see <http://www.gnu.org/licenses/>.
#
# Authors: Michal Mocnak <michal@marigan.net>
#

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "narra/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "narra-core"
  spec.version     = Narra::Core::VERSION
  spec.authors     = ["Michal Mocnak", "Krystof Pesek", "Petr Pulc"]
  spec.email       = ["info@narra.eu"]
  spec.homepage    = "http://www.narra.eu"
  spec.summary     = "NARRA Core functionality"
  spec.description = "NARRA Core functionality which covers all the NARRA data model, logic and SPI."
  spec.license     = "GPL-3.0"

  spec.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  spec.test_files = Dir["spec/**/*"]

  spec.add_dependency "rails", "~> 5.1.2"
  spec.add_dependency "mongoid", "< 7.0.0"
  spec.add_dependency "aasm"
  spec.add_dependency "sidekiq"
  spec.add_dependency "redis-namespace"
  spec.add_dependency "activesupport"
  spec.add_dependency "fog-aws"
  spec.add_dependency "fog-google"
  spec.add_dependency "google-api-client", "~> 0.8.6"
  spec.add_dependency "mime-types"
  spec.add_dependency "wisper"
  spec.add_dependency "sinatra"
  spec.add_dependency "streamio-ffmpeg"
  spec.add_dependency "logger-better"
  spec.add_dependency "edl"
  spec.add_dependency "timecode"
  spec.add_dependency "carrierwave-mongoid"
  spec.add_dependency "carrierwave-video"
  spec.add_dependency "mini_magick"
  spec.add_dependency "mediawiki_api"
  spec.add_dependency "nokogiri", "~> 1.8.0"

  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "mongoid-tree"
  spec.add_development_dependency "mongoid-rspec"
  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0.0"
end
