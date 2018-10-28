class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def render_errors
    if self.errors.any?
      self.errors.full_messages.each do |message|
        <li><%= message %></li>
      end
    end
  end
end
