require 'yaml'

ROOT_PATH = File.expand_path('../..', __dir__)
PUBSPEC_PATH = File.join(ROOT_PATH, 'pubspec.yaml')
FASTFILE_PATH = File.join(__dir__, 'Fastfile')

def get_current_version
  IO.foreach(PUBSPEC_PATH) do |line|
    return line.strip.split(' ')[1] if line.start_with?("version:")
  end
  "0.0.0+0"
end

def auto_increment_version
  current = get_current_version
  version_part, build_part = current.split('+')
  version_numbers = version_part.split('.')
  major = version_numbers[0].to_i
  minor = version_numbers[1].to_i
  patch = version_numbers[2].to_i
  build = build_part.to_i

  # Increment the patch version when updating the build number
  patch += 1
  build = 1  # Reset the build number to 1

  # If patch reaches 10, increment minor and reset patch
  if patch >= 10
    patch = 0
    minor += 1
  end

  # If minor reaches 10, increment major and reset minor
  if minor >= 10
    minor = 0
    major += 1
  end

  new_version = "#{major}.#{minor}.#{patch}+#{build}"

  lines = File.readlines(PUBSPEC_PATH)
  lines.map! { |line| line.start_with?('version:') ? "version: #{new_version}\n" : line }
  File.write(PUBSPEC_PATH, lines.join)

  new_version
end

def update_fastfile_release_note(new_note)
  content = File.read(FASTFILE_PATH)
  updated = content.gsub(/release_notes: ".*?"/, "release_notes: \"#{new_note}\"")
  File.write(FASTFILE_PATH, updated)
  puts "✅ Fastfile updated with release note: #{new_note}"
end
