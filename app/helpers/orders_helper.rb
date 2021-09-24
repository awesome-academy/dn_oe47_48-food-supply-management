module OrdersHelper
  def selects_order_status order
    statuses_ar = Order.statuses.keys
    statuses_ar.delete_at(0) if order.shipped?
    statuses_ar.each do |status|
      next if status == order.status

      yield content_tag(
        :li,
        link_to(admin_order_path(id: order.id, status: status),
                method: "put", remote: true) do
                  content_tag(:span, t("orders.status.#{status}"))
                end
      )
    end
  end
end
