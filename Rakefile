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

namespace :goodnight_world do
  task :build => ["goodnight_world:clean"] do
    Dir.chdir('goodnight_world/') do
      sh "zip goodnight_world.zip goodnight_world.rb"
    end
  end

  task :clean do
    Dir.chdir('goodnight_world/') do
      File.delete_if_exists "goodnight_world.zip"
    end
  end

  task :test do
    Dir.chdir('goodnight_world/') do
      sh "ruby test_goodnight_world.rb"
    end
  end
end

task :build => [
  "hello_world:build",
  "goodnight_world:build"
  ] do
end

task :clean => [
  "hello_world:clean",
  "goodnight_world:clean"
  ] do
end

task :test => [
  "hello_world:test",
  "goodnight_world:test",
  ] do
end
