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
	 * redirects to the 'create' method of a more specific controller
	 */
	def triggerCreation(ScaleCreateCommand cmd) {
		def classOfSelectedScale = grailsApplication.domainClasses.find { it.name == cmd.nameOfSelectedScale }
		int numberOfOptions = cmd.numberOfOptions
		
		redirect controller: classOfSelectedScale.getShortName(), action: 'create', params: [numberOfOptions: numberOfOptions]				
	}
}
