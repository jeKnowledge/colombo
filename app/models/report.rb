class Report < Audit
  has_many :purchases, dependent: :destroy
  mount_uploader :report, ReportUploader

  validates_presence_of :rating, :report
end
