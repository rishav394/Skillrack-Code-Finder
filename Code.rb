require 'rubygems'
require 'nokogiri'
require 'restclient'
require "fileutils"
require 'clipboard'

def get_code()
	xfile2=File.open("code.txt", "r")
	xfileg=File.open("Solution.txt","w")
	flag=0
	start=0
	while !xfile2.eof?
		ch=xfile2.readline
		if ch=~ /Example: <pre> Your Code <\/pre>/
			flag = 1
			start = 1
			ch=xfile2.readline
		end
		if ch=~ /12345678910/
			if start==1
				break
			end
		end
		if flag == 1
			puts ch
			xfileg.write(ch)
		end
	end
	puts "}"
	xfileg.write("\n}")
	xfileg.close
	xfileg=File.open("Solution.txt","r")
	temp=xfileg.read
	Clipboard.copy(temp)
	xfileg.close
end





def get_to_text(real_url)
	page = Nokogiri::HTML(RestClient.get("#{real_url}"))   
	xfile=File.open("code.txt","w")
	xfile.write(page.text)
	xfile.close
	get_code()
end

puts "For Updates go to \nhttps://github.com/rishav394/Skillrack-Code-Finder/releases"

puts "\nEnter code no\n"
num = gets
puts "\n"
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
puts "\n\nCode copied to clipboard and Pasted in \"Solution.txt\" in the very folder. "
puts "Press Ctrl+V to paste."
puts "Press Enter to continue. Also a \"}\" may be extra. Please check."
gets
xfile=File.open("code.txt","w")
xfile.write("Thanks for using this software. You may delete this file. Feedbacks and complains MOST welcome. Contact: rishav394@gmail.com")
xfile.close
FileUtils.rm_f 'code.txt'
