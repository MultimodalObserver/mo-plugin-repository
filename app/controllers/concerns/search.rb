module Search
  extend ActiveSupport::Concern


  def get_search_results(params:, model:, attribute:)

    limit = 3

    if(params.has_key?(:limit))
      limit = params[:limit].to_i
    end

    limit = 10 if limit > 10

    if(params.has_key?(:q) && params[:q].length > 0)
      results = model
      .paginate(:page => params[:page], :per_page => limit)
      .where("lower(#{attribute}) LIKE lower(?)", "#{params[:q]}%")
      render json: results, status: :ok
      return
    end

    render json: [], status: :ok
  end

end
