class Report < Audit
  validates_presence_of :rate, :author_id
end
