# rapid-portscanner
Very fast portscanner written in Ruby as POC for competition

# Usage

For now you can specify only single host with `-h` CLI argument.
You can specify ports/range of ports with `-p` argument.
You can specify request message sent to each port with `-m` which doesn't work on all ports but sends that request to all of them. Default message is "HELLO"

Enter `ruby scan.rb --help` in terminal for further explanation of usage

# Example

`ruby scan.rb -h 127.0.0.1 -p 21,22,23,80,8080,443 -m pentest`
or range of ports
`ruby scan.rb -h 127.0.0.1 -p 1-10000`
or all ports that exist
`ruby scan.rb -h [target ip] -p 1-65535`

If you want to only display ports that are open

`ruby scan.rb -h [target ip] -p 1-65535 | grep -v "Connection refused"`
