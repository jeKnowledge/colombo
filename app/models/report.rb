class Report < Audit
  mount_uploader :report, ReportUploader

  validates_presence_of :rating, :report
end
