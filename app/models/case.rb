class Case < ApplicationRecord
  validates :date, presence: true, uniqueness: true

  after_save :send_alert

  def self.create_from_hash(hash)
    # Check to see if we've already recorded the data from this date set
    set_date = hash[:date]
    if Case.where(date: set_date).empty?
      # No data yet for this date, save the data
      Case.create({
        date: hash[:date],
        total_tests: hash[:total_tests].to_i,
        pending_results: hash[:pending_results].to_i,
        positive_cases: hash[:positive_cases].to_i,
        negative_results: hash[:negative_results].to_i,
        recovered: hash[:recovered].to_i,
        active_cases: hash[:active_cases].to_i,
        active_hospitalizations: hash[:active_hospitalizations].to_i,
        discharged_today: hash[:discharged_today].to_i,
        resident_deaths: hash[:resident_deaths].to_i,
        nonresident_deaths: hash[:nonresident_deaths].to_i
      })
    end
  end

  def self.to_sms(record)
    # The previous record is used to calculate deltas
    previous = Case.where(id: record.id - 1)
    sms = if previous.empty?
      "Active Cases: #{record.active_cases} - Hospitalized: #{record.active_hospitalizations} - Discharged: #{record.discharged_today} - TC Deaths: #{record.resident_deaths} - NonTC Deaths: #{record.nonresident_deaths}"
    else
      previous = previous.first
      # Calculate the amount of new cases - Note, this should only increase.
      previous_pos = previous.positive_cases
      new_cases = record.positive_cases - previous_pos
      # Calculate the number of recoveries - Note, this should only increase.
      previous_recovery = previous.recovered
      new_recoveries = record.recovered - previous_recovery
      "Active Cases: #{record.active_cases} - New Cases: #{new_cases} - Recovered: #{new_recoveries} - Hospitialized: #{record.active_hospitalizations} - Discharged: #{record.discharged_today} - TC Deaths: #{record.resident_deaths} - NonTC Deaths: #{record.nonresident_deaths}"
    end
    sms
  end

  private

  def send_alert
    last_case = Case.last
    message = Case.to_sms(last_case)
    Alert.send(message)
  end
end
