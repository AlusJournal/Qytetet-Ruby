#encoding: utf-8
module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla
    attr_accessor :coste
    attr_accessor :num_hoteles
    attr_accessor :num_casas
    attr_reader :tipo
    attr_accessor :titulo
    
    def initialize(tipo, numero_casilla)                   
       @numero_casilla = numero_casilla
       @tipo = tipo
       @coste = 0
       @num_hoteles = 0    
       @num_casas = 0    
       @titulo = nil    
     end    
         
     def self.init_calle(coste, numero_casilla, titulo)    
       casilla = new(TipoCasilla::CALLE, numero_casilla)    
       casilla.coste = coste    
       casilla.num_hoteles = 0    
       casilla.num_casas = 0    
       casilla.titulo = titulo   
       casilla
     end
     
     def asignar_propietario(jugador)
       @titulo.propietario(jugador)
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
       
     end
     
     def se_puede_edificar_hotel
       
     end
 
     def soy_edificable
       esEdificable = false
       if (@tipo == TipoCasilla::CALLE)
         esEdificable = true
       end
       esEdificable
     end
     
     def tengo_propietario
       @titulo.tengo_propietario
     end
     
     def vender_titulo
       
     end
    
     def asignar_titulo_propiedad
       
     end
    
    def to_s
      "#{@numero_casilla}. Coste: #{@coste}"
    end 
  
  end
end
