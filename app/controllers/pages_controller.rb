class PagesController < ApplicationController
  include HighVoltage::StaticPage
  layout 'exposition/application'
end
