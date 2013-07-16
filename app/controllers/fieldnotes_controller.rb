class FieldnotesController < ApplicationController

  # GET /fieldnotes
  # GET /fieldnotes.json
  def index
    run_fieldnote_query_through_sunspot

    @meta_filter_vars = { :id   => 'fieldnote-filter-form', :path => fieldnotes_path,
                          :lcw  => 5,                       :rcw  => 19 }

    ## Handle the response
    respond_to do |format|
      format.js   { render 'fieldnotes/fieldnotes_list', :layout => false }
      format.html { render 'index' }
    end
  end

  def show
    @fieldnote = Fieldnote.find(params[:id])

    #############################################
    ## Do some text formatting on the fieldnote
    ##  and grab their ids.
    @fieldnote.observations   = @fieldnote.observations.split(/\n/).join('<p>').html_safe
    @fieldnote.reflection     = @fieldnote.reflection.split(/\n/).join('<p>').html_safe

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @item }
    end
  end

  # GET /fieldnotes/new
  # GET /fieldnotes/new.json
  def new
    @fieldnote = Fieldnote.new
    @fieldnote.fieldnote_attachments.build

  end

  # GET /fieldnotes/1/edit
  def edit
    @fieldnote = Fieldnote.find(params[:id])
    @fieldnote.fieldnote_attachments.build
  end

  # POST /fieldnotes
  # POST /fieldnotes.json
  def create
    @fieldnote = Fieldnote.new(params[:fieldnote])

    if @fieldnote.save
      redirect_to url_for( :controller => :home, :action => :index ),
        :notice => 'Fieldnote was successfully inserted into the database!'
    else
      @fieldnote.fieldnote_attachments.build if @fieldnote.fieldnote_attachments.blank?
      render :action => 'new'
    end

  end

  # PUT /fieldnotes/1
  # PUT /fieldnotes/1.json
  def update
    @fieldnote = Fieldnote.find(params[:id])

    if @fieldnote.update_attributes(params[:fieldnote])
      redirect_to fieldnote_path( @fieldnote.id ), :notice => 'Fieldnote was updated!'
    else
      redirect_to root_url, :notice => 'Error updating fieldnote!'
    end
  end

  # DELETE /fieldnotes/1
  # DELETE /fieldnotes/1.json
  def destroy
    @fieldnote = Fieldnote.find(params[:id])
    @fieldnote.destroy

    format.html { redirect_to fieldnotes_url }
  end

  private

  ################################
  ## Run queries for fieldnotes ##
  def run_fieldnote_query_through_sunspot

    @filter = filter_from_params
    @terms  = terms_from_params

    @query = Fieldnote.search do |query|

      unless @filter.nil? or @filter.empty?
        query.fulltext @filter
      end

      unless @terms.nil? or @terms.empty?
        query.fulltext @terms
      end

      query.order_by  sort_column_for_solr, sort_direction
      query.paginate  :page => sort_page, :per_page => 5
    end

    @fieldnotes = @query.results
  end

end
