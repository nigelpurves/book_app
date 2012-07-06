$(function() {
    $("#interest_track_attributes_artist" ).autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "https://developer.echonest.com/api/v4/artist/suggest",
                dataType: "jsonp",
                data: {
                    results: 12,
                    api_key: "2HVNX2MVPMH02BZUM",
                    format:"jsonp",
                    name:request.term
                },
                success: function( data ) {
                    response( $.map( data.response.artists, function(item) {
                        return {
                            label: item.name,
                            value: item.name,
                            id: item.id
                        }
                    }));
                }
            });
        },
        minLength: 3,
        select: function( event, ui ) {
            $("#log").empty();
            $("#log").append(ui.item ? ui.item.id + ' ' + ui.item.label : '(nothing)');
        },
    });
});