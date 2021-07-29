module VR
  class Indexer
    def initialize(content)
      @content = content
    end

    def run
      ActiveRecord::Base.transaction do
        return if event.populated?

        VR.tracer.in_span("index.run") do |span|
          event.areas.delete_all
          event.rounds.delete_all

          @content[:data].each do |data|
            run_data(data)
          end
        end

        event.update!(populated: true)
      end
    end

    private

    def run_data(data)
      VR.tracer.in_span("indexer.run_data") do |span|
        area = event.areas.create!(name: data[:name], path: data[:path])

        data[:resultats].each do |resultat|
          round = event.rounds.find_or_create_by!(name: resultat[:name])
          round.results.create!(
            area_id: area.id,
            inscrits: resultat[:inscrits],
            abstentions: resultat[:abstentions],
            votants: resultat[:votants],
            blancs: resultat[:blancs],
            nuls: resultat[:nuls],
            exprimes: resultat[:exprimes]
          )
        end
      end
    end

    def event
      @event ||= Event.find_or_create_by!(name: @content[:name], annee: @content[:annee])
    end
  end
end
