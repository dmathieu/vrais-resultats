module Election
  def all_elections
    @items.select { |i| i.key?(:resultats) }
  end

  def sort_candidats(candidats)
    candidats.sort_by { |c| 1 - c[:voix] }
  end

  def real_result(resultat, candidat)
    ((candidat[:voix].to_f / resultat[:inscrits].to_f) * 100.0).floor(2)
  end

  def official_result(resultat, candidat)
    ((candidat[:voix].to_f / resultat[:exprimes].to_f) * 100.0).floor(2)
  end

  def all_data(resultat)
    candidats = resultat[:candidats].dup

    candidats << {
      nom: "Abstentions",
      liste: "",
      voix: resultat[:abstentions]
    }
    candidats << {
      nom: "Blancs + Nuls",
      liste: "",
      voix: resultat.fetch(:blancs, 0) + resultat.fetch(:nuls, 0)
    }

    candidats
  end
end

include Election
