#
#  Serial.rb
#  Serial
#
#  Created by James Conroy-Finn on 31/05/2011.
#  Copyright 2011 logi.cl. All rights reserved.
#

class Serial
  PEPPER = '75748db750d911b5075b30cf77d7f56b3a7ebcfe75f623421f593231dad16ca1532a4816564a0da4595bb86a93bcab27c31242a78d4519c742adc75f2cddfdaa'
  STRETCHES = 21
  LENGTH = 40
  GROUP_SIZE = 5

  EMAIL_PREDICATE = NSPredicate.predicateWithFormat("SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")

  ENCRYPTOR_TAGS = {
  0 => :sha1,
  1 => :hmac
  }
  ENCRYPTOR_TAGS.default = :hmac
  
  class << self
    def encryptor
      @encryptor || :hmac
    end
    
    def encryptor=(tag)
      @encryptor = ENCRYPTOR_TAGS[tag]
    end
  end

  def self.from_email(email)
    serial = new(email)
    serial.generate if serial.email_valid?
  end

  attr_reader :email

  def initialize(email)
    @email = email
  end

  def email_valid?
    EMAIL_PREDICATE.evaluateWithObject(email)
  end

  def generate
    digest.split(//).map.with_index do |char, index|
      ((index + 1) % GROUP_SIZE) == 0 ? "#{char} " : char
    end.join.upcase
  end

  private

  def digest
    if self.class.encryptor == :hmac
      require 'openssl'
      stretches do |string|
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), PEPPER, string)
      end
    else
      require 'digest/sha2'
      stretches { |string| Digest::SHA2.hexdigest(string) }
    end
  end

  def stretches(&block)
    out = block.call("#{email}--#{PEPPER}")
    STRETCHES.times {
      out = block.call(out)
    }
    out[0, LENGTH]
  end
end