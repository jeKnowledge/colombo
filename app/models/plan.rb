class Plan < Audit
  validates_presence_of :requester_id, :author_id
end
