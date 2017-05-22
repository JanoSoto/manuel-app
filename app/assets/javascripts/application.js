// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require adminlte
//= require jquery.inputmask.bundle.min
//= require pace/pace
//= require toastr
//= require rutvalidator
//= require datatables/jquery.dataTables.min
//= require datatables/dataTables.bootstrap.min
//= require sweetalert2.min
//= require core.js
//= require turbolinks
//= require_tree .

$(document).on("turbolinks:load", function(){
	$.AdminLTE.layout.activate();
	$('input').inputmask();
	$('form').validator();

	$('.switch').bootstrapToggle();
	$('select').select2();
	$('.datepicker').datepicker({
		language: 'es'
	});
});
