require "rulers"

class QuotesController < Rulers::Controller
  def a_quote
    @noun = "blinking"
    render(:a_quote)
  end
  
  def quote_1
    quote_1 = FileModel.find(1)
    render(:quote, :obj => quote_1)
  end
  
  def index
    render(:index, :quotes => FileModel.all)
  end
  
  def new_quote
    attrs = {
      "submitter"   => "web user",
      "quote"       => "A picture is worth a thousand pixels 2",
      "attribution" => "Me" 
    }
    
    m = FileModel.create(attrs)
    render(:quote, :obj => m)
  end
  
  def update_quote
    raise "Must use POST" unless env["REQUEST_METHOD"] == "POST"
    
    quote_1 = FileModel.find(1)
    quote_1["submitter"] = "Isaac '#{rand(100000)}' Murchie"
    
    quote_1.save
    
    render(:quote, :obj => quote_1)
  end
  
  def quotes_by_submitter
    render(:by_submitter, :quotes => FileModel.find_all_by_submitter("web user"))
  end
  
    # for checking what the app does with an uncaught exception
  def exception
    raise "It's a bad one!"
  end
end