#encoding: utf-8
module ModeloQytetet
  class TituloPropiedad
    attr_reader :nombre
    attr_accessor :hipotecada
    attr_reader :alquiler_base
    attr_reader :factor_revalorizacion
    attr_reader :hipoteca_base
    attr_reader :precio_edificar
    attr_writer :casilla_actual
    attr_writer :propietario
    def initialize(nombre, alquiler_base, factor_revalorizacion, hipoteca_base, precio_edificar)
      @nombre = nombre
      @hipotecada = false
      @alquiler_base = alquiler_base
      @factor_revalorizacion = factor_revalorizacion
      @hipoteca_base = hipoteca_base
      @precio_edificar = precio_edificar
    end
    
    def cobrar_alquiler(coste)
      
    end
    
    def propietario_encarcelado
      
    end
    
    def tengo_propietario
      
    end
    
    def to_s
      "#{nombre}. Alquiler base: #{@alquiler_base}$. Factor de Revalorizacion #{@factor_revalorizacion}. Hipoteca Base: #{@hipoteca_base}$. Precio Edificar #{@precio_edificar}$"
    end 
  end
end
