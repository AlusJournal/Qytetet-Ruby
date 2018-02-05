#encoding: utf-8
module ModeloQytetet
  class Jugador
    @carta_libertad
    @casilla_actual
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
      
    end
    def actualizar_posicion(casilla)
      
    end
    def comprar_titulo
      
    end
    def devolver_carta_libertad
      
    end
    def ir_a_carcel(casilla)
      
    end
    def modificar_saldo(cantidad)
      
    end
    def obtener_capital
      
    end
    def obtener_propiedades_hipotecadas(hipotecada)
      
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
      
    end
    def vender_propiedad(casilla)
      
    end
    def cuantas_casas_hoteles_tengo
      
    end
    def eliminar_de_mis_propiedades(casilla)
      
    end
    def es_de_mi_propiedad(casilla)
      
    end
    def tengo_saldo(cantidad)
      
    end
    def to_s
      "Jugador: #{@nombre} \n Saldo: #{@saldo}"
    end
  end
end
