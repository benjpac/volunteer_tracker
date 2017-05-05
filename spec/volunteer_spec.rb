require('spec_helper')

describe(Volunteer) do

  describe('.all') do
    it('returns all instances of Volunteer class, starts off with no projects') do
      expect(Volunteer.all()).to eq([])
    end
  end

  describe('#name') do
    it('tells you the the volunteers name') do
      test_volunteer = Volunteer.new({:name => "Jeff", :project_id => nil, :id => nil})
      expect(test_volunteer.name()).to eq("Jeff")
    end
  end

  describe('#id') do
    it('tells you its id') do
      test_volunteer = Volunteer.new({:name => "Jeff", :project_id => nil, :id => nil})
      test_volunteer.save()
      expect(test_volunteer.id()).to be_an_instance_of(Fixnum)
    end
  end

  describe('#save') do
    it('saves volunteer object to database') do
      test_volunteer = Volunteer.new({:name => "Jeff", :project_id => 1, :id => nil})
      test_volunteer.save()
      expect(Volunteer.all()).to eq([test_volunteer])
    end
  end

  describe('#==') do
    it("is the same volunteer if it has the same name") do
    volunteer = Volunteer.new({:name => "Test Fundraiser", :project_id => 1, :id => nil})
    volunteer1 = Volunteer.new({:name => "Test Fundraiser", :project_id => 1, :id => nil})
    expect(volunteer).to eq(volunteer1)
    end
  end

end
