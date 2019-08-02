class File
  def self.delete_if_exists(path_to_file)
    File.delete(path_to_file) if File.exist?(path_to_file)
  end
end

namespace :infrastructure do
  task :init => [:build] do
    Dir.chdir('infrastructure/') do
      sh "terraform init"
    end
  end

  task :plan => [:build] do
    Dir.chdir('infrastructure/') do
      sh "terraform plan -out plan.tfplan"
    end
  end

  task :apply do
    Dir.chdir('infrastructure/') do
      sh "terraform apply plan.tfplan"
    end
  end
end

namespace :hello_world do
  task :build => ["hello_world:clean"] do
    Dir.chdir('hello_world/') do
      sh "zip hello_world.zip hello_world.py"
    end
  end

  task :clean do
    Dir.chdir('hello_world/') do
      File.delete_if_exists "hello_world.zip"
    end
  end

  task :test do
    Dir.chdir('hello_world/') do
      sh "python2 test_hello_world.py"
    end
  end
end

task :build => ["hello_world:build"] do
end

task :clean => ["hello_world:clean"] do
end

task :test => ["hello_world:test"] do
end
