ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Event Totals" do
          table_for Event.all do
            column "Event", :title
            column "Adults", :total_num_adults
            column "Children Under 12", :total_num_children_under_12
            column "Children Under 5", :total_num_children_under_5
          end
        end
        panel "Groom Side Event Totals" do
          table_for Event.all do
            column "Event", :title
            column "Adults", :num_adults_groom_side
            column "Children Under 12", :num_children_under_12_groom_side
            column "Children Under 5", :num_children_under_5_groom_side
          end
        end
        panel "Bride Side Event Totals" do
          table_for Event.all do
            column "Event", :title
            column "Adults", :num_adults_bride_side
            column "Children Under 12", :num_children_under_12_bride_side
            column "Children Under 5", :num_children_under_5_bride_side
          end
        end
      end
      
      column do
        panel "Total RSVP Progress" do
          table_for Group do
            column "Num Responded", :num_responded_in_total
            column "Out of Total", :total_both_sides
          end
        end
        panel "Groom Side RSVP Progress" do
          table_for Group do
            column "Num Responded", :num_responded_groom_side
            column "Out Of Total", :total_groom_side
          end
        end
        panel "Bride Side RSVP Progress" do
          table_for Group do
            column "Num Responded", :num_responded_bride_side
            column "Out Of Total", :total_bride_side
          end
        end
      end
    end

  end
end
