module ApplicationHelper
  def bootstrap_class_for(flash_type)
    bootstrap_alert_class = {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      warning: 'alert-warning',
      notice: 'alert-success'
    }
    bootstrap_alert_class[flash_type.to_sym]
  end

  def render_status_badge_payment_status(object)
    output = ''
    if object.Unpaid?
      output += "<span class='badge bg-danger'>UNPAID</span>"
    elsif object.Paid?
      output += "<span class='badge bg-success'>PAID</span>"
    elsif object.Withdraw?
      output += "<span class='badge bg-info'>WITHDRAW</span>"
    end

    output.html_safe
  end

  def render_status_badge_payment_type(object)
    output = ''
    if object.Pay_now?
      output += "<span class='badge bg-info'>NOW</span>"
    elsif object.Pay_later?
      output += "<span class='badge bg-info'>LATER</span>"
    end

    output.html_safe
  end
end
