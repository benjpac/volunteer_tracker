class Volunteer
  attr_accessor(:name, :project_id)
  attr_reader(:id)

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id.to_i()}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def self.all
    volunteers = DB.exec("SELECT * FROM volunteers")
    saved_volunteers = []
    volunteers.each() do |volunteer|
      name = volunteer['name']
      project_id = volunteer['project_id'].to_i()
      id = volunteer['id'].to_i()
      saved_volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => id})
      saved_volunteers.push(saved_volunteer)
    end
    return saved_volunteers
  end

  def ==(another_volunteer)
    return (self.name() == another_volunteer.name()) && (self.project_id() == another_volunteer.project_id())
  end

  def self.find(id)
    found_volunteer = nil
    Volunteer.all().each() do |volunteer|
      if volunteer.id() == id
        found_volunteer = volunteer
      end
    end
    return found_volunteer
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @project_id = attributes.fetch(:project_id, @project_id)
    @id = self.id()
    DB.exec("UPDATE volunteers SET name = '#{@name}', project_id = '#{@project_id}' WHERE id = #{@id};")
  end

  def delete
    @id = self.id()
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

end
