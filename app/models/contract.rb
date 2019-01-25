class Contract < Consent
  # Methods
  def select
    Contract.update_all(active: false)
    self.update_attribute(:active, true)
  end

  def generate_pdf
    save_path = Rails.root.join('storage', "contract_#{self.id}.pdf")

    unless File.exist?(save_path)
      pdf_format = WickedPdf.new.pdf_from_string(Markdown.new(self.body).to_html)
      File.open(save_path, 'wb') { |file| file << pdf_format }
    end

    return save_path
  end
end
