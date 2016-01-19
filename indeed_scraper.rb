require 'rubygems'
require 'bundler/setup'
require 'mechanize'
require 'csv'

class IndeedScraper

  def initialize
    @mech = Mechanize.new
    @mech.user_agent_alias = 'Mac Safari'
    @mech.history_added = Proc.new { sleep 0.5 }
    @page = nil
    @jobs = []
  end

  def scrape_jobs(date)
    @page = @mech.get("http://www.indeed.com/jobs?q=Ruby+on+Rails&l=New+York%2C+NY")
    results = @page.search('.result')
    scrape_page(results,date)
  end

  def scrape_page(nokogiri_result, date)
    nokogiri_result.each do |job|

    end
    puts
  end

  def get_job(job)
    job.css('.jobtitle').text.strip
  end

  def get_descript(job)
    job.css('.summary').text.strip
  end

  def get_employer(job)
    job.css('.company').text.strip
  end

  def get_link(job)
    job.at('.jobtitle').attributes["href"].value
  end

  def get_location(job)
    
  end

  def get_date(job)
    time_hash = { year: 365*24*60*60, years: 365*24*60*60,
                  week: 7*24*60*60, weeks: 7*24*60*60,
                  month: 30*24*60*60, months: 30*24*60*60,
                  day: 24*60*60, days: 24*60*60,
                  hour: 60*60, hours: 60*60,
                  minute: 60, minutes: 60,
                  second: 1, seconds: 1 }

    # rel_time_arr = job.css('li.posted').text.split(" ")
    now = Time.now
    time_num = rel_time_arr[0].to_i
    time_string = rel_time_arr[1]

    return now - time_num*time_hash[time_string.downcase.to_sym]
  end
end

scraper = IndeedScraper.new
scraper.scrape_jobs(Time.new(2016, 1, 18))
#scraper.create_csv
