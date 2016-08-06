# Usage:
#   rake -g source_list
#   rake -g 'source_list[task_name]'
#
# Example:
#
#   $ rake -g 'source_list[routes]'
#       routes  vendor/rails/railties/lib/tasks/routes.rake:2

import File.join(Dir.pwd, 'Rakefile')

class RakeTaskSourceLister
  def self.parse(tasks, target_task_name = nil)
    new(tasks, target_task_name).run
  end

  def run
    if @target_task_name && !@target_task_name.empty?
      regexp = Regexp.compile(@target_task_name)
      @tasks = @tasks.select{|t| t.name =~ regexp }
    end

    current_dir = "#{Dir.pwd}/"
    @tasks.each do |t|
      puts [t.name, t.actions.map{|action| action.to_s.sub(%r!#<Proc:[\w]+@([^>]+)>$!, '\1').sub(current_dir, "")}.join(",")].join("\t")
    end
  end

  private

  def initialize(tasks, target_task_name)
    @tasks = tasks
    @target_task_name = target_task_name
  end
end

task :source_list, "target_task_name"
desc "Output tasks and display filename and line number that the task is defined."
task :source_list do |x, args|
  if ( t = args.target_task_name )
    RakeTaskSourceLister.parse(Rake::Task.tasks, t)
  else
    RakeTaskSourceLister.parse(Rake::Task.tasks)
  end
end
