#asks the user for an hour and shows the summary of that hour

while true
  #input
  print "Please enter an hour: (0 to 23) "
  input_hour = Integer(gets.chomp)  
  if input_hour>=0 && input_hour<=23
     begin
      #file = File.new("sample.txt", "r")
      file = File.new("therap.log.ms-2.2013-10-21 ", "r")
      output = File.new("output.txt","w")
      while line = file.gets
        if line.include? "[PROFILER:132]"    
          arr = line.split(" ")
          current_hour = arr[1].to_i          
          if current_hour == input_hour
            #writes output in a file
            output.write("Hour="+arr[1]+" UserId="+arr[9][2..arr[9].length-1]+" "+arr[14][0..arr[14].length-2]+" Method="+arr[15][0]+" "+arr[16]+"\n")
          end          
        end
      end  
      file.close
    rescue => err
      puts err
    end
    else puts "Please enter a valid hour."
   end  
end