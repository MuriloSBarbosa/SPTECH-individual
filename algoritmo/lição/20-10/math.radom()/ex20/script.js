var v1 = 0;
var v2 = 0;
var empate = 0;

function jogar() {

    btn_jogar.disabled = true;
    img_jogador1.src = "https://png.vector.me/files/images/3/2/323082/dado_6_preview"
    img_jogador2.src = "https://png.vector.me/files/images/3/2/323082/dado_6_preview"

    img_jogador1.classList.add('girarRapido');
    img_jogador2.classList.add('girarRapido');

    setTimeout(function () {

        img_jogador1.classList.add('girarLento');
        img_jogador2.classList.add('girarLento');

        var jogador1_sorteio = 1 + parseInt(Math.random() * (6 + 1 - 1));
        var jogador2_sorteio = 1 + parseInt(Math.random() * (6 + 1 - 1));

        var jogador1_dado = "";
        var jogador2_dado = "";

        //1
        if (jogador1_sorteio == 1) {
            jogador1_dado = "https://images.vectorhq.com/images/previews/27e/dado-1-138329.png"
        }
        if (jogador2_sorteio == 1) {
            jogador2_dado = "https://images.vectorhq.com/images/previews/27e/dado-1-138329.png"
        }
        //2
        if (jogador1_sorteio == 2) {
            jogador1_dado = "https://png.vector.me/files/images/3/2/323094/dado_2_preview"
        }
        if (jogador2_sorteio == 2) {
            jogador2_dado = "https://png.vector.me/files/images/3/2/323094/dado_2_preview"
        }
        //3
        if (jogador1_sorteio == 3) {
            jogador1_dado = "https://png.vector.me/files/images/3/2/323091/dado_3_preview"
        }
        if (jogador2_sorteio == 3) {
            jogador2_dado = "https://png.vector.me/files/images/3/2/323091/dado_3_preview"
        }
        //4
        if (jogador1_sorteio == 4) {
            jogador1_dado = "https://openclipart.org/image/800px/96097"
        }
        if (jogador2_sorteio == 4) {
            jogador2_dado = "https://openclipart.org/image/800px/96097"
        }
        //5
        if (jogador1_sorteio == 5) {
            jogador1_dado = "http://www.i2clipart.com/cliparts/2/3/3/b/clipart-dado-5-256x256-233b.png"
        }
        if (jogador2_sorteio == 5) {
            jogador2_dado = "http://www.i2clipart.com/cliparts/2/3/3/b/clipart-dado-5-256x256-233b.png"
        }
        //6
        if (jogador1_sorteio == 6) {
            jogador1_dado = "https://png.vector.me/files/images/3/2/323082/dado_6_preview"
        }
        if (jogador2_sorteio == 6) {
            jogador2_dado = "https://png.vector.me/files/images/3/2/323082/dado_6_preview"
        }


        img_jogador1.src = jogador1_dado;
        img_jogador2.src = jogador2_dado;

        if (jogador1_sorteio > jogador2_sorteio) {
            v1++;
            div_jogador1.classList.add('waviy');

        } else if (jogador2_sorteio > jogador1_sorteio) {
            v2++;
            div_jogador2.classList.add('waviy');
        } else {
            empate++;
        }
        spn_v1.innerHTML = v1;
        spn_v2.innerHTML = v2;
        spn_empate.innerHTML = empate;
        setTimeout(function () {

            div_jogador1.classList.remove('waviy');
            div_jogador2.classList.remove('waviy');
    }, 700);

        setTimeout(function () {

            img_jogador1.classList.remove('girarRapido');
            img_jogador2.classList.remove('girarRapido');
            img_jogador1.classList.remove('girarLento');
            img_jogador2.classList.remove('girarLento');
            btn_jogar.disabled = false;


        }, 600);

    }, 600);

}
