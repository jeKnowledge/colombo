class Report < Audit
  belongs_to :auditor

  mount_uploader :report, ReportUploader

  validates_presence_of :rating, :auditor, :price, :report, :summary

  before_create :set_date

  private
    def set_date
      self.date = Time.now
    end
end
