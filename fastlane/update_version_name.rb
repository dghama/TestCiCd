require 'json'

# Load the package.json file
package_file = File.read('../package.json')  # Adjusted path
package_data = JSON.parse(package_file)

# Get the version from package.json
new_version = package_data['version']
new_version_with_app_name = "#{package_data['name']}-#{new_version}-#{ENV['ENVIRONMENT'] || 'dev'}"

# Update the build.gradle file
build_gradle_path = '../android/app/build.gradle'  # Adjusted path
if File.exist?(build_gradle_path)
  file_content = File.read(build_gradle_path)
  updated_content = file_content.gsub(/versionName ".*"/, "versionName \"#{new_version_with_app_name}\"")
  File.open(build_gradle_path, 'w') { |file| file.write(updated_content) }
  puts "Updated Android versionName to #{new_version_with_app_name}"
else
  puts "build.gradle file does not exist at #{build_gradle_path}"
end
