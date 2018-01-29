#encoding: utf-8
require_relative "sorpresa"
require_relative "tipo_sorpresa"
module ModeloQytetet
  class PruebaQytetet
    def initialize
      @@mazo = Array.new
    end 
    
    def inicializar_sorpresas
      @@mazo<< Sorpresa.new("Un fan anónimo ha pagado tu fianza. Sales de la cárcel", 0, TipoSorpresa::SALIRCARCEL)
      @@mazo<< Sorpresa.new("Te hemos pillado con chanclas y calcetines, lo sentimos, ¡debes ir a la carcel!", 9, TipoSorpresa::IRACASILLA)
      @@mazo<< Sorpresa.new("¡Felicidades! hoy es el día de tu no cumpleaños, recibes un regalo de todos", 200, TipoSorpresa::PORJUGADOR)
      @@mazo<< Sorpresa.new("La liga antisupersticion te envia de viaje al numero 13", 13, TipoSorpresa::IRACASILLA)
    end
    
    def get_valor_cero
      nueva = Array.new
      @@mazo.each { |sorpresa|
        nueva<< sorpresa if sorpresa.valor > 0
      }
      nueva
    end
    
    def get_tipo_ir_a_casilla
      nueva = Array.new
      @@mazo.each { |sorpresa|
        nueva<< sorpresa if sorpresa.tipo == TipoSorpresa::IRACASILLA
      }
      nueva
    end
    
    def get_tipo_a_elegir (tipo)
      nueva = Array.new
      @@mazo.each { |sorpresa|
        nueva<< sorpresa if sorpresa.tipo == tipo
      }
      nueva
    end
    
    def main
      nueva = Array.new
      inicializar_sorpresas
      nueva = get_valor_cero
      puts nueva
      nueva = get_tipo_ir_a_casilla
      puts nueva
      nueva = get_tipo_a_elegir(TipoSorpresa::SALIRCARCEL)
      puts nueva
    end
  end
  p_q = PruebaQytetet.new
  p_q.main
end
