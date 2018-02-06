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
      if(casilla.numero_casilla < @casilla_actual.numero_casilla)
        modificar_saldo(@qytetet.instance.SALDO_SALIDA)
      end
      tiene_propietario = false
      @casilla_actual = casilla
      if(casilla.soy_edificable)
        tiene_propietario = casilla.tengo_propietario
        if(casilla.tengo_propietario)
          if(!casilla.propietario_encarcelado)
            coste_alquiler = casilla.cobrar_alquiler
            modificar_saldo((-1)*coste_alquiler)
          end
        end
      end
      if (casilla.tipo == TipoCasilla::IMPUESTO)
        coste = casilla.coste;
        modificar_saldo((-1)*coste)
      end
      tiene_propietario
    end
    
    def comprar_titulo
      puedo_comprar = false
      if(casilla_actual.soy_edificable)
        tengo_propietario = @casilla_actual.tengo_propietario
        if(!tengo_propietario)
          coste_compra = @casilla_actual.coste
          if(coste_compra <= @saldo)
            titulo = @casilla_actual.asignar_propietario(self)
            @propiedades<< titulo
            modificar_saldo((-1)*coste_compra)
            puedo_comprar = true
          end
        end
      end
      puedo_comprar
    end
    
    def devolver_carta_libertad
      antigua_carta = @carta_libertad
      Qytetet.instance.mazo<< antigua_carta
      @carta_libertad = nil
      antigua_carta
    end
    
    def ir_a_carcel(casilla)
      set_casilla_actual(casilla)
      set_encarcelado(true)
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
      numero_total = cuantas_casas_hoteles_tengo
      modificar_saldo(numero_total*cantidad)
    end
    
    def pagar_libertad(cantidad)
      tengo_saldo = tengo_saldo(cantidad)
      if(tengo_saldo)
        modificar_saldo((-1)*cantidad);
      end
      tengo_saldo
    end
    
    def puedo_edificar_casa(casilla)
      es_mia = es_de_mi_propiedad(casilla)
      tengo_saldo = false
      if (es_mia)
        coste_edificar_casa = casilla.get_precio_edificar
        tengo_saldo = tengo_saldo(coste_edificar_casa)
      end
      return (es_mia && tengo_saldo)
    end
    
    def puedo_edificar_hotel(casilla)
      
    end
    
    def puedo_hipotecar(casilla)
      return es_de_mi_propiedad(casilla) && !casilla.titulo.hipotecada
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
