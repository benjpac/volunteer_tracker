require('spec_helper')

describe(Project) do

  describe('.all') do
    it('returns all instances of Project class, starts off with no projects') do
      expect(Project.all()).to eq([])
    end
  end

  describe('#name') do
    it('tells you the projects name') do
      test_project = Project.new({:name => "Test Fundraiser", :id => nil})
      expect(test_project.name()).to eq("Test Fundraiser")
    end
  end

  describe('#id') do
    it('tells you its id') do
      test_project = Project.new({:name => "Test Fundraiser", :id => nil})
      test_project.save()
      expect(test_project.id()).to be_an_instance_of(Fixnum)
    end
  end

  describe('#save') do
    it('saves project object to database') do
      test_project = Project.new({:name => "Test Fundraiser", :id => nil})
      test_project.save()
      expect(Project.all()).to eq([test_project])
    end
  end

  describe('#==') do
    it("is the same project if it has the same name") do
    project = Project.new({:name => "Test Fundraiser", :id => nil})
    project1 = Project.new({:name => "Test Fundraiser", :id => nil})
    expect(project).to eq(project1)
    end
  end

  describe('.find') do
    it("returns a project using its ID") do
      test_project = Project.new({:name => "Test Fundraiser", :id => nil})
      test_project.save()
      test_project1 = Project.new({:name => "Another Test Fundraiser", :id => nil})
      test_project1.save()
      expect(Project.find(test_project.id())).to eq(test_project)
    end
  end

  describe("#volunteers") do
    it("returns an array of volunteers for that Project") do
      test_project = Project.new({:name => "Test Fundraiser", :id => nil})
      test_project.save()
      test_volunteer = Volunteer.new({:name => "Brad", :project_id => test_project.id(), :id => nil})
      test_volunteer.save()
      test_volunteer1 = Volunteer.new({:name => "Jeff", :project_id => test_project.id(), :id => nil})
      test_volunteer1.save()
      expect(test_project.volunteers()).to eq([test_volunteer, test_volunteer2])
    end
  end

  describe('#update') do
    it('changes existing project object in the database') do
      test_project = Project.new({:name => "Test Fundraiser", :id => nil})
      test_project.save()
      test_project.update({:name => "Another Test Fundraiser"})
      expect(test_project.name()).to eq("Another Test Fundraiser")
    end
  end

  describe('#delete') do
    it('deletes a project from the database') do
      test_project = Project.new({:name => "Test Fundraiser", :id => nil})
      test_project.save()
      test_project1 = Project.new({:name => "Another Test Fundraiser", :id => nil})
      test_project1.save()
      test_project.delete()
      expect(Project.all()).to eq([test_project1])
    end
  end

end
