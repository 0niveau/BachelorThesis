package mypoll

class ScaleCreateCommand {
	String nameOfSelectedScale
	int numberOfOptions
}

class ScaleController {

    def index() { }
	
	/*
	 * finds all subclasses of Scale and passes them to the create view
	 */
	def prepareCreation() {
		def scaleDomainClass = grailsApplication.domainClasses.find { it.name == 'Scale' }
		def subClassesOfScale = scaleDomainClass.getSubClasses().collect { it.shortName }
		
		model: [scales: subClassesOfScale]
	}
	
	/*
	 * renders the general 'create' view and passes the specific scale type to the views model
	 * @cmd contains the name of the selected specific scale type and the desired number of Options 
	 */
	def create(ScaleCreateCommand cmd) {
		def classOfSelectedScale = grailsApplication.domainClasses.find { it.name == cmd.nameOfSelectedScale }
		String typeOfSelectedScale = classOfSelectedScale.getShortName()
		int numberOfOptions = params.numberOfOptions as int
		
		model: [numberOfOptions: numberOfOptions, typeOfScale: typeOfSelectedScale]
	}
}
