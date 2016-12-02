'use strict';

var ws = new WebSocket('ws://ec2-54-147-114-181.compute-1.amazonaws.com:3000/ws');
// var ws = new WebSocket('ws://localhost:3000/ws');


$(function () {
  $('form').submit(function(){
    var $this = $(this);
    ws.onopen = function() {
      console.log('sent message: %s', $('#m').val());
    };
    ws.send(
        '{"text": "' + $('#m').val() + '"}'
    );
    $('#m').val('');
    return false;
  });
  ws.onmessage = function(msg){
    console.log(msg);
    var resp = JSON.parse(msg.data);
    $('#messages')
      .append($('<li>')
      .append($('<span class="message">').text(resp.text)));
  };
  ws.onerror = function(err){
    console.log("err", err);
  };
  ws.onclose = function close() {
    console.log('disconnected');
  };
});
