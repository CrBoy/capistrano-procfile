namespace :load do
	task :defaults do
		set :procfile_roles, %w(app)
		set :procfile_use_sudo, false
		set :procfile_options, {}
	end
end

namespace :procfile do
	desc "Export procfile to system init daemon configurations"
	task :export do
		on roles fetch :procfile_roles do |host|
			default_options = {
				export_format: :systemd,
				export_path: "/etc/systemd/system",
				working_dir: release_path,
				log_dir: File.join(release_path, "log"),
				base_port: 5000,
				app_name: fetch(:application),
				user: nil,
				formation: "all=1"
			}
			options = default_options.merge fetch(:procfile_options, {}).merge Hash(host.properties.procfile_options)
			options_map = {
				working_dir: "-d",
				log_dir: "-l",
				base_port: "-p",
				app_name: "-a",
				user: "-u",
				formation: "-m"
			}

			execute(:mkdir, "-p", options[:log_dir])

			within release_path do
				args = %w(bundle exec foreman export)
				args << options[:export_format]
				args << options[:export_path]
				options_map.each do |k, v|
					args << "#{v} #{options[k]}" if options[k]
				end

				fetch(:procfile_use_sudo) ? execute(:rvmsudo, *args) : execute(*args)
			end
		end
	end
end

after "deploy:publishing", "procfile:export"
