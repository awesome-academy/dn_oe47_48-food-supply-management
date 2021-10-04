require "rails_helper"
require_relative "./../../support/devise"
RSpec.describe Admin::OrdersController, type: :controller do
  let(:admin){FactoryBot.create :user, role: :admin}
  let(:buyer){FactoryBot.create :user, role: :buyer}

  describe "GET #index" do
    let!(:order){FactoryBot.create :order, user: buyer}
    context "when user is admin" do
      login_admin
      it "assign @orders matched" do
        get :index
        expect(assigns(:orders)).to eq([order])
      end
      it "render the index template" do
        get :index, xhr: true
        expect(response).to render_template(:index)
      end
    end
  end

  describe "PUT #update" do
    let!(:order){FactoryBot.create :order, id: 1, user: buyer, status: :processing}
    let!(:product){FactoryBot.create :product, quantity: 30}
    let!(:order_product){
      FactoryBot.create :order_product,
        product_id: product.id,
        order_id: order.id,
        quantity: 4
    }

    context "when user is admin" do
      login_admin
      context "success when valid attributes" do
        before do
          @controller = Admin::OrdersController.new
          @controller.params = ActionController::Parameters.new(id: 1)
        end
        it "assign @order exists" do
          @controller.send(:load_order)
          expect(assigns(:order)).to eq order
        end
        context "when update success" do
          before do
            put :update, xhr: true, params:{id: order.id, status: "canceled"}
          end
          context "update db success" do
            it "with order status" do
              order.reload
              expect(order.status).to eq "canceled"
            end
            it "with product's quantity" do
              order_product.reload
              expect(order_product.product_quantity).to eq 34
            end
          end
          it "display flash success message" do
            expect(flash.now[:notice]).to eq I18n.t("admin.order.update_sc")
          end
          it "render upadte template" do
            expect(response).to render_template(:update)
          end
        end

        context "when update fail" do
          before do
            @controller.params = {id: 1, status: "completed"}
            @controller.send(:load_order)
            @controller.send(:update_with_message)
            put :update, xhr: true, params:{id: 1, status: "completed"}
          end
        end

        context "fail when order not found" do
          before do
            put :update, xhr: true,
              params: {id: -1}
          end

          it "display flash message" do
            expect(flash[:danger]).to eq I18n.t("admin.order.nil")
          end
          it "redirect to admin root path" do
            expect(response).to redirect_to admin_root_path
          end
        end
      end
    end 
  end
end
