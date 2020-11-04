require "application_system_test_case"

class CasesTest < ApplicationSystemTestCase
  setup do
    @case = cases(:one)
  end

  test "visiting the index" do
    visit cases_url
    assert_selector "h1", text: "Cases"
  end

  test "creating a Case" do
    visit cases_url
    click_on "New Case"

    fill_in "Active cases", with: @case.active_cases
    fill_in "Active hospitalizations", with: @case.active_hospitalizations
    fill_in "Date", with: @case.date
    fill_in "Discharged today", with: @case.discharged_today
    fill_in "Negative results", with: @case.negative_results
    fill_in "Non-resident deaths", with: @case.non-resident_deaths
    fill_in "Pending results", with: @case.pending_results
    fill_in "Positive cases", with: @case.positive_cases
    fill_in "Recovered", with: @case.recovered
    fill_in "Resident deaths", with: @case.resident_deaths
    fill_in "Total tests", with: @case.total_tests
    click_on "Create Case"

    assert_text "Case was successfully created"
    click_on "Back"
  end

  test "updating a Case" do
    visit cases_url
    click_on "Edit", match: :first

    fill_in "Active cases", with: @case.active_cases
    fill_in "Active hospitalizations", with: @case.active_hospitalizations
    fill_in "Date", with: @case.date
    fill_in "Discharged today", with: @case.discharged_today
    fill_in "Negative results", with: @case.negative_results
    fill_in "Non-resident deaths", with: @case.non-resident_deaths
    fill_in "Pending results", with: @case.pending_results
    fill_in "Positive cases", with: @case.positive_cases
    fill_in "Recovered", with: @case.recovered
    fill_in "Resident deaths", with: @case.resident_deaths
    fill_in "Total tests", with: @case.total_tests
    click_on "Update Case"

    assert_text "Case was successfully updated"
    click_on "Back"
  end

  test "destroying a Case" do
    visit cases_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Case was successfully destroyed"
  end
end
