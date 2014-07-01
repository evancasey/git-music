var tokens = require('./tokens.js');
var $ = require('jquery');
var sys = require('sys');
var exec = require('child_process').exec;

function puts(error, stdout, stderr) {
  sys.puts(stdout)
  return stdout
}

function songBuilder(song, commitMessages, songHash) {
  this.song = song;
  this.commitMessages = commitMessages;
  this.songHash = songHash;

  this.buildSpeech = function() {
    var formattedCommitMessages = this.commitMessages.toString().replace(',',' ');
    var command = 'echo' + formattedCommitMessages + ' | say -o tmp/' + this.songHash + '.aiff';
    exec(command, puts);
  }

  this.tuneSpeech = function() {
    var parameters  = { blocking: false, 
                        format: 'json', 
                        access_id: tokens.getSonicAccessId(),
                        input_file: 'tmp/' + this.songHash + '.aiff',
                        pitchdrift_percent: '25',
			pitchcorrection_percent: '100' };

    $.ajax({ url: 'https://api.sonicAPI.com/process/elastiqueTune', data: parameters, 
                 success: this.mergeSpeechWithInstrumental, error: this.onTaskFailed, crossDomain: true }); 
  }

  this.mergeSpeechWithInstrumental = function(fileId) {
    console.log('success!');
  }
 
  this.onTaskFailed = function(response) {
    var data = $.parseJSON(response.responseText);
    var errorMessages = data.errors.map(function(error) { return error.message; });
 
    $('#result').text('Task failed, reason: ' + errorMessages.join(','));  
  }
	

}

var song1 = new songBuilder('drake',['one','two'],'aeuaoeu');
song1.buildSpeech();
song1.tuneSpeech();
