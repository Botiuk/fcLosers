# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coach do
  it 'is valid with valid attributes' do
    coach = build(:coach)
    expect(coach).to be_valid
  end

  it 'is not valid without a surname' do
    coach = build(:coach, surname: nil)
    expect(coach).not_to be_valid
  end

  it 'is not valid without a middle_name' do
    coach = build(:coach, middle_name: nil)
    expect(coach).not_to be_valid
  end

  it 'is not valid without a name' do
    coach = build(:coach, name: nil)
    expect(coach).not_to be_valid
  end

  it 'is not valid without a which_team' do
    coach = build(:coach, which_team: nil)
    expect(coach).not_to be_valid
  end

  it 'is not valid without a position' do
    coach = build(:coach, position: nil)
    expect(coach).not_to be_valid
  end

  it 'is not valid without a date_of_birth' do
    coach = build(:coach, date_of_birth: nil)
    expect(coach).not_to be_valid
  end

  it 'is not valid if a date_of_birth grater than' do
    coach = build(:coach, date_of_birth: (Time.zone.today - 12.years + 1.day))
    expect(coach).not_to be_valid
  end

  it 'is valid if a date_of_birth equal' do
    coach = build(:coach, date_of_birth: (Time.zone.today - 12.years))
    expect(coach).to be_valid
  end

  it 'is not create if a main_coach present' do
    coach_one = build(:coach, position: 'main_coach')
    coach_two = create(:coach, which_team: coach_one.which_team, position: 'main_coach')
    expect(coach_two).not_to be_valid(:create)
    expect(coach_two.errors.messages).to eq({ base: [I18n.t('errors.coach_validations.main')] })
  end

  it 'is not create if a temporary_main_coach present' do
    coach_one = build(:coach, position: 'temporary_main_coach')
    coach_two = create(:coach, which_team: coach_one.which_team, position: 'temporary_main_coach')
    expect(coach_two).not_to be_valid(:create)
    expect(coach_two.errors.messages).to eq({ base: [I18n.t('errors.coach_validations.temporary')] })
  end

  it 'is not update if a main_coach present' do
    coach_one = create(:coach, position: 'main_coach')
    coach_two = create(:coach, which_team: coach_one.which_team, position: 'coach')
    coach_two.update(position: 'main_coach')
    expect(coach_two).not_to be_valid(:update)
    expect(coach_two.errors.messages).to eq({ base: [I18n.t('errors.coach_validations.main')] })
    expect(coach_two.reload.position).to eq('coach')
  end

  it 'is not update if a temporary_main_coach present' do
    coach_one = create(:coach, position: 'temporary_main_coach')
    coach_two = create(:coach, which_team: coach_one.which_team, position: 'coach')
    coach_two.update(position: 'temporary_main_coach')
    expect(coach_two).not_to be_valid(:update)
    expect(coach_two.errors.messages).to eq({ base: [I18n.t('errors.coach_validations.temporary')] })
    expect(coach_two.reload.position).to eq('coach')
  end
end
