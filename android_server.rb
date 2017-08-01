require 'socket'

class AndroidServer 

  def initialize
    @server = TCPServer.new('0.0.0.0',3000)
  end

  def start
    @clients = []
    Thread.start{
      loop do
        client = @server.accept
          @clients.push(client)
      end
    }
  end

  def data
    @clients
  end
end 
