class Request < Audit
  belongs_to :client

  validates_presence_of :client 
end
