#!/usr/bin/expect -f

log_user 0
set timeout 5
set prompt  ">"

spawn -noecho telnet [lindex $argv 0] 36330
#expect $prompt 
expect {
	"No route to host" { exit 1 }
	">"
}
send "auth [lindex $argv 1]\r"
expect $prompt
send "queue-info\r"
set slots {}
set timout 2
expect {
	-regexp {\{.*?\}} {
		set slots "${slots}$expect_out(0,string)"
		set slots "${slots}|"
		exp_continue
	}
	timeout { }
	eof { }
}
puts $slots
expect $prompt
send "quit\r"
