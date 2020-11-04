json.extract! case, :id, :date, :total_tests, :pending_results, :positive_cases, :negative_results, :recovered, :active_cases, :active_hospitalizations, :discharged_today, :resident_deaths, :non-resident_deaths, :created_at, :updated_at
json.url case_url(case, format: :json)
