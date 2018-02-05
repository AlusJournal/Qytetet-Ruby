#encoding: utf-8
module ModeloQytetet
  class Jugador
    
    attr_accessor :encarcelado
    attr_reader :nombre
    attr_accessor :saldo
    attr_accessor :casilla_actual
    attr_accessor :carta_libertad
    attr_reader :propiedades
    
    def initialize(nombre)
      @nombre = nombre
      @encarcelado = false
      @saldo = 7500
    end
    
    def get_casilla_actual
      @casilla_actual
    end
    
    def get_encarcelado
      @encarcelado
    end
    def tengo_propiedades
      !propiedades.empty?
    end
    def actualizar_posicion(casilla)
      
    end
    def comprar_titulo
      
    end
    def devolver_carta_libertad
      antigua_carta = @carta_libertad
      Qytetet.instance.mazo<< antigua_carta
      @carta_libertad = nil
      antigua_carta
    end
    def ir_a_carcel(casilla)
      
    end
    def modificar_saldo(cantidad)
      @saldo += cantidad
    end
    def obtener_capital
      capital = @saldo
      propiedades.each { |propiedad|
        capital = capital + propiedad.casilla.num_hoteles*propiedad.precio_edificar + propiedad.casilla.num_casas*propiedad.precio_edificar
        if(propiedad.hipotecada == true)
          capital = capital - propiedad.hipoteca_base
        end
      }
      capital
    end
    def obtener_propiedades_hipotecadas(hipotecada)
      titulos = Array.new
      if(hipotecada)
        propiedades.each{ |propiedad|
          if(propiedad.hipotecada)
            titulos<< propiedad
          end
        }
      else
        propiedades.each{ |propiedad|
          if(!propiedad.hipotecada)
            titulos<< propiedad
          end
        }
      end
      titulos
    end
    def pagar_cobrar_por_casa_y_hotel(cantidad)
      
    end
    def pagar_libertad(cantidad)
      
    end
    def puedo_edificar_casa(casilla)
      
    end
    def puedo_edificar_hotel(casilla)
      
    end
    def puedo_hipotecar(casilla)
      
    end
    def puedo_pagar_hipoteca(casilla)
      
    end
    def puedo_vender_propiedad(casilla)
      puedo = false
      if (es_de_mi_propiedad(casilla))
        puedo = true
      end
      puedo
    end
    def set_carta_libertad(carta)
      @carta_libertad = carta
    end
    def set_casilla_actual(casilla)
      @casilla_actual = casilla
    end
    def set_encarcelado(encarcelado)
      @encarcelado = encarcelado
    end
    def tengo_carta_libertad
      tengo = false
      if(@carta_libertad != nil)
        tengo = true
      end
    end
    def vender_propiedad(casilla)
      
    end
    def cuantas_casas_hoteles_tengo
      total = 0
      @propiedades.each{ |titulo|
        total = total + titulo.casilla.num_casas + titulo.casilla.num_hoteles
      }
      total
    end
    def eliminar_de_mis_propiedades(casilla)
      if(es_de_mi_propiedad(casilla))
        @propiedades.delete(casilla.titulo)
      end
    end
    def es_de_mi_propiedad(casilla)
      tengo = false
      @propiedades.each{ |titulo|
        if (titulo.casilla == casilla)
          tengo = true
        end
      }
      tengo
    end
    def tengo_saldo(cantidad)
      tengo = false
      if (cantidad < @saldo)
        tengo = true
      end
      tengo
    end
    def to_s
      "Jugador: #{@nombre} \n Saldo: #{@saldo}"
    end
  end
end
