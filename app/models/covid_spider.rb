class CovidSpider < Kimurai::Base
  @name = 'covid_spider'
  @engine = :mechanize

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    result = {}
    covid_div = response.xpath("//a[@id='table']").first.parent.parent.parent
    cases_table = covid_div.xpath("./div/table").first
    date_parent = cases_table.children[0] # date
    tbody = cases_table.children[2] # tbody
    
    # Parsing and Saving the date of the dataset
    date_md = date_parent.children[3].text.squish
    date_yt = date_parent.children[5].text.squish
    date = date_md.split(" ")[2] + "/" + date_yt.split(" ")[0]
    time = date_yt.split(" ")[2][0...-1]
    result[:date] = date
    result[:time] = time
    
    # Parsing and saving the case information
    cases_row = tbody.xpath("./tr")[1]
    result[:total_tests] = cases_row.children[0].text.squish.gsub(/[\s,]/, "")
    result[:pending_results] = cases_row.children[2].text.squish.gsub(/[\s,]/, "")
    result[:positive_cases] = cases_row.children[4].text.squish.gsub(/[\s,]/, "")
    result[:negative_results] = cases_row.children[6].text.squish.gsub(/[\s,]/, "")
    result[:recovered] = cases_row.children[8].text.squish.gsub(/[\s,]/, "")
    result[:active_cases] = cases_row.children[10].text.squish.gsub(/[\s,]/, "")
    
    # Parsing and saving the hospitalization information
    hospital_table = covid_div.xpath("./div/table")[1]
    tbody = hospital_table.children[2]
    hospital_row = tbody.xpath("./tr")[1]
    result[:active_hospitalizations] = hospital_row.children[0].text.squish.gsub(/[\s,]/, "")
    result[:discharged_today] = hospital_row.children[2].text.squish.gsub(/[\s,]/, "")
    result[:resident_deaths] = hospital_row.children[4].text.squish.gsub(/[\s,]/, "")
    result[:nonresident_deaths] = hospital_row.children[6].text.squish.gsub(/[\s,]/, "")

    Case.create_from_hash(result)
  end
end
