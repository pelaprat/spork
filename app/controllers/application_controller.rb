class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_constants
  before_filter :current_user
  before_filter :require_login, :except => 'login'

  before_filter :set_debug_clock

  def set_debug_clock
    @debug_clock = Time.now()
  end

  private

  ####################################
  ## Constants and Login Related Functions
  def load_constants
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless @current_user
      redirect_to root_url
    end
  end

  def require_admin
    ## Unless we're adding the initial admin account...
    unless User.count.eql? 0
      ## And unless the user is logged in and an admin
      unless @current_user and @current_user.is_admin
        ## Redirect them to the root – they can't be here!
        redirect_to root_url
      end
    end
  end

  #############################################
  ## For live queries, grab the filter value ##
  def filter_from_params
    (params.key?(:filter) and not params[:filter].empty?) ? params[:filter] : nil
  end

  def terms_from_params
    (params.key?(:terms) and not params[:terms].empty?) ? params[:terms] : nil
  end

  ###########################################
  ## For sorting the columns of item lists ##
  def sort_page
    ( params.key?(:page) and params[:page].to_i > 0 ) ? params[:page].to_i : 1
  end

  def sort_column
    %w[visited_on person].include?( params[:sort] ) ? params[:sort] : 'created_at'
  end

  def sort_column_for_solr
    sort_column
  end

  def sort_direction
    %w[asc desc].include?( params[:direction] ) ? params[:direction] : 'desc'
  end

  helper_method :current_user
  helper_method :sort_page, :sort_column, :sort_column_for_solr, :sort_direction
end
