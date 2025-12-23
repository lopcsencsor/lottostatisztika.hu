
function sw(szoveg) {
    swal.fire({
        title: "Hiba",
        text: szoveg,
        icon: "error",
    });
}

function swMove(szoveg) {
    swal.fire({
        title: "Hiba",
        text: szoveg,
        icon: "error",
        showClass: {
            popup: 'animate__animated animate__fadeInDown'
        },
        hideClass: {
            popup: 'animate__animated animate__fadeOutUp'
        }
    });
}
