class Admin::ConsentsController < ApplicationController
  before_action :admin_authenticated?

  layout 'admin'
end
