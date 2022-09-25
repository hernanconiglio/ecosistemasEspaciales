class EspecieFauna {
	const property pesoReferencia
	const property formaDeLocomocion
	const property coeficiente
}

class Animal {
	const property especie
	var peso
	var estaVivo = true
	
	method biomasa() = peso**2 / especie.coeficiente()
	method esGrande() = peso > especie.pesoReferencia() * 2
	method esPequenio() = peso < especie.pesoReferencia() / 2
	method esMediano() = !self.esGrande() && !self.esMediano()
	method consecuenciasPorIncendio() {
		peso *= 0.9
		if(!especie.formaDeLocomocion().seSalva(self)) estaVivo = false
	}	
						
}

class EspecieFlora {}

class Planta {
	var estaViva = true
	const property especie
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

object volar {method locomocion() = self ; method seSalva(animal) = animal.esGrande()}
object nadar {method locomocion() = self ; method seSalva(_) = true}
object correr {method locomocion() = self ; method seSalva(animal) = animal.esMediano()}
object quedarseQuieto {method locomocion() = self ; method seSalva(_) = false}