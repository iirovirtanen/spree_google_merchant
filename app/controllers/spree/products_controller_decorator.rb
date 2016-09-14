module Spree
  ProductsController.class_eval do
    def google_merchant
      I18n.locale = params[:locale]
      @products = Product.active
    end
  end
end
