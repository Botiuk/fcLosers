# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article do
  it 'is valid with valid attributes' do
    article = build(:article)
    expect(article).to be_valid
  end

  it 'is not valid without a title' do
    article = build(:article, title: nil)
    expect(article).not_to be_valid
  end

  it 'is not valid without a article_type' do
    article = build(:article, article_type: nil)
    expect(article).not_to be_valid
  end

  it 'is valid without a published_at' do
    article = build(:article, published_at: nil)
    expect(article).to be_valid
  end

  it 'is not valid with a small first letter in title' do
    article = build(:article, title: 'firs news')
    expect(article).not_to be_valid
  end
end
