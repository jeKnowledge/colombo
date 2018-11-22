class Report < Audit
  has_many :purchases, dependent: :destroy
  mount_uploader :report, ReportUploader

  validates_presence_of :rating, :report

  def rating
    if ratings != 0
      return rating_sum / self.ratings
    else
      return "Not rated"
    end
  end

  def rate(rating)
    self.auditor.rate(rating)
    self.rating_sum += rating
    self.ratings += 1
    self.save
  end
end
