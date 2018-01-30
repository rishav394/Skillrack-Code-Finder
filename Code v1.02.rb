require 'rubygems'
require 'nokogiri'
require 'restclient'
require "fileutils"

def get_code()
	xfile2=File.open("code.txt", "r")
	flag=0
	start=0
	while !xfile2.eof?
		ch=xfile2.readline
		if ch=~ /#include/
			flag = 1
			start = 1
		end
		if ch=~ /12345678910/
			if start==1
				break
			end
		end
		if flag == 1
			puts ch
		end
	end
end





def get_to_text(real_url)
	page = Nokogiri::HTML(RestClient.get("#{real_url}"))   
	xfile=File.open("code.txt","w")
	xfile.write(page.text)
	xfile.close
	get_code()
end


puts "Enter code no\n"
num = gets

intel=RestClient.get("https://vitspot.com/?s=#{num}")
xfile=File.open("code.txt","w")
xfile.write(intel.body)
xfile.close

xfile2=File.open("code.txt", "r")
while !xfile2.eof?
	ch=xfile2.readline
	if ch=~ /Continue/
		dat=ch.split(/"/)
		break
	end
end
xfile2.close
get_to_text(dat[1])
xfile=File.open("code.txt","w")
xfile.write("Thanks for using this software. You may delete this file. Feedbacks and complains MOST welcome. Contact: rishav394@gmail.com")
xfile.close
FileUtils.rm_f 'code.txt'

gets