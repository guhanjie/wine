weui.searchBar('#item-searchBar');

$('#item-searchBar .weui-search-bar__search-btn').on('click touch', function() {
    var query = $('#item-searchBar input').val();
    window.location.href = "/wine/items/search?query="+query;
});