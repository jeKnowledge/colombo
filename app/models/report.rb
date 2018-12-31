class Report < Audit
  # Relationships
  has_many :purchases, dependent: :destroy

  # Uploader
  mount_uploader :report, ReportUploader

  # Validations
  validates_presence_of :rating, :report

  # Methods
  def rating
    if rating_sum != 0
      return rating_sum / self.ratings
    else
      return Audit::get_default_rating()
    end
  end

  def rate(rating)
    self.auditor.rate(rating)
    self.rating_sum += rating
    self.ratings += 1
    self.save
  end

  def upload_date
    timestamp = self.report_identifier.split("_")[1].split(".")[0].to_i
    Time.at(timestamp).to_date
  end
end
