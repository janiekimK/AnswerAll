class ActivitiesController < ApplicationController
  before_action :require_login

  def index
    @audits = Audited::Audit.where(auditable_type: ["Question", "Answer", "Vote"]).order(created_at: :desc).limit(100).includes(:user)
  end
end
