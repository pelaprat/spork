class UsersController < ApplicationController

  skip_before_filter :require_login, :only => [:create]
  before_filter :require_admin

  # GET /users
  # GET /users.json

  def index

    @meta_filter_vars = { :id => 'user-filter-form', :path => users_path, :lcw => 0, :rcw => 24 }
    @filter           = filter_from_params
    @query            = User.search do |query|

      unless @filter.nil? or @filter.empty?
        query.fulltext @filter
      end

      query.order_by  sort_column_for_solr, sort_direction
      query.paginate  :page => sort_page, :per_page => 5
    end

    @users = @query.results

    ## Handle the response
    respond_to do |format|
      format.js   { render 'users/users_list', :layout => false }
      format.html { render 'index' }
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user             = User.find(params[:id])

    @meta_filter_vars = { :id => 'fieldnote-filter-form', :path => fieldnotes_path, :lcw => 0, :rcw => 24 }

    @query = Fieldnote.search do |query|

      unless @filter.nil? or @filter.empty?
        query.fulltext @filter
      end

      query.with      :user_id, @user .id
      query.order_by  sort_column_for_solr, sort_direction
      query.paginate  :page => sort_page, :per_page => 5
    end

    @fieldnotes = @query.results

    ## Handle the response
    respond_to do |format|
      format.js   { render :layout => false  }
      format.html { render 'show' }
    end

  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def create

    @user = User.new(params[:user])

    if @user.save
      redirect_to url_for( :controller => :home, :action => :index ),
      :notice => 'The user was successfully inserted into the database!'

    else
      render :action => 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update

    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy

    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
