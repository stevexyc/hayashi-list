Docs = new Meteor.Collection('docs')

Meteor.startup(function(){
	if(Docs.find({}).count() == 0) {
		Docs.insert ({
			title: 'First list',
			text: '<li>first item</li><li>second item</li>'
		}) 
	}  
	
})
	