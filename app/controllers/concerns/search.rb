module Search
  extend ActiveSupport::Concern

  LIMIT = 10

  def search_query
    return "" if !params.has_key?(:q)
    return params[:q]
  end


  def get_search_results(params:, model:, attribute:)

    if(search_query.length > 0)
      query = model
      .paginate(:page => params[:page], :per_page => LIMIT)
      .where("lower(#{attribute}) LIKE lower(?)", "#{params[:q]}%")
      return query
    end

    return model.none
  end
end
