class TaxRecordsController < ApplicationController
  # GET /tax_records
  # GET /tax_records.json
  def index
    @tax_records = TaxRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tax_records }
    end
  end

  # GET /tax_records/1
  # GET /tax_records/1.json
  def show
    @tax_record = TaxRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tax_record }
    end
  end

  # GET /tax_records/new
  # GET /tax_records/new.json
  def new
    @tax_record = TaxRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tax_record }
    end
  end

  # GET /tax_records/1/edit
  def edit
    @tax_record = TaxRecord.find(params[:id])
  end

  # POST /tax_records
  # POST /tax_records.json
  def create
    @tax_record = TaxRecord.new(params[:tax_record])

    respond_to do |format|
      if @tax_record.save
        format.html { redirect_to @tax_record, notice: 'Tax record was successfully created.' }
        format.json { render json: @tax_record, status: :created, location: @tax_record }
      else
        format.html { render action: "new" }
        format.json { render json: @tax_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tax_records/1
  # PUT /tax_records/1.json
  def update
    @tax_record = TaxRecord.find(params[:id])

    respond_to do |format|
      if @tax_record.update_attributes(params[:tax_record])
        format.html { redirect_to @tax_record, notice: 'Tax record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tax_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tax_records/1
  # DELETE /tax_records/1.json
  def destroy
    @tax_record = TaxRecord.find(params[:id])
    @tax_record.destroy

    respond_to do |format|
      format.html { redirect_to tax_records_url }
      format.json { head :no_content }
    end
  end
end
