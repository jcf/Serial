#
#  SerialController.rb
#  Serial
#
#  Created by James Conroy-Finn on 31/05/2011.
#  Copyright 2011 logi.cl. All rights reserved.
#

class SerialController < NSWindowController
  attr_accessor :email_text_field
  attr_accessor :serial_text_field
  attr_accessor :hmac_sha1_button
  attr_accessor :sha2_button

  def controlTextDidChange(sender)
    update_serial
  end
  
  def find_selected_encryptor_button(sender)
    Serial.encryptor = sender.selectedCell.tag
    update_serial
  end

  private

  def update_serial
    serial_text_field.stringValue = Serial.from_email(email_text_field.stringValue).to_s
  end
end