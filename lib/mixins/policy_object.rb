module PolicyObject
  def allowed?
    conditions.all? { |c| c[1] }
  end

  def error
    conditions.find { |c| !c[1] }[0]
  end
end
