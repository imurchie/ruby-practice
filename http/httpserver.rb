require "socket"
require "uri"


module Practice
  class HttpServer
    WEB_ROOT      = "./public"
    DEFAULT_FILE  = "index.html"

    CONTENT_TYPE_MAPPING = {
      "html"  =>  "text/html",
      "txt"   =>  "text/plain",
      "png"   =>  "image/png",
      "jpg"   =>  "image/jpg"
    }

    DEFAULT_CONTENT_TYPE = "application/octet-string"
    
    
    def initialize(host = "localhost", port = 2345)
      @server = TCPServer.new(host, port)
    end

    private
    def content_type(path)
      ext = File.extname(path).split(".").last
      CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
    end

    # implementation stolen from Rack::File
    private
    def requested_file(request_line)
      request_uri = request_line.split(" ")[1]
      path        = URI.unescape(URI(request_uri).path)
  
      clean = []
  
      parts = path.split("/")
  
      parts.each do |part|
        next if part.empty? || part == "."
    
        part == ".." ? clean.pop : clean << part
      end
  
      path = File.join(WEB_ROOT, *clean)
  
      # use default if it is a directory
      path = File.join(path, DEFAULT_FILE) if File.directory?(path)
      
      path
    end


    public
    def start
      loop do
        socket        = @server.accept
        request_line  = socket.gets
  
        STDERR.puts "Request: #{request_line}"
  
        path = requested_file(request_line)
        STDERR.puts "    File: #{path}"
  
        if File.exist?(path) && !File.directory?(path)
          serve_page(socket, path)
        else
          serve_error(socket)
        end
  
        socket.close
      end
    end
    
    private
    def serve_page(socket, path)
      File.open(path, "rb") do |file|
        socket.print  "HTTP/1.1 200 OK\r\n" +
                      "Content-Type: #{content_type(file)}\r\n" +
                      "Content-Length: #{file.size}\r\n" +
                      "Connection: close\r\n" +
                      "\r\n"
        IO.copy_stream(file, socket)
        socket.print  "\r\n"
      end
    end
    
    private
    def serve_error(socket)
      message = "File not found\n"

      socket.print  "HTTP/1.1 404 Not Found\r\n" +
                    "Content-Type: text/plain\r\n" +
                    "Content-Length: #{message.size}\r\n" +
                    "Connection: close\r\n" +
                    "\r\n" +
                    "#{message}"
    end
  end
end

server = Practice::HttpServer.new
server.start