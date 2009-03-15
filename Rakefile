require 'rake'
require 'spec/rake/spectask'

task :default => :spec

desc "spec"
Spec::Rake::SpecTask.new do |t|
  t.libs << "spec"
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ["--format", "progress", "--color"]
end
