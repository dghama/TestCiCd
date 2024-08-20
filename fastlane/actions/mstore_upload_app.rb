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

        result = Actions.sh(command.join(" "), log: false)

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
        
          return {
            success: true,
            version_url: version_url
          }
        else
          UI.error("Failed to upload app to Mstore: #{response['msg']}")
          return { success: false }
        end
        return result
      end

      def self.description
        "Uploads an Android app to Mstore"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :authorization,
                                       env_name: "AUTHORIZATION",
                                       description: "Authorization token for Mstore",
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :app_dev_token,
                                       env_name: "APP_DEV_TOKEN",
                                       description: "App dev token for Mstore",
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :info_file,
                                       env_name: "info_file",
                                       description: "Path to the output-metadata.json file",
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :build_file,
                                       env_name: "build_file",
                                       description: "Path to the APK file",
                                       is_string: true)
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
