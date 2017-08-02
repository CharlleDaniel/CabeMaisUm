require 'socket'
require './android_client_connection'

class AndroidServer 

  def initialize
    @server = TCPServer.new('0.0.0.0',3000)
  end

  def start
    @connections = Hash.new
    Thread.start{
      loop do
        socket = @server.accept
        data = socket.gets
        data = data.split(",")
        token = data[0]
        id = data[1]
        connection = AndroidClientConnection.new(socket, token, id)

        @connections[id] = connection
      end
    }
    monitor_android_conection
  end

  def connections
    @connections
  end

  # The monitor delete the connection

  def monitor_android_connection
    Thread.start{
      loop do
        @connections.map do |key, connection| 
          if (Time.now - connection.curret_time).to_i > 86400
            begin
              connection.socket.close
              @connections.delete(key)
            rescue
              @connections.delete(key)
            end
          end
        end
        sleep 43201
      end
    }
  end
end 
