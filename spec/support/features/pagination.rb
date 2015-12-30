module Features
  module Pagination
    def paginates(factory:, increment:, selector:, attributes:{})
      factory_string = factory.to_s
      factory = factory_string.underscore.to_sym
      factory_plural = factory_string.pluralize.underscore.to_sym
      number_of_results_for_two_pages = increment + 1
      results = 
        FactoryGirl.
        create_list(factory,
                    number_of_results_for_two_pages,
                    attributes)

      yield
      expect(page).to have_selector(selector, count: increment)
      click_on('Next')

      expect(page).to have_selector(selector, count: 1)
    end
  end
end

