class PageController < ApplicationController
	def home
		@c = Scrape.new
		@name = @c.crawl
	end
end

class Scrape
	def crawl
		mechanize = Mechanize.new
		@page =  mechanize.get('http://www.yourstory.com')
		if !@page.at('meta[name="description"]').blank?
			@name =  @page.at('meta[name="description"]')[:content]
		else
			@name = 'nodescription'
		end

		if !@page.at('meta[name="keywords"]').blank?
			@keywords = @page.at('meta[name="keywords"]')[:content]
		else
			@keywords = 'nokeywords'
		end

		if !@page.title.blank?
			@title = @page.title
		else
			@title = 'notitle'
		end

		return {'title'=>@title,'name'=>@name,'keywords'=>@keywords}
	end
end