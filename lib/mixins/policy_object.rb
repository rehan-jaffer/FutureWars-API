module PolicyObject
  def allowed?
    conditions.all? { |c| c[1] }
  end

  def denied?
    !allowed?
  end

  def error
    conditions.find { |c| !c[1] }[0]
  end

  def success(&block)
    if allowed?
      yield
    end
  end

  def failure(&block)
    unless allowed?
      yield error
    end
  end
end
