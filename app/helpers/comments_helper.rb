module CommentsHelper

	class Comment < OpenStruct
		def []=(name, value)
			if [:date, :content, :author, :avatar, :children, :id].include? name.to_sym
				super(name, value)
			end
		end
	end


	def parse_comments(unparsed)
		json_data = JSON.parse(unparsed)
		begin
			comments = JSON.parse(json_data["comments"].to_json, object_class: Comment)
		rescue NameError => e 
		end
		nested_comments = comments.flat_map{|c| c.children}
		until nested_comments.count <= 0
			comments.concat nested_comments
			nested_comments = nested_comments.flat_map{|c| c.children}
		end
		comments
	end
	
	def get_comments_id(url)
		mech = Mechanize.new { |agent|
		  agent.user_agent_alias = 'Mac Safari'
		}
		page = mech.get(url)
		page.search("a.comments-anchor").xpath("@href").first.value.scan(/\/(\d+)\/(#cComments)?/i).last.first
	end

	def get_unparsed_comments(id)
		url = URI("https://comments.ilfattoquotidiano.it/?p="+ id.to_i.to_s)

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true


		request = Net::HTTP::Get.new(url)
		request["cache-control"] = 'no-cache'


		http.request(request).read_body
	end

end
