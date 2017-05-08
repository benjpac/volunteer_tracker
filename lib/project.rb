class Project
  attr_accessor(:name)
  attr_reader(:id)

  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
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

  def volunteers
    found_volunteers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id()};")
    volunteers.each() do |volunteer|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i()
      id = volunteer["id"].to_i()
      found_volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    return found_volunteers
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    if attributes[:volunteer_ids] != nil
      volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id};")
      volunteers.each() do |volunteer|
        DB.exec("UPDATE volunteers SET project_id = -1 WHERE project_id = #{@id};")
      end
      attributes.fetch(:volunteer_ids, []).each() do |volunteer_id|
        DB.exec("UPDATE volunteers SET project_id = '#{@id}' WHERE id = #{volunteer_id};")
      end
    end
  end

  def delete
    @id = self.id()
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

end
