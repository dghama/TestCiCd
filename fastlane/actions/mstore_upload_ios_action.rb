module Fastlane
    module Actions
      class MstoreUploadIosAction < Action
        def self.run(params)
          UI.message("Uploading iOS app to Mstore...")
  
          # Check if files exist
          unless File.exist?(params[:info_file])
            UI.user_error!("Info file not found at path: #{params[:info_file]}")
          end
  
          unless File.exist?(params[:ipa_file])
            UI.user_error!("IPA file not found at path: #{params[:ipa_file]}")
          end
  
          # Log file details
          UI.message("Info file: #{params[:info_file]}")
          UI.message("IPA file: #{params[:ipa_file]}")
  
          command = []
          command << "curl"
          command << "-X POST"
          command << "https://store.mobelite.fr/console/api_dev.php/api/upload_version"
          command << "-H \"Authorization: #{params[:authorization]}\""
          command << "-F \"applicationToken=#{params[:app_dev_token]}\""
          command << "-F \"fileInfo=@#{params[:info_file]}\""
          command << "-F \"file=@#{params[:ipa_file]}\""
  
          # Log the command (with sensitive data masked)
          UI.message("Executing command: #{command.join(" ").gsub(params[:authorization], '***').gsub(params[:app_dev_token], '***')}")
  
          begin
            result = Actions.sh(command.join(" "))
            UI.success("Successfully uploaded iOS app to Mstore!")
            return result
          rescue => ex
            UI.error("Failed to upload iOS app to Mstore")
            UI.error(ex.message)
            UI.error("Curl exit status: #{ex.exit_status}") if ex.respond_to?(:exit_status)
            raise
          end
        end
  
        def self.available_options
          [
            FastlaneCore::ConfigItem.new(key: :authorization,
                                         env_name: "MSTORE_AUTHORIZATION",
                                         description: "Authorization token for Mstore",
                                         is_string: true),
            FastlaneCore::ConfigItem.new(key: :app_dev_token,
                                         env_name: "MSTORE_APP_DEV_TOKEN",
                                         description: "App dev token for Mstore",
                                         is_string: true),
            FastlaneCore::ConfigItem.new(key: :info_file,
                                         env_name: "MSTORE_INFO_FILE",
                                         description: "Path to the info plist file",
                                         is_string: true),
            FastlaneCore::ConfigItem.new(key: :ipa_file,
                                         env_name: "MSTORE_IPA_FILE",
                                         description: "Path to the IPA file",
                                         is_string: true)
          ]
        end
  
        def self.is_supported?(platform)
          platform == :ios
        end
      end
    end
  end