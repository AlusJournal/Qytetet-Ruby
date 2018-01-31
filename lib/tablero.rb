#encoding: utf-8
require_relative "tipo_casilla"
require_relative "casilla"
require_relative "titulo_propiedad"
module ModeloQytetet
  class Tablero
    attr_reader :casillas
    attr_reader :carcel
    
    def initialize
      inicializar
    end
    
    private 
    def inicializar
      @casillas = Array.new
      
      salida = Casilla.new(0, TipoCasilla::SALIDA)
      @casillas<< salida
      sorpresa1 = Casilla.new(3, TipoCasilla::SORPRESA)
      @casillas<< sorpresa1
      sorpresa2 = Casilla.new(8, TipoCasilla::SORPRESA)
      @casillas<< sorpresa2
      sorpresa3 = Casilla.new(14, TipoCasilla::SORPRESA)
      @casillas<< sorpresa3
      @carcel = Casilla.new(15, TipoCasilla::CARCEL)
      @casillas<< @carcel
      juez = Casilla.new(5, TipoCasilla::JUEZ)
      @casillas<< juez
      parking = Casilla.new(10, TipoCasilla::PARKING)
      @casillas<< parking
      impuesto = Casilla.new(18, TipoCasilla::SORPRESA)
      @casillas<< impuesto
      impuesto.coste = 700
      
      breaking_bad = Casilla.new(19, 2000, TituloPropiedad.new("Breaking Bad", 100, 20, 1000, 750))
      @casillas<< breaking_bad
      narcos = Casilla.new(17, 1900, TituloPropiedad.new("Narcos", 100, 19, 950, 750))
      @casillas<< narcos
      stranger_things = Casilla.new(16, 1600, TituloPropiedad.new("Stranger Things", 95, 18, 875, 650))
      @casillas<< stranger_things
      thirteenrw = Casilla.new(13, 1500, TituloPropiedad.new("Thirteen Reasons Why", 90, 17, 800, 600));
      @casillas<< thirteenrw
      the_crown = Casilla.new(12, 1350, TituloPropiedad.new("The Crown", 85, 16, 650, 500))
      @casillas<< the_crown
      oitnb = Casilla.new(11, 1300, TituloPropiedad.new("Orange is the new Black", 80, 15, 500, 425)) 
      @casillas<< oitnb
      house_of_cards = Casilla.new(9, 1100, TituloPropiedad.new("House of Cards", 75, 14, 450, 350))
      @casillas<< house_of_cards
      jessica = Casilla.new(7, 1000, TituloPropiedad.new("Jessica Jones", 70, 13, 350, 350))
      @casillas<< jessica
      gilmore_girls = Casilla.new(6, 950, TituloPropiedad.new("Girlmore Girls", 65, 12, 300, 300))
      @casillas<< gilmore_girls
      sense_eight = Casilla.new(4, 900, TituloPropiedad.new("Sense8", 60, 11, 250, 300))
      @casillas<< sense_eight
      daredevil = Casilla.new(2, 800, TituloPropiedad.new("Daredevil", 55, 10, 200, 250))
      @casillas<< daredevil
      shadowhunters = Casilla.new(1, 700, TituloPropiedad.new("ShadowHunters", 50, 10, 150, 250))
      @casillas<< shadowhunters
    end
    
    def to_s
      "Casillas: #{@casillas} \n Carcel: #{@carcel}"
    end
    
  end
end
