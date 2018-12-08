class User < ApplicationRecord
  attr_accessor :terms

  has_secure_password

  after_save :generate_username

  validates_presence_of :email, :name

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
end
