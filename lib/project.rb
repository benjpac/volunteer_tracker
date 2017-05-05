class Project
  attr_accessor(:name)
  attr_reader(:id)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

end
