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

require 'active_support/core_ext/hash/indifferent_access'

module Narra
  module Tools
    class DefaultsHash < ActiveSupport::HashWithIndifferentAccess
      def []=(key, val)
        # persist if there is no already
        if Narra::Tools::Settings.get(convert_key(key)).nil?
          Narra::Tools::Settings.set(convert_key(key), convert_value(val))
        end

        # call parent
        super(key, val)
      end
    end
  end
end