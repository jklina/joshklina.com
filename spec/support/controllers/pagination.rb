module Controllers
  module Pagination
    def paginates(model:, increment:)
      model_symbol = model.name.underscore.to_sym
      model_symbol_plural = model.name.pluralize.underscore.to_sym
      number_of_results_for_two_pages = increment + 1
      results = 
        FactoryGirl.create_list(model_symbol, number_of_results_for_two_pages)

      yield

      expect(assigns(model_symbol_plural).count).to eq(increment)
    end
  end
end

