class SerialReader
	def initialize(port,sensors)
		puts "Initializing serial reader on port #{port}"
		@fd = IO.sysopen(port, "r") 
		@io = IO.new(@fd, "r")
		@alive = true
		@thread= Thread.new{self.listen()} 
		@sensors =sensors
	end

	def listen
		puts "Starting listener"
		while @alive
			puts "listening"
			line = @io.gets
			puts line
			if !line.index("sensor").nil?
				key,value = line.split(";")[1].split(":")
				@sensors[key] = value	
			end
			puts 

		end
	end
	def stop
		@alive =false
	end
end

