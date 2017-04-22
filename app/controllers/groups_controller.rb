class GroupsController < ApplicationController
  def index ; end
    
  end

  def edit
    @group = Group.new
  end
  def new
    @group = Group.new
  end
end
