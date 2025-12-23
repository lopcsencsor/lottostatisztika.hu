function nyeroszamEllenorzes(field){
    let nyeroszam = parseInt($(field).val());
    if ( nyeroszam > 90 || nyeroszam < 1 ) {
        sw('A ' + field + ' értéke nem megfelelő! Javítsd!')
        $(field).val(null);
        $(field).focus();
    };
}

function nyeroszamIsmetlodes(field1,field2,field3,field4,field5){
    let nyeroszam1 = parseInt($(field1).val());
    let nyeroszam2 = parseInt($(field2).val());
    let nyeroszam3 = parseInt($(field3).val());
    let nyeroszam4 = parseInt($(field4).val());
    let nyeroszam5 = parseInt($(field5).val());

    // 1-2
    if ( nyeroszam2 !== null && nyeroszam1 == nyeroszam2 ) {
        swMove('Az első és a második nyerőszámok megegyeznek! Javítsd!')
        $(field2).val(null);
        $(field2).focus();
    };

    // 1-3
    if ( nyeroszam3 !== null && nyeroszam1 == nyeroszam3 ) {
        sw('Az első és a harmadik nyerőszámok megegyeznek! Javítsd!')
        $(field3).val(null);
        $(field3).focus();
    };

    // 1-4
    if ( nyeroszam4 !== null && nyeroszam1 == nyeroszam4 ) {
        sw('Az első és a negyedik nyerőszámok megegyeznek! Javítsd!')
        $(field4).val(null);
        $(field4).focus();
    };

    // 1-5
    if ( nyeroszam5 !== null && nyeroszam1 == nyeroszam5) {
        sw('Az első és az ötödik nyerőszámok megegyeznek! Javítsd!')
        $(field5).val(null);
        $(field5).focus();
    };

    // 2-3
    if ( nyeroszam3 !== null && nyeroszam2 == nyeroszam3) {
        sw('Az második és a harmadik nyerőszámok megegyeznek! Javítsd!')
        $(field3).val(null);
        $(field3).focus();
    };

    // 2-4
    if ( nyeroszam4 !== null && nyeroszam2 == nyeroszam4 ) {
        sw('A második és a negyedik nyerőszámok megegyeznek! Javítsd!')
        $(field4).val(null);
        $(field4).focus();
    };

    // 1-5
    if ( nyeroszam5 !== null && nyeroszam2 == nyeroszam5) {
        sw('A második és az ötödik nyerőszámok megegyeznek! Javítsd!')
        $(field5).val(null);
        $(field5).focus();
    };

    // 3-4
    if ( nyeroszam4 !== null && nyeroszam3 == nyeroszam4 ) {
        sw('A harmadik és a negyedik nyerőszámok megegyeznek! Javítsd!')
        $(field4).val(null);
        $(field4).focus();
    };

    // 3-5
    if ( nyeroszam5 !== null && nyeroszam3 == nyeroszam5) {
        sw('Az harmadik és az ötödik nyerőszámok megegyeznek! Javítsd!')
        $(field5).val(null);
        $(field5).focus();
    };

    // 4-5
    if ( nyeroszam5 !== null && nyeroszam4 == nyeroszam5) {
        sw('A negyedik és az ötödik nyerőszámok megegyeznek! Javítsd!')
        $(field5).val(null);
        $(field5).focus();
    };
}

//Igazából úgy alakítanám át - most, hogy már működik, hogy az értékeket egy tömbbe tenném, és két, egymásba ágyazott ciklusba tenném bele őket.
//Sajnos a focus() ebben az esetben is csak külön működtethető.

// Nyerőszámok összege

function nyeroszamokOsszege(field1,field2,field3,field4,field5) {
    let nyeroszam1 = parseInt($(field1).val());
    let nyeroszam2 = parseInt($(field2).val());
    let nyeroszam3 = parseInt($(field3).val());
    let nyeroszam4 = parseInt($(field4).val());
    let nyeroszam5 = parseInt($(field5).val());
    let osszeg =  numerikusErtekEllenorzes(nyeroszam1)
                + numerikusErtekEllenorzes(nyeroszam2)
                + numerikusErtekEllenorzes(nyeroszam3)
                + numerikusErtekEllenorzes(nyeroszam4)
                + numerikusErtekEllenorzes(nyeroszam5)

    return (osszeg);
}

// function nyeroszamokOsszegeGy(fieldArray) {
//     let osszeg = 0;
//     for (i=0; i<fieldArray.length;i++){
//         //console.log(parseInt($(fieldArray[i]).val()));
//         osszeg =  osszeg + numerikusErtekEllenorzes(parseInt($(fieldArray[i]).val()) );
//     }
//     return (osszeg);
// }

//Ismétlődés ellenőrzés röviden

function nyeroszamIsmetlodesShort(fieldArray){
    for (i=0; 3;i++){
        for (j=i+1; 4; j++)
            console.log('i:' + i + 'j:' + j);

        console.log('i. fieldArray[' + i + '] értéke ' + fieldArray[i].val() + 'j. fieldArray[' + j + '] értéke ' + fieldArray[j].val());

            if ( parseInt($(fieldArray[j]).val() !== null && parseInt($(fieldArray[i]).val() == parseInt($(fieldArray[j]).val()) {
                sw('A(z) ' + i +'. és a(z) ' + j + '. nyerőszámok értéke megegyezik! Javítandó!')
                $(fieldArray[j]).val(null);
                $(fieldArray[j]).focus();
            };
    }
}

// console.log($i)
    // console.log(parseInt($(fieldArray[i]).val()));
    // osszeg =  osszeg + numerikusErtekEllenorzes(parseInt($(fieldArray[i]).val()) );
