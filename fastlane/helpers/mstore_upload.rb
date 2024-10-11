module Fastlane
  module Helper
    class UploadToMstore
      def self.upload_app_to_mstore(authorization:, app_dev_token:, info_file:, build_file:, platform:)
        UI.message("Uploading app to Mstore...")

        command = []
        command << "curl"
        command << "-X" << "POST"
        command << "https://store.mobelite.fr/console/api_dev.php/api/upload_version"
        command << "-H \"Authorization: #{authorization}\""
        command << "-F \"applicationToken=#{app_dev_token}\""
        command << "-F \"fileInfo=@#{info_file}\""
        command << "-F \"file=@#{build_file}\""
        command << "-s"  # Silent mode it hides progress information
        command << "-S"  # Show error message if it fails
        command << "-o" << "-"  # Output to stdout it outputs the response to the terminal or script (stdout).

        begin
          UI.message("Executing command: #{command.join(" ")}")
          result = Actions.sh(command.join(" "), log: false)

          UI.message("Raw response: #{result}")

          if result.include?('"success":true')
            version_token_match = result.match(/"versionToken":"([^"]+)"/)
            version_token = version_token_match ? version_token_match[1] : nil

            if version_token
              UI.message("version_token: #{version_token}")
              download_url = "https://store.mobelite.fr/console/version/#{version_token}/download"
              UI.message("Download URL: #{download_url}")

              env_var_name = case platform.to_sym
              when :ios
                "IOS_VERSION_TOKEN"
              when :android
                "ANDROID_VERSION_TOKEN"
              else
                raise "Unsupported platform: #{platform}"
              end

              ENV[env_var_name] = download_url
              UI.message("Set environment variable #{env_var_name}=#{download_url}")

              if ENV['GITHUB_OUTPUT']
                File.open(ENV['GITHUB_OUTPUT'], 'a') do |f|
                  f.puts "#{env_var_name}=#{download_url}"
                end
                UI.message("Added #{env_var_name} to GITHUB_OUTPUT")
              end

              UI.success("Successfully uploaded app to Mstore")
              return { success: true, download_url: download_url, version_token: version_token, raw_response: result }
            else
              UI.error("Failed to extract version token from response")
              return { success: false, error: "Failed to extract version token", raw_response: result }
            end
          else
            UI.error("Failed to upload app to Mstore")
            return { success: false, error: "Upload failed", raw_response: result }
          end
        rescue => e
          UI.error("An unexpected error occurred: #{e.message}")
          UI.error(e.backtrace.join("\n"))
          return { success: false, error: e.message }
        end
      end
    end
  end
end
