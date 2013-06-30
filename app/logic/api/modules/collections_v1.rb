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

module API
  module Modules
    class CollectionsV1 < Grape::API

      version 'v1', :using => :path
      format :json

      helpers API::Helpers::User

      resource :collections do

        desc "Return all collections."
        get do
          authenticate!
          present API::Wrappers::Collection.collections(Collection.all), with: API::Entities::Collection
        end



        desc "Create new collection."
        params do
          requires :name, type: String, desc: "Name of new collection."
          #requires :owner_id, type: String, desc: "Id of owner."

        end

        get 'new' do
          authenticate!
          # get user
          collection = Collection.find_by(name: params[:name])
          # present or not found
          if (collection.nil?)
            tmp = Collection.new(name: params[:name], owner_id: current_user._id)
            tmp.save
            present API::Wrappers::Collection.collection(tmp), with: API::Entities::Collection

          else
            present API::Wrappers::Error.error_already_exists, with: API::Entities::Error
          end
        end


        desc "Return a specific item."
        get ':_id' do
          authenticate!
          # get user
          collection = Collection.find_by(_id: params[:_id])
          # present or not found
          if (collection.nil?)
            present API::Wrappers::Error.error_not_found, with: API::Entities::Error
          else
            present API::Wrappers::Collection.collection(collection), with: API::Entities::Collection
          end
        end

        desc "Delete a specific collection."
        get ':_id/delete' do
          authenticate!
          # get user
          collection = Collection.find_by(_id: params[:_id])
          # present or not found
          if (collection.nil?)
            present API::Wrappers::Error.error_not_found, with: API::Entities::Error
          else
            collection.destroy && { status: API::Enums::Status::OK }
          end
        end


      end
    end
  end
end