require "rails_helper"
	
RSpec.describe ProductsController, type: :controller	do
  let!(:category){FactoryBot.create :category}
  let!(:product){FactoryBot.create :product, category_id: category.id}
  describe "#show" do
    context "when product exists" do
      it "assign product is match with product" do
        get :show, params: {id: product.id, category_id: category.id}
        expect(assigns(:product)).to	eq product
      end
    end
    context "when product doesn't exist" do
      before{get :show, params: {id: -1, category_id: category.id}}
      it "display flash message" do
        expect(flash[:danger]).to eq I18n.t("product.not_found")
      end
      it "redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
