class User < ApplicationRecord
  has_secure_password
  attr_accessor :password

  after_save :generate_username
  validate :password_validation, on: :create
  validate :update_password_validation, on: :update

  validates_presence_of :email, :name
  validates :terms_of_service, acceptance: true, on: :create

  def messages_sent
    Message.where(source_id: self.id)
  end

  def messages_received
    Message.where(destiny_id: self.id)
  end

  def prefix
    ''
  end

  def generate_username
    self.update_column(:username , "#{self.prefix}#{self.name[0..2]}#{self.id}".downcase)
  end

  def password_validation
    has_at_least_8_length = self.password.length >= 8
    has_digit = !(self.password =~ /[0-9]/).nil?
    has_lower_case_character = !(self.password =~ /[a-z]/).nil?
    has_upper_case_character = !(self.password =~ /[A-Z]/).nil?
    has_symbol = !(self.password =~ /^([0-9]|[a-z]|[A-Z])/).nil?

    unless has_digit && has_lower_case_character && has_upper_case_character && has_symbol
      self.errors.add(:password, "must be at least 8 characters long, contain a digit, a lower case letter, a upper case letter and a symbol")
      puts self.errors.inspect
    else
      self.password_digest = BCrypt::Password.create(self.password)
    end
  end

  def update_password_validation
    password_validation unless self.password.length == 0
  end
end
