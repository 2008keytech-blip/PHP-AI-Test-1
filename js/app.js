$(function(){
  function showMessage(text){
    $('#message').text(text);
  }

  $('#searchForm').on('submit', function(e){
    e.preventDefault();
    var title = $('#title').val().trim();
    if(!title){ showMessage('Please enter a movie title.'); return; }

    $('#results').empty();
    showMessage('Searching...');
    $('#searchBtn').prop('disabled', true);

    $.ajax({
      url: 'api.php',
      method: 'POST',
      data: { title: title },
      dataType: 'json'
    }).done(function(resp){
      if(!resp || !resp.success){
        showMessage(resp && resp.error ? resp.error : 'Unexpected error');
        return;
      }
      var rows = resp.data || [];
      if(rows.length === 0){
        $('#results').html('<div class="no-results">No cast found for "'+$('<div>').text(title).html()+'".</div>');
        showMessage('');
        return;
      }

      var table = $('<table>').addClass('results-table');
      table.append('<thead><tr><th>Actor</th><th>Role</th></tr></thead>');
      var tbody = $('<tbody>');
      rows.forEach(function(r){
        var tr = $('<tr>');
        tr.append($('<td>').text(r.actor_name));
        tr.append($('<td>').text(r.role_name));
        tbody.append(tr);
      });
      table.append(tbody);
      $('#results').html(table);
      showMessage('');
    }).fail(function(xhr, status, err){
      showMessage('Request failed: '+status);
    }).always(function(){
      $('#searchBtn').prop('disabled', false);
    });
  });
});
