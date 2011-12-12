# convert_cvs_to_json.rb
#
# take the data files in ../data and make JSON files out of them.


require 'csv'
require 'fileutils'
require 'json'

files = Dir['data/*.csv']
output_dir = 'json'
FileUtils.mkdir_p output_dir

files.each do |path|

  arr = []

  CSV.open(path, { :headers => true }) do |csv|
    csv.each do |row|
      arr.push row.to_hash
    end
  end

  # Output the JSON data.
  name = File.basename(path).gsub(/#{File.extname(path)}$/, '')
  to_write = output_dir + '/' + name + '.json'
  to_write_min = output_dir + '/' + name + '.min.json'
  File.open(to_write, 'w') do |f|
    f.write(JSON.pretty_generate(arr))
  end
  File.open(to_write_min, 'w') do |f|
    f.write(arr.to_json)
  end
end

