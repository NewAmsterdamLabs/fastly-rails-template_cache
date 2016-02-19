module FastlyRails
  class TemplateCache
    class Purger

      def initialize(previous_manifest, current_manifest)
        @previous_manifest = previous_manifest
        @current_manifest = current_manifest

        puts "Previous: #{@previous_manifest}"
        puts "Current: #{@current_manifest}"
      end

      def purge_stale!
        stale_templates = find_stale
        purge_templates(stale_templates)
      end


      private

      def purge_templates(templates)
        # TODO: Add actual purge logic here
        templates.each do |template|
          puts "Purging: #{template}"
        end
      end

      def find_stale
        previous_data = extract_previous_data
        current_data = extract_current_data


        # if exists and is same:        no_purge
        # if exists and is different    purge
        # if not exists                 purge
        #  {
        #    file1: '111',
        #    file2: '222',
        #    file3: '333',
        #    file5: '555'
        #  }

        #  {
        #    file1: '111',
        #    file2: '-222',
        #    file5: '555'
        #  }

        stale_templates = []

        previous_data.each do |template, previous_digest|
          current_digest = current_data[template]

          if current_digest.nil? || current_digest != previous_digest
            stale_templates << template
          end
        end

        stale_templates
      end

      def extract_previous_data
        JSON.parse(File.read(@previous_manifest))
      end

      def extract_current_data
        JSON.parse(File.read(@current_manifest))
      end
    end
  end
end
