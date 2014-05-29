ActiveAdmin.register Group do
  filter :name
  filter :side, as: :select

  index do
    column :id
    column :name
    column :rsvp_code
    column :side
    column :responded? do |group|
      (group.responses.count > 0 ||
       group.invites.any? { |invite| invite.none_attending? }) ? "Yes" : "No"
    end
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :rsvp_code
      row :side
      row :responded? do |group|
        group.responded? ? "Yes" : "No"
      end
    end

    panel "Invites" do
      table_for group.invites do
        column :event_name do |invite|
          invite.event.title
        end
        column :num_invited
        column :none_attending
        column :members do |invite|
          invite.responses.map do |response|
            text_node(("<p>#{response.member.first_name} #{response.member.last_name}</p>").html_safe)
          end.join
        end
      end
    end

    active_admin_comments
  end

end
