
document.getElementById('file').onchange=function(e){
    let reader=new FileReader();
    reader.readAsDataURL(e.target.files[0]);
    reader.onload=function(){
			
        let preview=document.getElementById('preview');
			if (preview.firstElementChild) {
            preview.firstElementChild.remove();
        	}

            image=document.createElement('img');
            image.src=reader.result;
            preview.append(image);
    }
}
