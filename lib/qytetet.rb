#encoding: utf-8
require "singleton"
module ModeloQytetet
  class Qytetet
    include Singleton
    
    attr_reader :mazo
    attr_reader :jugadores
    attr_reader :jugador_actual
    attr_reader :carta_actual
    attr_reader :tablero
    
    MAX_JUGADORES = 4
    MAX_CARTAS = 10
    MAX_CASILLAS = 20
    PRECIO_LIBERTAD = 200
    SALDO_SALIDA = 1000
    
    def aplicar_sorpresa
      
    end
    
    def cancelar_hipoteca(casilla)
      
    end
    
    def comprar_titulo_propiedad
      
    end
    
    def edificar_casa(casilla)
      
    end
    def edificar_hotel(casilla)
      
    end
    def get_carta_actual
      @carta_actual
    end
    def get_jugador_actual
      @jugador_actual
    end
    def hipotecar_propiedad(casilla)
      
    end
    def inicializar_juego(nombres)
      
    end
    def intentar_salir_carcel(metodo)
      
    end
    def jugar
      
    end
    def obtener_ranking
      
    end
    def propiedades_hipotecadas_jugador(hipotecada)
      
    end
    def siguiente_jugador
      
    end
    def vender_propiedad(casilla)
      
    end
    def encarcelar_jugador
      
    end
    
    def inicializar_cartas_sorpresa
      @mazo = Array.new
      @mazo << Sorpresa.new("La DEA te ha pillado con cocaína y pasarás un tiempo en Litchfield", @tablero.carcel.numero_casilla, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Encuentras un acceso al Upside Down y te lleva directo a Jackson", 16, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Te han invitado a una fiesta por la noche en casa de Jessica", 13, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Los otros jugadores han probado tu producto azul y te pagan unos cuantos gramos", 500, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("Jessica Jones ha expuesto tus secretos y pagas a los testigos para que nadie hable", -400, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("Cada celda de pabellón te pagan por tus servicios al protegerles", 300, TipoSorpresa::PORCASAHOTEL)
      @mazo << Sorpresa.new("Taylor ha decidido que tu hotel está contruido en un lugar histórico de Stars Hollow", -400, TipoSorpresa::PORCASAHOTEL)
      @mazo << Sorpresa.new("El Presidente te otorga un presupuesto solicitado", 600, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Matt Murdock te ha defendido en un juicio y debes pagar sus honorarios", -700, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Elisabeth II te ha dado un indulto y puedes abandonar la prisión", 0, TipoSorpresa::SALIRCARCEL)
    end
    
    def inicializar_jugadores(nombres)
      nombres.each{ |jugador|
        @jugadores<< nombres
      }
    end
    
    def inicializar_tablero
      @tablero = Tablero.new
    end
    
    def salida_jugadores
      
    end
  end
end
