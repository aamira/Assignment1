#asks the user for an URI and shows the summary

class Info
  #this class is to store all the information needed to solve this problem
  attr_reader :num_of_user, :get_req, :post_req, :get_time, :post_time
  
  def initialize
    @users = []
    @num_of_user = 0
    @get_req = 0
    @get_time = 0
    @post_req = 0
    @post_time = 0  
  end
  
  #updates the variables
  def push(username,req, time)
    @users.push(username) unless @users.include?username
    @num_of_user = @users.length
    if req.eql?"G"
      @get_req += 1
      @get_time += time
    elsif req.eql?"P"
      @post_req += 1
      @post_time += time
    end
  end 
  
  #returns a string containing - total number of unique users,
  #                            - total get requests
  #                            - total post requests
  #                            - time for get requests (in ms)
  #                            - time for post requests (in ms)
  #                            - total time (get+post) (in ms)
  def to_s
    "#{num_of_user}-----#{get_req}-----#{post_req}-----#{get_time}-----#{post_time}-----#{get_time+post_time}"
  end
  
end

#creates a hash with Info objects as values
data = Hash.new {|h,k| h[k]=Info.new}

#input
print "Please enter an URI "
uri = gets.chomp
  
begin
  #file = File.new("sample.txt", "r")
  file = File.new("therap.log.ms-2.2013-10-21 ", "r")
  output = File.new("output1.txt","w")
  while line = file.gets
    if line.include? "[PROFILER:132]" and line.include?uri  
      arr = line.split(" ")
      current_hour = arr[1].to_i
      #puts current_hour
      id = arr[9][2..arr[9].length-1]
      method = arr[15][0]
      time = arr[16][5..arr[16].length-3].to_i
          
      data[current_hour].push(id,method,time)
          
    end
  end
    
  file.close
  #writes output
  output.write("24 Hour Report for URI = "+uri + "\n")
  output.write("hour-----unique_users-----get_req-----post_req-----get_time-----post_time-----total_time\n")
  
  24.times do |n|
    output.write("#{n}-----"+data[n].to_s+"\n")
  end
rescue => err
  puts err
end