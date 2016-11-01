MItamae::RecipeContext.class_eval do
  def include_cookbook(name)
    root_dir = File.expand_path('../..', __FILE__)
    include_recipe File.join(root_dir, 'cookbooks', name, 'default')
  end

  def include_role(name)
    root_dir = File.expand_path('../..', __FILE__)
    include_recipe File.join(root_dir, 'roles', name, 'default')
  end
end
