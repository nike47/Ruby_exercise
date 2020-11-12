require 'csv'
require 'pg'

class UserManager

    def initialize(path)
        @path = path
        @offset = 0
        load

    end

    def show
        
       
        # puts @headers[0]
        # puts @limit
        # puts @max_length
        # puts @search
        # puts @results
        @result = @result.to_a
        puts @max_length
        # [@offset...@max_length].each do |row| 
        #     puts @result[row].values
        # end
        @result = @result[@offset...@max_length]
        @result.each do |x|
            a = Hash[x]
            puts a.values
        end
        self
    end

    def write
        a = CSV.open("assets/out.csv","w")
        @result = @result.to_a
        column_names = @result.first.keys
        puts column_names
        s=CSV.generate do |csv|
            csv << column_names
            @result = @result[@offset...@max_length]
            
            @result.each do |x|
                a = Hash[x]
                csv << a.values
              end
          end
          File.write('assets/out.csv', s)
    #     [@offset...@max_length].each do |row| 
    #     a << @result[row].to_a
    # end
           self
    end


    def offset(off)
        @offset = off
        self
    end

    def limit(lim)
        @max_length = lim
        self
    end
   
    def search(n)
        
        @result = []
        if !@final.nil?
            @final.each do |row|
                if row['id'] == n or row['first_name'] == n or row['second_name'] == n or row['email'] == n
                    @result << row
                end
            end
        else
            @final = @con.exec "SELECT * FROM Users WHERE first_name = '#{n}' OR second_name = '#{n}' OR email = '#{n}'"
        end
        if @result.nil?
            @result = @final
        end
        self
    end

    def sort(fi, dir)
        
        if !@final.nil?
            if dir == 'ASC'
            @result = @final.sort{|h,s| h[fi] <=> s[fi]}
            else
            @result = @final.sort{|h,s| s[fi] <=> h[fi]}
            end
        else
            if dir == 'DESC'
            @final = @con.exec "SELECT * FROM Users ORDER BY #{fi} DESC"
            else
            @final = @con.exec "SELECT * FROM Users ORDER BY #{fi} ASC"
            end
    end
    if @result.nil?
        @result = @final
    end
    self
    end

    def load
        begin

            @con = PG.connect :dbname => 'userdb', :user => 'nike47', 
                :password => 'password'
        
                @con.exec "DROP TABLE IF EXISTS Users"
                @con.exec "CREATE TABLE Users(Id INTEGER, 
                    First_Name VARCHAR(20), Second_Name VARCHAR(20),Email VARCHAR(50))"
                @con.exec "COPY Users FROM '/home/nike47/Desktop/Ruby_exercise/user_manager/assets/users.csv' WITH (FORMAT csv);"
                @test = @con.exec "SELECT * FROM Users"
        rescue PG::Error => e
        
            puts e.message 
            
     
            
        end     
        @max_length = (CSV.open(@path).readlines.size)
    end
    
end