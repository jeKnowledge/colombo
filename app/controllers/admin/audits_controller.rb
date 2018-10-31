class Admin::AuditsController < ApplicationController

  def audits
    @repors = Report.all
    @plans = Report.all
  end
end
