require "sqlite3"
require "rulers/sqlite_model"

class MyTable < Rulers::Model::SQLite
end

STDERR.puts MyTable.schema.inspect

# create row
#mt = MyTable.create("title" => "It happened!", "posted" => 1, "body" => "It did!")
#mt = MyTable.create("title" => "I saw it!")
#mt = MyTable.create("title" => "I saw it again!")

#puts mt.private_methods
#exit

#mt["title"] = "I really did!"
#mt.title = "I really did again!"
#mt.title = "something different"
#mt.save!

#mt2 = MyTable.find(mt["id"])
#puts "Found title: #{mt2["title"]}"

mt2 = MyTable.find(33)
puts "id: #{mt2.id.class}"
puts "Found title (id=#{mt2.id}): #{mt2.title}"