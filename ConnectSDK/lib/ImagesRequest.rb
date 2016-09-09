require_relative 'RequestBase'

class ImagesRequest < RequestBase
  CONNECT_ROUTE = '/v3/images'.freeze # mashery endpoint
  @search_route = CONNECT_ROUTE
  QUERY_PARAMS_NAMES = %w(page page_size).freeze

  QUERY_PARAMS_NAMES.each do |key|
    define_method :"with_#{key}" do |value = true|
      if value.is_a?(Array)
        build_query_params(key, value.join(','))
      else
        build_query_params(key, value)
      end
      return self
    end
  end

  def with_ids(ids)
    ids = ids.join('%2C')
    @search_route = "#{CONNECT_ROUTE}/#{ids}"
    self
  end

  def similar(id)
    @search_route = "#{CONNECT_ROUTE}/#{id}/similar"
    self
  end

  def execute
    @http_helper.get(@search_route, @query_params)
  end
end
