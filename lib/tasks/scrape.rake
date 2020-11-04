namespace :scraper do
  desc "Scrape the website."
  task :run => :environment do
    last_run = Date.strptime(Case.last.date, "%m/%d/%Y") unless Case.last.nil?
    if last_run.nil? || last_run != Date.today
      url = 'https://tompkinscountyny.gov/health'
      response = CovidSpider.process(url)
    end
  end
end
