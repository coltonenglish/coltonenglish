#!/usr/bin/env ruby
require 'json_schemer'
require 'yaml'
require 'net/http'
require 'json'
require 'pathname'

schema_url = "https://raw.githubusercontent.com/jsonresume/jsonresume.org/refs/heads/master/packages/schema/schema.json"
resume_path = "_data/resume.yaml"

begin
  uri = URI(schema_url)
  schema_data = JSON.parse(Net::HTTP.get(uri))
  schemer = JSONSchemer.schema(schema_data)

  resume_data = YAML.safe_load(File.read(resume_path))

  # YAML.safe_load might return dates as Date objects,
  # but JSON schema expects strings. Convert to JSON and back to ensure types.
  resume_json_compatible = JSON.parse(resume_data.to_json)

  errors = schemer.validate(resume_json_compatible).to_a

  if errors.empty?
    puts "Resume is valid according to the schema."
  else
    puts "Validation Errors:"
    errors.each do |error|
      puts "- #{error['data_pointer']}: #{error['type']} #{error['details']}"
    end
    exit 1
  end
rescue => e
  puts "An error occurred: #{e.message}"
  exit 1
end
