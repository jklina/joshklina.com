module Features
  module Pagination
    def paginates(model:, increment:, selector:, model_attributes:{})
      model_symbol = model.name.underscore.to_sym
      model_string = model.name.underscore
      number_of_results_for_two_pages = increment + 1
      results = 
        FactoryGirl.
        create_list(model_symbol,
                    number_of_results_for_two_pages,
                    model_attributes)

      yield
      expect(page).to have_selector(selector, count: increment)
      click_on('Next')

      expect(page).to have_selector(selector, count: 1)
    end
  end
end

