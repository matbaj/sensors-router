load 'apisender.rb'
load 'serial.rb'
url="http://192.168.0.36:3000"
key="demo"
sensors={}
serial = SerialReader.new("/dev/ttyUSB0", sensors)
api = ApiSender.new(url,key,sensors)
while true
sleep 10
end
