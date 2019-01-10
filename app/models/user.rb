class User < ApplicationRecord
  # Attributes
  attr_accessor :password_confirmation

  # Callbacks
  after_create :generate_username
  before_create :generate_password

  # Validations
  validates_presence_of :email
  validate :password_validation, on: :update

  # Methods
  def messages_sent
    Message.where(source_id: self.id)
  end

  def messages_received
    Message.where(destiny_id: self.id)
  end

  def country_name
    ISO3166::Country[self.country].name
  end

  # Callback methods
  def generate_password
    self.password = SecureRandom.base64(12) unless self.password.present?
    self.password = BCrypt::Password.create(self.password)
  end

  def generate_username
    self.update_column(:username , "#{self.prefix}#{Date.today.year}#{self.id}".downcase)
  end

  # Validation methods
  def password_validation
    return if self.password.length == 0

    same_as_confirmation = self.password == self.password_confirmation
    has_at_least_8_length = self.password.length >= 8
    has_digit = !(self.password =~ /[0-9]/).nil?
    has_lower_case_character = !(self.password =~ /[a-z]/).nil?
    has_upper_case_character = !(self.password =~ /[A-Z]/).nil?
    has_symbol = !(self.password =~ /^([0-9]|[a-z]|[A-Z])/).nil?

    unless same_as_confirmation && has_digit && has_lower_case_character && has_upper_case_character && has_symbol
      self.errors.add(:password, "must match password confirmation and be at least 8 characters long, contain a digit, a lower case letter, a upper case letter and a symbol")
    else
      self.password = BCrypt::Password.create(self.password)
    end
  end
end
