#asks the user for a username and shows the time used

while true
  #input
	print "Please enter the username: "
	user_id = gets.chomp

	get_time = 0
	post_time = 0

	begin
		#file = File.new("sample.txt", "r") 
		file = File.new("therap.log.ms-2.2013-10-21 ", "r") 
		while line = file.gets
    		if line.include? "[PROFILER:132]"    
    			arr = line.split(" ")
    			id = arr[9][2..arr[9].length-1]
    			method = arr[15][0]
    			time = arr[16][5..arr[16].length-3].to_i
 
    			if id.eql?user_id
    				get_time += time if method.eql?"G"
    				post_time += time if method.eql?"P" 
    			end
    		end
  	end  
 
    #prints output in console
  	puts "User: #{user_id}"
  	puts "Total time: #{get_time+post_time} ms"
  	puts "Get Time: #{get_time} ms"
  	puts "Post Time: #{post_time} ms"
    
    file.close
	rescue => err
  		puts err
	end
end