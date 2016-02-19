namespace :fastly do
  namespace :template_cache do

    desc 'Generate template digest manfiest'
    task :generate_manifest => :environment do
      puts "generating manifest"
      lookup_context = ApplicationController.new.lookup_context

      # TODO: Only selecting the default app/views path.  Make this more generic at some point
      path_selection = 'app/views'
      view_paths = lookup_context.view_paths.select {|path| path.inspect =~ /#{path_selection}/ }

      templates = view_paths.map do |path|
        file_glob = File.join(path.to_s, '**/*')
        Dir.glob(file_glob).map do |file_path|
          if File.file?(file_path)
            view_path = file_path.split(path_selection).last

            # Try both partial true and false
            lookup_context.find_all(view_path) + lookup_context.find_all(view_path, [], true)
          end
        end
      end

      manifest_data = templates.flatten.compact.map do |template|
        [template.inspect, Digest::MD5.hexdigest(template.source)]
      end

      File.open(File.join(Rails.root, 'public/view_digest_manifest.json'), 'w') do |file|
        file.puts manifest_data.to_json
      end

    end

  end
end

