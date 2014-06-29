require 'rake'
require 'rake/tasklib'

desc "Check puppet syntax"
task :default do
  puppet = '/usr/bin/puppet parser validate '
  params = ''

  [ 'manifests/*.pp', 'modules/*/manifests/*.pp', 'modules/*/manifests/*/*.pp', 'modules/*/manifests/*/*/*.pp' ].each do |path|
    Dir.glob( path ).each do |file|
      sh "#{ puppet } #{ params } #{ file }" do |ok, res|
        unless ok
          abort
        end
      end
    end
  end
end

