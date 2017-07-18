module ResourceApi
  def index
    respond_with(resource_class.all)
  end

  def create
    @record = resource_class.create(resource_params)
    resource_response(@record, :created)
  end

  def update
    @record = resource
    @record.update_attributes(resource_params)
    resource_response(@record)
  end

  def destroy
    resource.destroy
    head :no_content
  end

  private

  def resource_class
    raise NotImplementedError
  end

  def resource_params
    raise NotImplementedError
  end

  def resource
    resource_class.find(params[:id])
  end

  def resource_response(record, status = :ok)
    if record.valid?
      render json: record, status: status
    else
      render json: record.errors, status: :unprocessable_entity
    end
  end
end
