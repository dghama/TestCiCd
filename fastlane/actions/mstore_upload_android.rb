module Fastlane
    module Actions
      class MstoreUploadAndroidAction < Action
        def self.run(params)
          UI.message("Uploading app to Mstore...")
  
          command = []
          command << "curl"
          command << "-X POST"
          command << "https://store.mobelite.fr/console/api_dev.php/api/upload_version"
          command << "-H \"Authorization: #{params[:authorization]}\""
          command << "-F \"applicationToken=#{params[:app_dev_token]}\""
          command << "-F \"fileInfo=@#{params[:info_file]}\""
          command << "-F \"file=@#{params[:apk_file]}\""
  
          result = Actions.sh(command.join(" "))
          UI.success("Successfully uploaded app to Mstore!")
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
                                         env_name: "MSTORE_INFO_FILE",
                                         description: "Path to the output-metadata.json file",
                                         is_string: true),
            FastlaneCore::ConfigItem.new(key: :apk_file,
                                         env_name: "MSTORE_APK_FILE",
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