# Serial

Generate a serial number using only an email address. You can choose to
digest the email using either SHA2 or HMAC SHA1.

There's a simple GUI that automatically generates a serial when the
email field contains something that looks like an email and when the
digest algorithm is changed.

I've tried to use Cocoa's MVC properly but I'm still not sure about the
exact separation of logic that I should use.

## Serial.rb

All of the encryptor logic is in here.

## SerialController.rb

This file is the delegate of all controls and directs user input to the
Serial model.
