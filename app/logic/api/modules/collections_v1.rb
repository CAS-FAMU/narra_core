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
          present({ status: API::Enums::Status::OK, collections: present(Collection.all, with: API::Entities::Collection)})
        end

        desc "Create new collection."
        params do
          requires :name, type: String, desc: "Name of new collection."
          requires :title, type: String, desc: "Title of new collection."
          optional :project, type: String, desc: "Unique name of the project."
        end
        post 'new' do
          authenticate!
          # get collection
          collection = Collection.find_by(name: params[:name])
          # present or not found
          if (collection.nil?)
            # create new collection
            collection = Collection.create(name: params[:name], title: params[:title], owner: current_user)
            # add into project
            collection.projects << Project.find_by(name: params[:project]) unless params[:project].nil?
            # present
            present({ status: API::Enums::Status::OK, collection: present(collection, with: API::Entities::Collection)})
          else
            error!({ status: API::Enums::Status::ERROR, message: API::Enums::Error::ALREADY_EXISTS[:message] },
                   API::Enums::Error::ALREADY_EXISTS[:status])
          end
        end

        desc "Return a specific collection."
        get ':name' do
          authenticate!
          # get user
          collection = Collection.find_by(name: params[:name])
          # present or not found
          if (collection.nil?)
            error!({ status: API::Enums::Status::ERROR, message: API::Enums::Error::NOT_FOUND[:message] },
                   API::Enums::Error::NOT_FOUND[:status])
          else
            present({ status: API::Enums::Status::OK, collection: present(collection, with: API::Entities::Collection, type: :detail)})
          end
        end

        desc "Update a specific collection."
        params do
          requires :name, type: String, desc: "Name of the collection."
          requires :title, type: String, desc: "Title of the collection to be saved."
        end
        post ':name/update' do
          authenticate!
          # get project
          collection = Collection.find_by(name: params[:name])
          # present or not found
          if (collection.nil?)
            error!({ status: API::Enums::Status::ERROR, message: API::Enums::Error::NOT_FOUND[:message] },
                   API::Enums::Error::NOT_FOUND[:status])
          else
            # update project
            collection.update_attributes(title: params[:title])
            # present
            present({ status: API::Enums::Status::OK, collection: present(collection, with: API::Entities::Collection, type: :detail)})
          end
        end

        desc "Delete a specific collection."
        get ':name/delete' do
          authenticate!
          # get collection
          collection = Collection.find_by(name: params[:name])
          # present or not found
          if (collection.nil?)
            error!({ status: API::Enums::Status::ERROR, message: API::Enums::Error::NOT_FOUND[:message] },
                   API::Enums::Error::NOT_FOUND[:status])
          else
            collection.destroy && present({ status: API::Enums::Status::OK })
          end
        end
      end
    end
  end
end