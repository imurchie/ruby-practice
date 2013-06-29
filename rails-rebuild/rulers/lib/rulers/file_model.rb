require "multi_json"

module Rulers
  module Model
    class FileModel
      @objects = {}
      
      def initialize(filename)
        @filename = filename
        
        # if the filename is 'dir/37.json', @id = 37
        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i
        
        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end
      
      def [](name)
        @hash[name.to_s]
      end
      
      def []=(name, value)
        @hash[name.to_s] = value
      end
      
      def save
        File.open(@filename, "w") do |f|
          f.write(MultiJson.dump(@hash))
        end
      end
      
      
      def self.find(id)
        f = @objects[id.to_i]
        f ||= FileModel.new("db/quotes/#{id}.json")
      rescue Exception => e
        puts "EXCEPTION: #{e.inspect}"
        nil
      end
      
      def self.find_all_by_submitter(submitter)
        possibilities = all
        all.select do |f|
          f["submitter"] == submitter
        end
      end
      
      def self.all
        files = Dir["db/quotes/*.json"]
        files.map do |f| 
          f_o = FileModel.new(f)
          
          @objects[f_o["id"].to_i] = f_o
          
          f_o
        end
      end
      
      def self.create(attrs)
        hash = {
          "submitter"    => attrs["submitter"] || "",
          "quote"        => attrs["quote"] || "",
          "attribution"  => attrs["attribution"] || ""
        }
        
        files = Dir["db/quotes/*.json"]
        names = files.map { |f| f.split("/")[-1] }
        highest = names.map { |b| b[0...-5].to_i }.max
        id = highest + 1
        
        File.open("db/quotes/#{id}.json", "w") do |f|
          f.write <<TEMPLATE
{
  "submitter": "#{hash["submitter"]}",
  "quote": "#{hash["quote"]}",
  "attribution": "#{hash["attribution"]}"
}
TEMPLATE
        end
        
        f = FileModel.new("db/quotes/#{id}.json")
        @objects[id] = f
        f
      end
    end
  end
end