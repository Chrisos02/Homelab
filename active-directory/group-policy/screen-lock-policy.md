# Screen Lock Policy

## Purpose
Automatically lock inactive user sessions.

## Configuration
- Linked to OU_Users
- Enable Screen Saver
- Screen Saver Timeout = 300 seconds
- Password protect screen saver = Enabled

## Validation
- gpupdate /force
- gpresult /r
- Confirm workstation locks after 5 minutes

## Screenshots
- screen-lock-gpo.png
- gpresult-screen-lock.png
- screen-lock-test.png
