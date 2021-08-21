class BaseQuery
  attr_reader :query, :params

  def initialize(**_params)
    raise NoMethodError
  end

  def execute
    raise NoMethodError
  end
end
