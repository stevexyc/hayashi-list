@Docs = new Meteor.Collection('docs')

Session.set('wtf', 'no')

console.log('starting')


Template.list.list = () ->
	Docs.findOne({})


Template.list.events {

	'click #test': (e,t) ->
		Session.set('wtf','test')
		console.log 'set test'
		getWord()

	# 'keyup #main-list': (e,t) ->
	# 	listId = this._id
	# 	textTimer.clear()
	# 	textTimer.set( ->
	# 		content = document.getElementById('main-list').innerHTML
	# 		console.log content
	# 		Docs.update(listId, {$set: {text: content}})
	# 	)
	'focusout #main-list': (e,t) ->
		content = document.getElementById('main-list').innerHTML
		Docs.update(this._id, {$set: {text: content}})
		console.log 'saved'

	'keydown #main-list': (e,t) ->
		if (e.which is 9)
			e.preventDefault()
			getWord()

	'focusout #list-title': (e,t) ->
		newTitle = document.getElementById('list-title').value
		Docs.update(this._id, {$set: {title: newTitle}})

	'keyup #list-title': (e,t) ->
		if (e.which is 13)
			newTitle = document.getElementById('list-title').value
			Docs.update(this._id, {$set: {title: newTitle}})
			Deps.flush()
			document.getElementById('main-list').focus()
			console.log '13'

	'keydown #list-title': (e,t) ->
		if (e.which is 9)
			e.preventDefault()
			newTitle = document.getElementById('list-title').value
			Docs.update(this._id, {$set: {title: newTitle}})
			Deps.flush()
			document.getElementById('main-list').focus()
			console.log '9'



}

getWord = () ->
	html = ''
	if typeof window.getSelection != 'undefined' 
		sel = window.getSelection()

		console.log sel

		if sel.rangeCount
			str = sel.toString().trim()
			if str.length > 0
				# get the text
				html = str
				# add the span
				range = sel.getRangeAt(0).cloneRange()
				range.surroundContents(document.createElement('span'))
				sel.removeAllRanges()
				sel.addRange(range)
			else 
				html = 'nothing' 

	else if typeof document.selection != 'undefined'
		if document.selection.type is 'Text'
			console.log document.selection
			html = document.selection.createRange().htmlText
	console.log html


`var textTimer = function(){
    var timer;
    this.set = function(saveText) {
      timer = Meteor.setTimeout(function() {
        saveText();
      }, 2500)
    };
    this.clear = function() {
      Meteor.clearInterval(timer);
    };
    return this;    
}();
`