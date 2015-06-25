var setKeywordVocabulary = {

    onLoad: function() {
        this.setEventOnAddButton();
		this.setInitialAutocomplete();
    },

	setEventOnAddButton: function() {
		$('button.add').each(function() {
			if ( $(this).closest('div').attr('class').indexOf('collection_tag') >= 0 ) {
				$(this).click(function() {
					setTimeout(setKeywordVocabulary.initAutocomplete,500);
				})
			}
		})
	},
	
	initAutocomplete: function() {
		$('input.collection_tag').each(function() {
			$(this).autocomplete({
	        	minLength: 3,
	        	source: function(request, response) {
	            	$.ajax({
	                	url: '/qa/search/agrovoc/skosmos?q=' + request.term,
						type: 'GET',
	                	dataType: 'json',
	                	complete: function(xhr, status) {
	                    	var results = $.parseJSON(xhr.responseText);                        
	                    	response(results);
	                	}
	            	});
	        	}
			})

	  })
		setKeywordVocabulary.setEventOnAddButton();
	},
	
	setInitialAutocomplete: function() {
		$('#collection_tag').autocomplete({
	        minLength: 3,
	        source: function(request, response) {
	            $.ajax({
	                url: '/qa/search/agrovoc/skosmos?q=' + request.term,
					type: 'GET',
	                dataType: 'json',
	                complete: function(xhr, status) {
	                    var results = $.parseJSON(xhr.responseText);                        
	                    response(results);
	                }
	            });
	        }
	  })
	}

};

$(document).ready(function() {
    $('form').each(function() {
		var theID = $(this).attr('id');
		if ( theID.indexOf("_collection") >= 0 ) {
        	setKeywordVocabulary.onLoad();
			return false;
		}
    })
});
