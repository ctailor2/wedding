ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Event Totals" do
          p "TODO: this section will show event total counts with age group breakdown"
        end
      end
      
      column do
        panel "Most Recent RSVPs" do
          p "TODO: this section will show the most recent responses with group, member, and event name"
        end
      end
    end

  end
end
