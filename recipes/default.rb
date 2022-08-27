MItamae::RecipeContext.class_eval do
  def include_cookbook(name)
    root_dir = File.expand_path('../..', __FILE__)
    include_recipe File.join(root_dir, 'cookbooks', name, 'default')
  end
end

node.reverse_merge!(
  user: ENV['SUDO_USER'] || ENV['USER'],
)

include_cookbook 'functions'

directory "#{ENV['HOME']}/bin" do
  owner node[:user]
end

include_recipe node[:platform]
