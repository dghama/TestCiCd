require 'json'

module Fastlane
  module Helper
    class VersionManagement

      def self.get_dynamic_github_url
        git_url = `git config --get remote.origin.url`.strip
        repo_path = git_url.gsub(/.*github.com[:\/]/, '').gsub(/\.git$/, '')
        "https://x-access-token:#{ENV['GITHUB_TOKEN ']}@github.com/#{repo_path}"
      end
      def get_repository_info
        git_url = `git config --get remote.origin.url`.strip
        # Remove the .git suffix if present
        git_url.gsub!(/\.git$/, '')
      
        # Extract the username/repository format
        if git_url.match?(/github\.com[:\/]/)
          # For SSH or HTTPS formats
          git_url.gsub!(/.*github\.com[:\/]/, '')
        else
          UI.error("Unsupported Git URL format")
          return nil
        end
      
        git_url
      end
      
      # Custom method to load JSON data
      def self.load_json(json_path:)
        file_content = File.read(json_path)
        JSON.parse(file_content)
      rescue StandardError => e
        UI.error("Failed to load JSON file: #{json_path}")
        UI.error(e.message)
        {}
      end

      def self.load_version_data
        load_json(json_path: "#{ENV['GITHUB_WORKSPACE']}/versions.json")
      end

      def self.save_version_data(data)
        File.write("#{ENV['GITHUB_WORKSPACE']}/versions.json", JSON.pretty_generate(data))
      end

      def self.increment_version
        data = load_version_data
        env = ENV["ENVIRONMENT"]
        data[env]['version_code'] += 1
        #amira update
        if ENV['MANUAL_VERSION']
        data[env]['version_name'] = ENV['MANUAL_VERSION'] 
        end
        save_version_data(data)
        data[env]
      end

      def self.update_package_json(version_data)
        package_json_path = "#{ENV['GITHUB_WORKSPACE']}/package.json"
        package_data = load_json(json_path: package_json_path)
        package_data['version'] = version_data['version_name']
        File.write(package_json_path, JSON.pretty_generate(package_data))
      end

      def self.update_android_files(version_code, version_name)
        gradle_file = "#{ENV['GITHUB_WORKSPACE']}/android/app/build.gradle"
        system("sed -i '' 's/versionCode .*/versionCode #{version_code}/' #{gradle_file}")
        system("sed -i '' 's/versionName .*/versionName \"#{version_name}\"/' #{gradle_file}")
      end
    end
  end
end
