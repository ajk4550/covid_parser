require 'test_helper'

class CasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @case = cases(:one)
  end

  test "should get index" do
    get cases_url
    assert_response :success
  end

  test "should get new" do
    get new_case_url
    assert_response :success
  end

  test "should create case" do
    assert_difference('Case.count') do
      post cases_url, params: { case: { active_cases: @case.active_cases, active_hospitalizations: @case.active_hospitalizations, date: @case.date, discharged_today: @case.discharged_today, negative_results: @case.negative_results, non-resident_deaths: @case.non-resident_deaths, pending_results: @case.pending_results, positive_cases: @case.positive_cases, recovered: @case.recovered, resident_deaths: @case.resident_deaths, total_tests: @case.total_tests } }
    end

    assert_redirected_to case_url(Case.last)
  end

  test "should show case" do
    get case_url(@case)
    assert_response :success
  end

  test "should get edit" do
    get edit_case_url(@case)
    assert_response :success
  end

  test "should update case" do
    patch case_url(@case), params: { case: { active_cases: @case.active_cases, active_hospitalizations: @case.active_hospitalizations, date: @case.date, discharged_today: @case.discharged_today, negative_results: @case.negative_results, non-resident_deaths: @case.non-resident_deaths, pending_results: @case.pending_results, positive_cases: @case.positive_cases, recovered: @case.recovered, resident_deaths: @case.resident_deaths, total_tests: @case.total_tests } }
    assert_redirected_to case_url(@case)
  end

  test "should destroy case" do
    assert_difference('Case.count', -1) do
      delete case_url(@case)
    end

    assert_redirected_to cases_url
  end
end
