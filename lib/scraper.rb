require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    document = Nokogiri::HTML(open(index_url))
    document.css(".student-card").each do |element|
      student_hash = { name: element.css(".student-name").text,
        location: element.css(".student-location").text,
        profile_url: element.css('@href').text
        }
        student_array << student_hash
    end
    return student_array
  end

  def self.scrape_profile_page(profile_url)
    profHash = {}
    document = Nokogiri::HTML(open(profile_url))
    document.css('@href').each do |element|
      puts element
      case element
      when element.include?("twitter")
        profHash[:twitter] = element
      when element.include?("linkedin")
        profHash[:linkedin] = element
      when element.include?("github")
        profHash[:github] = element
      end
    end
  end
end
