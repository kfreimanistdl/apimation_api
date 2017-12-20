class Environment
  attr_accessor :environment_id
  attr_accessor :environment_name

  def initialize(environment_id, environment_name)
    @environment_id = environment_id
    @environment_name = environment_name
  end

end