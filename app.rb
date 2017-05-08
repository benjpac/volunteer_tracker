require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require('pg')
require('pry')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:index)
end

post('/add_project') do
  name = params[:project]
  project = Project.new(:name => name)
  project.save()
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:index)
end

get('/project/:id') do
  @project = Project.find(params[:id].to_i())
  @volunteers = Volunteer.all()
  erb(:project)
end

patch('/project/:id') do
  @project = Project.find(params[:id].to_i())
  if params["name"] != ""
    name = params["name"]
    @project.update({:name => name})
  end
  if params["volunteer_ids"] != nil
    volunteer_ids = params["volunteer_ids"]
    @project.update({:volunteer_ids => volunteer_ids})
  end
  @volunteers = Volunteer.all()
  erb(:project)
end

post('/add_volunteer') do
  name = params[:volunteer]
  volunteer = Volunteer.new(:name => name)
  volunteer.save()
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:index)
end

post('/delete_project/:id') do
  project = Project.find(params[:id].to_i())
  project.delete()
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:index)
end

post('/clear_all') do
  clear_all()
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:index)
end

def clear_all
  DB.exec("DELETE FROM projects *;")
  DB.exec("DELETE FROM volunteers *;")
end
