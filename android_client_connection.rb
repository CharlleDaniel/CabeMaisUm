class AndroidClientConnection
  
  attr_accessor :socket, :token, :id, :curret_time

  def initialize (socket, token, id)
    @socket = socket
    @token = token
    @id = id
    @curret_time = Time.now
  end
end   