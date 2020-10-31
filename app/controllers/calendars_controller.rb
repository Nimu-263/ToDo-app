class CalendarsController < ApplicationController
  def index
    get_month
    get_week
    @plan = Plan.new
  end

  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_month
    todays_year = Date.today.year
    todays_month = Date.today.month
    
    @first_day = Date.new(todays_year , todays_month , 1)
    @last_day = Date.new(todays_year , todays_month , -1)

    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    @month_days = []

    plans = Plan.where(date: @first_day..@last_day)

    # 下記 "last_month" をlmと表記する
    first_day_wday = @first_day.wday 
    if first_day_wday != 0
      first_day_wday.times do |x|
        lm_plans = []
        lm_wday_num = (@first_day - (first_day_wday - x)).wday
        lm_days = { date: (@first_day - (first_day_wday - x)).day, plans: lm_plans, wday: wdays[lm_wday_num] }
        @month_days.push(lm_days) 
      end
    end

    month_days = @last_day.day
    month_days.times do |x|
      today_plans = []
      plan = plans.map do |plan|
        today_plans.push(plan.plan) if plan.date == @first_day + x
      end
      wday_num = (@first_day+x).wday
      days = { date: (@first_day+x).day, plans: today_plans, wday: wdays[wday_num] }
      @month_days.push(days)
    end

  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    @todays_date = Date.today

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plan = plans.map do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      wday_num = (@todays_date+x).wday
      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: today_plans, wday: wdays[wday_num] }
      @week_days.push(days)
    end

  end
end
