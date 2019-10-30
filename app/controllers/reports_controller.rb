class ReportsController < ApplicationController
  PER_PAGE_RECORD = 20

  def index
    records = Report.all.order(id: :desc).limit(PER_PAGE_RECORD + 1)
    if params[:page].present?
      records = records.offset(PER_PAGE_RECORD * params[:page].to_i)
    end
    records = records.to_a
    rv = {
      results: [],
      hasMore: records.length > PER_PAGE_RECORD,
    }
    records.each_with_index do |record, idx|
      rv[:results].push record.to_json if idx < PER_PAGE_RECORD
    end
    api_success rv
  end
  
  def create
    [:title, :userName].each do |attr|
      return api_fail("Missing attribute: #{attr}", 400) if params[attr].blank?
    end
    record = Report.create(
      title: params[:title],
      description: params[:description],
      user_name: params[:userName],
    )
    api_success record.to_json, 201
  end

  def show
    return api_fail(nil, 400) if params[:id].blank?
    record = Report.find_by id: params[:id]
    return api_fail(nil, 404) if record.blank?
    api_success record.to_json
  end

  def update
    return api_fail(nil, 400) if params[:id].blank?
    record = Report.find_by id: params[:id]
    return api_fail(nil, 404) if record.blank?
    [:title, :userName, :description].each do |attr|
      if params.key? attr
        pass = record.update_attr(attr, params[attr])
        unless pass
          return api_fail "#{attr} cannot be empty", 400
        end
      end
    end
    record.save if record.changed?
    api_success record.to_json, 202
  end

  def destroy
    return api_fail(nil, 400) if params[:id].blank?
    record = Report.find_by id: params[:id]
    return render(status: 204) if record.blank?
    record.destroy
    render(status: 204)
  end

end
