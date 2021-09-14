class Admin::OrdersController < Admin::AdminsController
  def index
    update_status
    @orders = Order.includes(order_products: :product)
                   .order_by_status.page(params[:page])
                   .per(Settings.per_page.per_5)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def update_status
    return if params[:order_id].blank?

    order = Order.find_by id: params[:order_id]
    respond_to do |format|
      format.js{flash.now[:notice] = set_message_content order, params[:status]}
    end
  end

  def set_message_content order, param
    status = order.status
    return t("admin.order.update_cant_change") if cant_change? status

    return t("admin.order.update_pre") if cant_update_previous? status, param

    return t("admin.order.update_not_ship") if order_hasnt_ship? status, param

    return t("admin.order.update_sc") if order.update!(status: param)

    t("admin.order.update_failed")
  end

  def cant_change? status
    Order.statuses[status] == 1 || Order.statuses[status] == 3 ? true : false
  end

  def cant_update_previous? status, param
    Order.statuses[param] < Order.statuses[status]
  end

  def order_hasnt_ship? status, param
    Order.statuses[param] == 3 && Order.statuses[status].zero? ? true : false
  end
end
