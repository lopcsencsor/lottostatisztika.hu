function nyeroszamokOsszegeGy(fieldArray) {
    let osszeg = 0;
    for (i=0; i<fieldArray.length;i++){
        //console.log(parseInt($(fieldArray[i]).val()));
        osszeg =  osszeg + numerikusErtekEllenorzes(parseInt($(fieldArray[i]).val()) );
    }
    return (osszeg);
}
