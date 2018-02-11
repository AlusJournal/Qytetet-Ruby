# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Calle < Casilla
    attr_accessor :num_hoteles
    attr_accessor :num_casas
    attr_accessor :titulo
    
    def initialize(numero_casilla, coste, titulo)
      super(numero_casilla, TipoCasilla::CALLE)
      @coste = coste
      @num_hoteles = 0
      @num_casas = 0
      @titulo = titulo
      @titulo.calle = self
    end
    
    def asignar_propietario(jugador)
       @titulo.propietario = jugador
       @titulo
     end
     
     def calcular_valor_hipoteca
       (@titulo.hipoteca_base * num_casas * 0.5 * @titulo.hipoteca_base + num_hoteles * @titulo.hipoteca_base).round
     end
     
     def cancelar_hipoteca
       
     end
     
     def cobrar_alquiler
       coste_alquiler_base = (@titulo.alquiler_base + (num_casas*0.5 + num_hoteles*2)).round
       @titulo.cobrar_alquiler(coste_alquiler_base)
       coste_alquiler_base
     end
     
     def edificar_casa
       @num_casas + 1
       coste_edificar_casa = @titulo.precio_edificar
       coste_edificar_casa
     end
     
     def edificar_hotel
       @num_hoteles + 1
       coste_edificar_hotel = @titulo.precio_edificar
       coste_edificar_hotel
     end
     
     def esta_hipotecada
       titulo.hipotecada
     end
     
     def get_coste_hipoteca
       @titulo.hipoteca_base
     end
     
     def get_precio_edificar
       @titulo.precio_edificar
     end
     
     def hipotecar
       @titulo.hipotecada = true
       calcular_valor_hipoteca
     end
     
     def precio_total_comprar
       
     end
     
     def propietario_encarcelado
       @titulo.propietario_encarcelado
     end
     
     def se_puede_edificar_casa
       @num_casas < (4 * @titulo.propietario.factor_especulador)
     end
     
     def se_puede_edificar_hotel
       @num_hoteles < (4 * @titulo.propietario.factor_especulador) && @num_casas >= 4
     end
     
     def tengo_propietario
       @titulo.tengo_propietario
     end
     
     def vender_titulo
       @titulo.propietario = nil
       precio_compra = @coste+(@num_casas+@num_hoteles)*@titulo.precio_edificar
       @num_hoteles = 0
       @num_casas = 0
       return (precio_compra + (@titulo.factor_revalorizacion*precio_compra)).round
     end
    
     def asignar_titulo_propiedad
       
     end
     
     def soy_edificable
       true
     end
    
     def to_s
      "Calle: #{@numero_casilla}. Coste: #{@coste}. Numero Casas: #{@num_casas}. Numero Hoteles: #{@num_hoteles}. Titulo: #{@titulo}"
     end
  end
end
