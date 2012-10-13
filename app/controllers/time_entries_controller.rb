class TimeEntriesController < ApplicationController

  def table
    
  end
  # GET /time_entries
  # GET /time_entries.json
  def index
    @time_entries = TimeEntry.all

    metadata = [
      {name: "date", label: "Date", datatype: "date", editable: true},
      {name: "time_in", label: "Time In", datatype: "string", editable: true},
      {name: "time_out", label: "Time Out", datatype: "string", editable: true}
    ]

    data = []
    
    @time_entries.each do |t|
      x = { id: t.id, values: {date: t.time_in.strftime('%d %b %Y'), time_in: "#{t.time_in.hour}:#{t.time_in.min}", time_out: "#{t.time_out.hour}:#{t.time_out.min}"}}
      data << x
    end
    ed = EditableGrid.new(metadata, data)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: ed }
      format.xml { render xml: @time_entries}
    end
  end

  # GET /time_entries/1
  # GET /time_entries/1.json
  def show
    @time_entry = TimeEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @time_entry }
    end
  end

  # GET /time_entries/new
  # GET /time_entries/new.json
  def new
    @time_entry = TimeEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_entry }
    end
  end

  # GET /time_entries/1/edit
  def edit
    @time_entry = TimeEntry.find(params[:id])
  end

  # POST /time_entries
  # POST /time_entries.json
  def create
    @time_entry = TimeEntry.new(params[:time_entry])

    respond_to do |format|
      if @time_entry.save
        format.html { redirect_to @time_entry, notice: 'Time entry was successfully created.' }
        format.json { render json: @time_entry, status: :created, location: @time_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_entries/1
  # PUT /time_entries/1.json
  def update
    @time_entry = TimeEntry.find(params[:id])

    respond_to do |format|
      if @time_entry.update_attributes(params[:time_entry])
        format.html { redirect_to @time_entry, notice: 'Time entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_entries/1
  # DELETE /time_entries/1.json
  def destroy
    @time_entry = TimeEntry.find(params[:id])
    @time_entry.destroy

    respond_to do |format|
      format.html { redirect_to time_entries_url }
      format.json { head :no_content }
    end
  end
end
