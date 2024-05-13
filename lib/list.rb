# frozen_string_literal: true

module List
  def aggregated_resultats(items, index)
    resultats = items.filter_map { |i| i[:resultats][index] }
    gagnants = resultats.map do |r|
      r[:candidats].max_by { |c| c[:voix] }
    end

    candidats = []
    candidats << {
      nom: 'Abstentions',
      liste: '',
      voix: resultats.inject(0) { |sum, hash| sum + hash[:abstentions] }
    }
    candidats << {
      nom: 'Blancs + Nuls',
      liste: '',
      voix: resultats.inject(0) { |sum, hash| sum + hash[:blancs] + hash[:nuls] }
    }
    candidats << {
      nom: 'Candidat ayant obtenu le score plus élevé',
      liste: '',
      voix: gagnants.inject(0) { |sum, hash| sum + hash[:voix] }
    }

    {
      resultat: {
        inscrits: resultats.inject(0) { |sum, hash| sum + hash[:inscrits] },
        exprimes: resultats.inject(0) { |sum, hash| sum + hash[:exprimes] }
      },
      candidats:
    }
  end
end

include List
