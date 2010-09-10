class ThingsController < ApplicationController
  before_filter :allow_modify, :only => [:edit, :update, :destroy]

  # GET /things
  # GET /things.xml
  def index
    @new_thing = Thing.new
    @things = nil
    if filter = params[:filter]
      @things = case filter
      when "mean"
        Thing.all(:order => 'current_votes DESC', :conditions => "category = 'mean'", :limit => 20)
      when "nice"
        Thing.all(:order => 'current_votes DESC', :conditions => "category = 'nice'", :limit => 20)
      when "funny"
        Thing.all(:order => 'current_votes DESC', :conditions => "category = 'funny'", :limit => 20)
      when "stupid"
        Thing.all(:order => 'current_votes DESC', :conditions => "category = 'stupid'", :limit => 20)
      when "hurricane"
        Thing.all(:order => 'current_votes DESC', :conditions => "category = 'hurricane'", :limit => 20)
      when "weird"
        Thing.all(:order => 'current_votes DESC', :conditions => "category = 'weird'", :limit => 20)
      when "other"
        Thing.all(:order => 'current_votes DESC', :conditions => "category = 'other'", :limit => 20)
      when "top"
        Thing.all(:order => 'current_votes DESC', :limit => 20)
      end
    end
    @things = Thing.all(:order => 'created_at DESC', :limit => 20) if @things.nil?

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @things }
    end
  end

  # GET /things/1
  # GET /things/1.xml
  def show
    @thing = Thing.find_by_id(params[:id])
    if @thing.nil?
      redirect_to(things_url)
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @thing }
      end
    end
  end

  # GET /things/new
  # GET /things/new.xml
  def new
    @thing = Thing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @thing }
    end
  end

  # GET /things/1/edit
  def edit
    @thing = Thing.find(params[:id])
  end

  #POST /things
  #POST /things.xml
  def create
    thingy = params[:thing]
    thing_content = CGI.escapeHTML(thingy[:thing])
    
    @thing = Thing.new(:thing => CGI.escapeHTML(thing_content), :category => thingy[:category])
    
    @thing.ip = request.remote_ip
  
    respond_to do |format|
      if verify_recaptcha() && @thing.save
        flash[:notice] = "Success! You added a #{@thing.category} thing."
        format.html { redirect_to(:action => 'index') }
        format.xml  { render :xml => @thing, :status => :created, :location => @thing }
      else
        flash[:error] = "Failure! We could not add the #{@thing.category} thing."
        format.html { render :action => "new" }
        format.xml  { render :xml => @thing.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create_ajax
    @thing = Thing.new(:thing => CGI.escapeHTML(params[:body]), :category => params[:category])
    @thing.ip = request.remote_ip

    respond_to do |format|
      if @thing.save
        flash[:notice] = "Success! You added a #{@thing.category} thing."
        format.js { render :text => "Success" }
      else
        flash[:error] = "Failure! We could not add the #{@thing.category} thing."
        format.js { render :text => "Failure" }          
      end
    end    
  end

  # PUT /things/1
  # PUT /things/1.xml
  def update
    @thing = Thing.find(params[:id])

    respond_to do |format|
      if @thing.update_attributes(params[:thing])
        flash[:notice] = 'Thing was successfully updated.'
        format.html { redirect_to(@thing) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thing.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def vote
    if request.post?
      @thing = Thing.find_by_id(params[:thing_id])
      if !@thing.nil?
        respond_to do |format|
          if Vote.add_new_vote(@thing, request.remote_ip, params[:direction])
            count = Thing.find_by_id(@thing.id).current_votes
            format.js { render :json =>{ :vote_count => count } }
          else
            format.js { render :text => "We were unable to cast your vote." }
          end
        end
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.xml
  def destroy
    @thing = Thing.find(params[:id])
    @thing.destroy

    respond_to do |format|
      format.html { redirect_to(things_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def allow_modify
    redirect_to(things_url)
  end
end
