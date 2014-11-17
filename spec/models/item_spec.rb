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

require 'spec_helper'

describe Item do
  it "can be instantiated" do
    expect(FactoryGirl.build(:item)).to be_an_instance_of(Item)
  end

  it "can be saved successfully" do
    expect(FactoryGirl.create(:item, owner: @author_user)).to be_persisted
  end

  it "should have storage available" do
    # Temporary item
    item = FactoryGirl.create(:item, owner: @author_user)
    # Check storage
    expect(item.storage).to be_a_kind_of(Fog::Model)
  end

  it "should destroy storage after destroy" do
    # Temporary item
    item = FactoryGirl.create(:item, owner: @author_user)
    # Store id
    id = item._id.to_s
    # Destroy item
    item.destroy
    # Check storage
    expect(Narra::Storage::ITEMS.directories.get(id)).to be_nil
  end
end