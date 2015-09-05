#
# Copyright (C) 2015 CAS / FAMU
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

require 'carrierwave/mongoid'

module Narra
  class Visualization
    include Mongoid::Document
    include Mongoid::Timestamps
    include Narra::Extensions::Meta
    include Narra::Extensions::Public

    field :name, type: String
    field :description, type: String
    field :type, type: Symbol

    mount_uploader :script, Narra::VisualizationUploader

    # User Relations
    belongs_to :author, autosave: true, inverse_of: :sequences, class_name: 'Narra::User'

    # Project Relations
    has_and_belongs_to_many :projects, autosave: true, inverse_of: :visualizations, class_name: 'Narra::Project'

    # Meta Relations
    has_many :meta, autosave: true, dependent: :destroy, inverse_of: :visualization, class_name: 'Narra::MetaVisualization'

    # Validations
    validates_uniqueness_of :name
    validates_presence_of :name

    # Return this sequence for Meta extension
    def model
      self
    end
  end
end