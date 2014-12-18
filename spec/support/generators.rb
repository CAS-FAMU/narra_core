#
# Copyright (C) 2013 CAS / FAMU
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
# Authors: Michal Mocnak <michal@marigan.net>, Krystof Pesek <krystof.pesek@gmail.com>
#

RSpec.configure do |config|
  config.before(:each) do
    # testing generator
    module Narra
      module Generators
        class Testing < Narra::SPI::Generator
          # Set title and description fields
          @identifier = :testing
          @title = 'Testing'
          @description = 'Testing Metadata Generator'

          def self.valid?(item_to_check)
            return true
          end

          def generate
            add_meta(name: 'test', content: 'test')
          end
        end
      end
    end
  end
end