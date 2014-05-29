class Event < ActiveRecord::Base
	has_many :invites
	has_many :responses, through: :invites
	has_many :members, through: :responses

  def response_counts_by_age_group_and_side(age_group, side)
    responses.joins(member: [:age_group, :group]).where('age_groups.id' => age_group.id, 'groups.side' => side).count
  end

  def num_adults_bride_side
    age_group = AgeGroup.find_by_description('Adult (12+)')
    response_counts_by_age_group_and_side(age_group, 'Bride')
  end

  def num_adults_groom_side
    age_group = AgeGroup.find_by_description('Adult (12+)')
    response_counts_by_age_group_and_side(age_group, 'Groom')
  end

  def num_children_under_12_bride_side
    age_group = AgeGroup.find_by_description('Child Under 12')
    response_counts_by_age_group_and_side(age_group, 'Bride')
  end

  def num_children_under_12_groom_side
    age_group = AgeGroup.find_by_description('Child Under 12')
    response_counts_by_age_group_and_side(age_group, 'Groom')
  end

  def num_children_under_5_bride_side
    age_group = AgeGroup.find_by_description('Child Under 5')
    response_counts_by_age_group_and_side(age_group, 'Bride')
  end

  def num_children_under_5_groom_side
    age_group = AgeGroup.find_by_description('Child Under 5')
    response_counts_by_age_group_and_side(age_group, 'Groom')
  end

  def total_num_adults
    num_adults_bride_side + num_adults_groom_side
  end

  def total_num_children_under_12
    num_children_under_12_bride_side + num_children_under_12_groom_side
  end

  def total_num_children_under_5
    num_children_under_5_bride_side + num_children_under_5_groom_side
  end
end
