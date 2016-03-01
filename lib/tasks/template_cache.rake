namespace :fastly do
  namespace :template_cache do

    desc 'Print out template digest manfiest'
    task :print_manifest => :environment do

      manifest = FastlyRails::TemplateCache::Manifest.new
      puts manifest.view_templates.to_json

    end

  end
end

