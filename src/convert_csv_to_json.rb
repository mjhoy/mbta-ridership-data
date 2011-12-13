# convert_cvs_to_json.rb
#
# take the data files in ../data and make JSON files out of them.


require 'csv'
require 'fileutils'
require 'json'
require 'pp'

files = Dir['data/*.csv']
output_dir = 'json'
FileUtils.mkdir_p output_dir

# Takes an array of hashes to be exported as JSON. We need
# to convert all number-like strings to numbers.
def clean(arr)
  arr.map do |hsh|
    obj = {}
    hsh.each do |key, value|
      if value and value.match /^-?\d+(\.\d+)?$/
        value = value.to_f
      end
      obj[key] = value
    end
    obj
  end
end

files.each do |path|

  raw_arr = []

  CSV.open(path, { :headers => true }) do |csv|
    csv.each do |row|
      raw_arr.push row.to_hash
    end
  end

  arr = clean(raw_arr)

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

