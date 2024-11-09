class Viaje {
  const property idioma = []
  method sePuedeBroncear()
  method diasDeViaje()
  method implicaEsfuerzo()
  method esInteresante() = idioma.size() > 1
}

class Playa inherits Viaje {
  const largoPlaya

  override method diasDeViaje() = largoPlaya / 500

  override method implicaEsfuerzo() = largoPlaya > 1200

  override method sePuedeBroncear() = true
}

class Ciudad inherits Viaje {
  const cantidadAtracciones

  override method diasDeViaje() = cantidadAtracciones / 2

  override method implicaEsfuerzo() = cantidadAtracciones.between(5,8)

  override method sePuedeBroncear() = false

  override method esInteresante() = super() or cantidadAtracciones == 5
}

class CiudadTropical inherits Ciudad {
  override method diasDeViaje() = super() + 1
  override method sePuedeBroncear() = true
}

class Treking inherits Viaje {
  const property kmSenderos
  const property diasSolPorAnio

  override method diasDeViaje() = kmSenderos / 50

  override method implicaEsfuerzo() = kmSenderos > 80

  override method sePuedeBroncear() = diasSolPorAnio > 200 || (diasSolPorAnio.between(100, 200) && kmSenderos > 120)

  override method esInteresante() = super() && diasSolPorAnio > 140
}

class ClasesGimnasia inherits Viaje {
  override method idioma() = "español"

  override method diasDeViaje() = 1

  override method implicaEsfuerzo() = true

  override method sePuedeBroncear() = false

  override method esInteresante() {}
}

class Socio {
  var property edad
  const property idiomas = []
  const property actividades = []
  const property maxActividades

  method puedeRegistrar() = actividades.size() != maxActividades

  method registrarActividad(unaActividad) {
    if (self.puedeRegistrar()){
      actividades.add(unaActividad)
    }
    else {
      self.error("No se puede agregar mas actividades")
    }
  }

  method adoraAlSol() = actividades.all({ a => a.sePuedeBroncear() })

  method actividadesEsforzadas() = actividades.filter({ a => a.implicaEsfuerzo() })

  method leAtrae(unaActividad)
}

class Tranquilo inherits Socio {
  override method leAtrae(unaActividad) = unaActividad.diasDeViaje() >= 4
}

class Coherente inherits Socio {
  override method leAtrae(unaActividad) {
    return if (self.adoraAlSol()){
      unaActividad.sePuedeBroncear()
    }
    else {
      unaActividad.implicaEsfuerzo()
    }
  }
}

class Relajado inherits Socio {
  override method leAtrae(unaActividad) = unaActividad.idioma().asSet().intersection(self.idiomas().asSet())

}