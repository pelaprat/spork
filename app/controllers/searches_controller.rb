class SearchesController < ApplicationController

  def show
    @search = Search.find( params[:id] )

    @query = Fieldnote.search do |query|
      query.fulltext @search.terms
      query.with      :user_id, @current_user.id
      query.order_by  sort_column_for_solr, sort_direction
      query.paginate  :page => sort_page, :per_page => 5
    end

    @fieldnotes = @query.results

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @search }
    end
  end

  def new
    @search = Search.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @search }
    end
  end

  def create
    fieldnote_id = 0
    terms        = ''

    ## Did we get search criteria to fill out this search object?
    if( params.key?( :search ) )
      search_params = params[:search]
      terms = search_params.key?(:terms) ? search_params[:terms] : ''

    end
  
    @search = Search.new({  :name     => @current_user.id.to_s + ':search:' + Time.now().strftime("%s"),
                            :user_id  => @current_user.id,
                            :terms    => terms })

    respond_to do |format|
      if @search.save!
        format.html { redirect_to @search }
        format.json { render :json => @search, :status => :created, :location => @search }
      else
        format.html { render :action => "new" }
        format.json { render :json => @search.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @search = Search.find( params[:id] )

    ## Search terms
    @search.terms =
      params[:search][:terms].nil? ? '' : params[:search][:terms]

    respond_to do |format|
      if  @search.save!
        format.html { redirect_to @search, :notice => 'Search was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @search.errors, :status => :unprocessable_entity }
      end
    end
  end

end




