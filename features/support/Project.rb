class Project
  attr_accessor :project_id
  attr_accessor :project_name
  attr_accessor :environments

  def initialize(project_id, project_name)
    @project_id = project_id
    @project_name = project_name
    @environments = []
  end

  def set_project_id(project_id)
    @project_id = project_id
  end

  def add_environment(env)
    @environments.push(env)
  end

end