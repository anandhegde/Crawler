class PageController < ApplicationController
	def home
		@sitenames = ['http://www.yourstory.com','http://techsparks.yourstory.com/2014/']
		@c = Scrape.new
	end
end

class Scrape
	def crawl(sitename)
		mechanize = Mechanize.new
		@page =  mechanize.get(sitename)
		if !@page.at('meta[name="description"]').blank?
			@name =  @page.at('meta[name="description"]')[:content]
		else
			@name = 'null'
		end

		if !@page.at('meta[name="keywords"]').blank?
			@keywords = @page.at('meta[name="keywords"]')[:content]
		else
			@keywords = 'null'
		end

		if !@page.title.blank?
			@title = @page.title
		else
			@title = 'null'
		end

		return {'title'=>@title,'name'=>@name,'keyword'=>@keywords}
	end
end