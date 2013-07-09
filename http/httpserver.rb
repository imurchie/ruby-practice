require "socket"
require "uri"


module Practice
  class HttpServer
    DEFAULT_WEB_ROOT      = "./public"
    DEFAULT_FILE          = "index.html"
    DEFAULT_CONTENT_TYPE  = "application/octet-string"

    CONTENT_TYPE_MAPPING  = {
      "html"  =>  "text/html",
      "txt"   =>  "text/plain",
      "png"   =>  "image/png",
      "jpg"   =>  "image/jpg"
    }

    
    
    
    def initialize(host = "localhost", port = 2345)
      @server = TCPServer.new(host, port)
    end

    public
    def start
      loop do
        socket  = @server.accept
        request = HttpRequest.new(socket.gets)
  
        STDERR.puts "Request: #{request}"
        
        response = HttpResponse.new(request)
  
        #path = requested_file(request)
        STDERR.puts "    File: #{response.path}"
        
        socket.print(response)
  
        socket.close
      end
    end
  end
  
  class HttpResponse
    attr_reader :request_method, :path, :response_string
    
    def initialize(request)
      @request_method   = request.method
      
      @path             = requested_file(request.uri)
      
      @response_string  = populate_response
    end
    
    def to_s
      response_string
    end
    
    private
    def populate_response
      res = ""
      
      if File.exist?(path) && !File.directory?(path)
        File.open(path, "rb") do |file|
          res << "HTTP/1.1 200 OK\r\n"
          res << "Content-Type: #{content_type(file)}\r\n" +
          res << "Content-Length: #{file.size}\r\n" +
          res << "Connection: close\r\n" +
          res << "\r\n"
          
          res << file.read if request_method == :GET
          
          res << "\r\n"
        end
      else
        res << "HTTP/1.1 404 Not Found\r\n" +
        res << "Content-Type: text/plain\r\n" +
        res << "Content-Length: #{message.size}\r\n" +
        res << "Connection: close\r\n" +
        res << "\r\n"
        
        res << "File not found" if request_method == :GET
      end
      
      res
    end
    
    # implementation stolen from Rack::File
    private
    def requested_file(uri)
      path = URI.unescape(URI(uri).path)
  
      clean = []
  
      parts = path.split("/")
  
      parts.each do |part|
        next if part.empty? || part == "."
    
        part == ".." ? clean.pop : clean << part
      end
  
      path = File.join(HttpServer::DEFAULT_WEB_ROOT, *clean)
  
      # use default if it is a directory
      path = File.join(path, HttpServer::DEFAULT_FILE) if File.directory?(path)
      
      path
    end
    
    private
    def content_type(path)
      ext = File.extname(path).split(".").last
      HttpServer::CONTENT_TYPE_MAPPING.fetch(ext, HttpServer::DEFAULT_CONTENT_TYPE)
    end
  end
  
  class HttpRequest
    attr_reader :method, :uri, :protocol
    
    def initialize(request_line)
      # GET /etc/passwd HTTP/1.1
      parts = request_line.split(" ")
      
      @method   = parts[0].to_sym
      @uri      = parts[1]
      @protocol = parts[2]
    end
    
    def to_s
      #"<type: #{type}; uri: #{uri}; protocol: #{protocol}>"
      "#{protocol} #{method} request: #{uri}"
    end
  end
end

server = Practice::HttpServer.new
server.start