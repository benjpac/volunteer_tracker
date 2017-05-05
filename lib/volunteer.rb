class Volunteer
  attr_accessor(:name, :project_id)
  attr_reader(:id)

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
  end

end
