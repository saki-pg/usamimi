# frozen_string_literal: true

json.array! @reactions, partial: 'reactions/reaction', as: :reaction
