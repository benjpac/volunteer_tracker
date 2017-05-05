class Project
  attr_accessor(:name)
  attr_reader(:id)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def self.all
    projects = DB.exec("SELECT * FROM projects")
    saved_projects = []
    projects.each() do |project|
      name = project['name']
      id = project['id'].to_i()
      saved_project = Project.new({:name => name, :id => id})
      saved_projects.push(saved_project)
    end
    return saved_projects
  end

  def ==(another_project)
    return self.name() == another_project.name()
  end

  def self.find(id)
    found_project = nil
    Project.all().each() do |project|
      if project.id() == id
        found_project = project
      end
    end
    return found_project
  end

end
