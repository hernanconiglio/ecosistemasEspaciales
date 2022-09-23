object reserva {
	const habitats = []
	
	method agregarHabitat(unHabitat) {habitats.add(unHabitat)}
	method habitatConMayorBiomasa() = habitats.max({h=>h.totalBiomasa()})
	method cantidadTotalBiomasa() = habitats.sum({h=>h.totalBiomasa()})
	method habitatsDesequilibrados() = habitats.filter({h=>!h.estaEnEquilibrio()})
	method especieEstaEnTodosLosHabitats(unTipoDeEspecie) = 
		habitats.all({h=>h.contieneEspecie(unTipoDeEspecie)})
}

class Habitat {
	const especies = []
	
	method agregarEspecies(listaEspecies) {especies.addAll(listaEspecies)}
	method totalBiomasa() = especies.sum({e=>e.biomasa()})
	method agregarEspecie(unaEspecie) = especies.add(unaEspecie)
	method cantidadEjemplaresGrandes() = especies.count({e=>e.esGrande()})
	method cantidadEjemplaresPequenios() = especies.count({e=>e.esPequenio()})
	method hayMedianos() = especies.any({e=>e.esMediano()})
	method estaEnEquilibrio() = 
		self.cantidadEjemplaresGrandes() < self.cantidadEjemplaresPequenios() / 3 &&
		self.hayMedianos()
	method especiesExistentes() = especies.map({e=>e.especie()})
	method contieneEspecie(unaEspecie) = self.especiesExistentes().contains(unaEspecie)
	method producirIncendio() {
		especies.forEach({e=>e.consecuenciasPorIncendio()})
	}
}

class TipoDeEspecieFauna {
	const property pesoReferencia
	const property formaDeLocomocion
	const property coeficiente
}

class Animal {
	const property tipoDeEspecie
	var peso
	var estaVivo = true
	
	method biomasa() = peso**2 / tipoDeEspecie.coeficiente()
	method esGrande() = peso > tipoDeEspecie.pesoReferencia() * 2
	method esPequenio() = peso < tipoDeEspecie.pesoReferencia() / 2
	method esMediano() = !self.esGrande() && !self.esMediano()
	method consecuenciasPorIncendio() {
		peso *= 0.9
		if(!self.seSalva()) estaVivo = false
	}	
	method seSalva() = 
		tipoDeEspecie.formaDeLocomocion() == nadar.locomocion() ||
		(tipoDeEspecie.formaDeLocomocion() == volar.locomocion() && self.esGrande()) ||
		(tipoDeEspecie.formaDeLocomocion() == correr.locomocion() && self.esMediano()) 
						
}

class TipoDeEspecieFlora {}

class Planta {
	var estaViva = true
	const property tipoDeEspecie
	var property altura
		
	method biomasa() = 50.min(altura * 2)
	method esGrande() = altura > 10
	method esPequenio() = !self.esGrande()
	method esMediano() = false	
	method consecuenciasPorIncendio() {
		if(self.esPequenio()) estaViva = false
		else altura = 0.max(altura - 5)
	}
}

object volar {method locomocion() = self}
object nadar {method locomocion() = self}
object correr {method locomocion() = self}
object quedarseQuieto {method locomocion() = self}
