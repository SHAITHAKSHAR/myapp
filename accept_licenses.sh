#!/usr/bin/expect -f

set timeout -1
spawn flutter doctor --android-licenses

expect {
  "Review licenses that have not been accepted (y/N)?" {
    send "y\r"
    exp_continue
  }
  "Accept? (y/N):" {
    send "y\r"
    exp_continue
  }
  eof
}
