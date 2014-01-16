require 'tempfile'

namespace :deploy do
  namespace :check do
    task :holepicker do
      on roles(:app) do |host|
        within release_path do

          options = {
            :ignored_gems => fetch(:holepicker_ignored_gems),
            :offline => fetch(:holepicker_offline)
          }

          file = Tempfile.new('remote-Gemfile.lock')
          begin
            download! "#{release_path}/Gemfile.lock", file.path
            reporter = HolePicker::ScanReporter.new
            log = StringIO.new
            reporter.logger = HolePicker::Logger.new log

            scanner = HolePicker::Scanner.new(file.path, options)
            scanner.instance_variable_set :@reporter, reporter
            scanner.send :scan_gemfile, File.read(file.path), "Gemfile.lock"
            success = reporter.success?

            unless success
              reporter.print_report
              logger.important(log.string)
              raise Capistrano::VulnerableException.new("HolePicker found vulnerabilities")
            end

          ensure
            file.close
            file.unlink
          end
        end
      end
    end
  end

  before 'deploy:publishing', 'deploy:check:holepicker'
end

namespace :load do
  task :defaults do   
    set :holepicker_offline, false
    set :holepicker_ignored_gems, []
  end
end