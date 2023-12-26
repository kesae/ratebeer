module ApplicationHelper
  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary")
    if current_user.admin
      del = link_to('Destroy', item, {
                      data: { turbo_method: :delete, turbo_confirm: "Are you sure?" },
                      class: "btn btn-danger"
                    })

      return raw("#{edit} #{del}")
    end
    raw(edit.to_s)
  end

  def round(number)
    number_with_precision(number, precision: 1)
  end
end
