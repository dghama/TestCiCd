module Fastlane
  module Actions
    class MstoreUploadAppAction < Action
      def self.run(params)
        UI.message("Uploading app to Mstore...")

        command = []
        command << "curl"
        command << "-X POST"
        command << "https://store.mobelite.fr/console/api_dev.php/api/upload_version"
        command << "-H \"Authorization: #{params[:authorization]}\""
        command << "-F \"applicationToken=#{params[:app_dev_token]}\""
        command << "-F \"fileInfo=@#{params[:info_file]}\""
        command << "-F \"file=@#{params[:build_file]}\""
        command << "-v"  # Verbose output for debugging

        begin
          UI.message("Executing command: #{command.join(" ")}")
          result = Actions.sh(command.join(" "), log: true)
          UI.message("Raw response from Mstore: #{result}")

          # Parse the JSON response
          response = JSON.parse(result)

          if response["success"]
            version_token = response["versionToken"]
            version_url = "https://store.mobelite.fr/console/version/#{version_token}/download"
            
            if ENV["PLATFORM"] == "ios"
              ENV["IOS_VERSION_TOKEN"] = version_url
            else
              ENV["ANDROID_VERSION_TOKEN"] = version_url
            end
          
            UI.success("Successfully uploaded app to Mstore")
            return {
              success: true,
              version_url: version_url
            }
          else
            UI.error("Failed to upload app to Mstore: #{response['msg']}")
            return { success: false, error: response['msg'] }
          end
        rescue FastlaneCore::Interface::FastlaneShellError => e
          UI.error("Shell command failed with exit status #{e.status}")
          UI.error("Error output: #{e.message}")
          return { success: false, error: e.message }
        rescue JSON::ParserError => e
          UI.error("Failed to parse JSON response: #{e.message}")
          UI.message("Raw response: #{result}")
          return { success: false, error: e.message }
        rescue => e
          UI.error("An unexpected error occurred: #{e.message}")
          UI.error(e.backtrace.join("\n"))
          return { success: false, error: e.message }
        end
      end

      def self.description
        "Upload the app to the Mstore"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :authorization,
                                       description: "Authorization token for Mstore API",
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :app_dev_token,
                                       description: "App development token",
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :info_file,
                                       description: "The info file to upload (.plist for iOS or .json for Android)",
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :build_file,
                                       description: "The build file to upload (.ipa for iOS or .apk for Android)",
                                       optional: false,
                                       type: String)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
      end
    end
  end
end
