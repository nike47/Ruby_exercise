require 'csv'
require 'pg'

class UserManager

    def self.load(path)
        user = UserManager.new(path)
        return user
    end


    def initialize(path)
        @path = path
        @offset = 0
        loaddata

    end

    def show
        
        
        @result.each do |x|
            a = Hash[x]
            puts x
        end
        self
    end

    def write
        a = CSV.open("assets/out.csv","w")
       
        column_names = ['id','first_name','second_name','email']
   
        s=CSV.generate do |csv|
            csv << column_names
            
            
            @result.each do |x|
               
                b = Hash[x]
                
                csv << b.values
              end
          end
          File.write('assets/out.csv', s)
    
           self
    end


    def offset(off)
        @offset = off
        if @result.nil?
            @final = @con.exec " SELECT * FROM Users ORDER BY id OFFSET #{@offset} ROWS"
            @result = @final
        else
            @result = @result.to_a
            @result = @result[@offset,@max_length]
        end
        self
    end

    def limit(lim)
        @max_length = @offset + lim
        if @result.nil?
            @final = @con.exec " SELECT * FROM Users ORDER BY id OFFSET #{@offset} ROWS FETCH NEXT #{@max_length} ROWS ONLY"
            @result = @final
        else
            @result = @result.to_a
            @result = @result[@offset,@max_length]
            
        end
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
            
            @final = @con.exec "SELECT * FROM Users WHERE id = '#{n}' OR first_name = '#{n}' OR second_name = '#{n}' OR email = '#{n}'"
            
        end

        if !@result.nil?
           
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
    if !@result.nil?
        @result = @final
    end
    self
    end

    def loaddata
        begin

            @con = PG.connect :dbname => 'userdb', :user => 'nike47', 
                :password => 'password'
        
                @con.exec "DROP TABLE IF EXISTS Users"
                @con.exec "CREATE TABLE Users(Id VARCHAR(20), 
                    First_Name VARCHAR(20), Second_Name VARCHAR(20),Email VARCHAR(50))"
                @con.exec "COPY Users FROM '/home/nike47/Desktop/Ruby_exercise/user_manager/assets/users.csv' WITH (FORMAT csv);"
                @test = @con.exec "SELECT * FROM Users"
        rescue PG::Error => e
        
            puts e.message 
            
     
            
        end     
        @max_length = (CSV.open(@path).readlines.size)
    end
    
end