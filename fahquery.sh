#!/usr/bin/expect -f

log_user 0
set timeout 60
set prompt  ">"

spawn -noecho telnet [lindex $argv 0] 36330
expect $prompt
send "auth [lindex $argv 1]\r"
expect $prompt
send "queue-info\r"
set slots {}
set timout 5
expect {
	-regexp {\{.*?\}} {
		set slots "${slots}$expect_out(0,string)"
		set slots "${slots}|"
		exp_continue
	}
}
puts $slots
expect $prompt
send "quit\r"