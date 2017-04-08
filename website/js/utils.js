function toggle_visibility(id) {
   var element = document.getElementById(id);
   if(element.style.display == 'block')
      element.style.display = 'none';
   else
      element.style.display = 'block';

	var icon = document.getElementById('toggle_arrow_' + id)
	if(!icon.className.localeCompare('fa fa-angle-down'))
		icon.className = 'fa fa-angle-up'
	else
		icon.className = 'fa fa-angle-down'
}
