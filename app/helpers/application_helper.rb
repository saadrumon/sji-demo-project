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

  def render_status_badge_purchase_status(object)
    output = ''
    if object.Unpaid?
      output += "<span class='badge bg-danger'>UNPAID</span>"
    elsif object.Paid?
      output += "<span class='badge bg-success'>PAID</span>"
    elsif object.In_review?
      output += "<span class='badge bg-info'>IN REVIEW</span>"
    end

    output.html_safe
  end

  def render_status_badge_purchase_type(object)
    output = ''
    if object.Pay_now?
      output += "<span class='badge bg-info'>NOW</span>"
    elsif object.Pay_later?
      output += "<span class='badge bg-warning'>LATER</span>"
    end

    output.html_safe
  end

  def render_status_badge_payment_status(object)
    output = ''
    if object.Incomplete?
      output += "<span class='badge bg-danger'>INCOMPLETE</span>"
    elsif object.Pending?
      output += "<span class='badge bg-warning'>PENDING</span>"
    elsif object.Completed?
      output += "<span class='badge bg-success'>COMPLETED</span>"
    end

    output.html_safe
  end

  def render_status_badge_payment_method(object)
    output = ''
    if object.Default?
      output += "<span class='badge bg-success'>DEFAULT</span>"
    elsif object.Bank_account?
      output += "<span class='badge bg-info'>BANK ACCOUNT</span>"
    elsif object.Card?
      output += "<span class='badge bg-warning'>CARD</span>"
    end

    output.html_safe
  end
end
