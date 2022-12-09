function menu() {
    document.getElementsByClassName("perguntas")[0].classList.toggle("opened");
}


function verificar() {

    var a = [];
    var b = [];
    var c = [];
    var d = [];
    var e = [];
    var f = [];
    var g = [];
    var h = [];
    var i = [];
    var j = [];
    var k = [];
    var l = [];
    var m = [];
    var n = [];
    var o = [];
    var p = [];
    var q = [];
    var r = [];
    var s = [];
    var t = [];

    for (var contador = 0; contador < 20; contador++) {
        a.push(document.getElementsByClassName("row")[0].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        b.push(document.getElementsByClassName("row")[1].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        c.push(document.getElementsByClassName("row")[2].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        d.push(document.getElementsByClassName("row")[3].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        e.push(document.getElementsByClassName("row")[4].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        f.push(document.getElementsByClassName("row")[5].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        g.push(document.getElementsByClassName("row")[6].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        h.push(document.getElementsByClassName("row")[7].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        i.push(document.getElementsByClassName("row")[8].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        j.push(document.getElementsByClassName("row")[9].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        k.push(document.getElementsByClassName("row")[10].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        l.push(document.getElementsByClassName("row")[11].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        m.push(document.getElementsByClassName("row")[12].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        n.push(document.getElementsByClassName("row")[13].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        o.push(document.getElementsByClassName("row")[14].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        p.push(document.getElementsByClassName("row")[15].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        q.push(document.getElementsByClassName("row")[16].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        r.push(document.getElementsByClassName("row")[17].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        s.push(document.getElementsByClassName("row")[18].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
        t.push(document.getElementsByClassName("row")[19].getElementsByClassName("column")[contador].getElementsByTagName("input")[0].value);
    }

    let registradores = a[3] + b[3] + c[3] + d[3] + e[3] + f[3] + g[3] + h[3] + i[3] + j[3] + k[3] + l[3] + m[3] == 'registradores';
    let i5 = d[3] + d[4] == 'i5';
    let adress_bus = g[1] + g[2] + g[3] + g[4] + g[5] + g[6] + g[7] + g[8] + g[9] + g[10] == 'adress-bus'
    let data_bus = h[0] + h[1] + h[2] + h[3] + h[4] + h[5] + h[6] + h[7] == 'data-bus';
    let dual_core = h[0] + i[0] + j[0] + k[0] + l[0] + m[0] + n[0] + o[0] + p[0] == 'dual-core';
    let cpu = m[0] + m[1] + m[2] == 'cpu';
    let quad_core = l[2] + m[2] + n[2] + o[2] + p[2] + q[2] + r[2] + s[2] + t[2] == 'quad-core';
    let dma = q[3] + r[3] + s[3] == 'dma';
    let eprom = n[5] + o[5] + p[5] + q[5] + r[5] == 'eprom';
    let rom = p[5] + p[6] + p[7] == 'rom';
    let ram = s[2] + s[3] + s[4] == 'ram';
    let memoria_de_massa = r[3] + r[4] + r[5] + r[6] + r[7] + r[8] + r[9] + r[10] + r[11] + r[12] + r[13] + r[14] + r[15] + r[16] + r[17] + r[18] == 'memoria-de-massa'
    let i7 = r[8] + s[8] == 'i7';
    let flash = p[18] + q[18] + r[18] + s[18] + t[18] == 'flash';
    let ula = q[17] + q[18] + q[19] == 'ula';
    let cs = s[17] + s[18] == 'cs';

    console.log(cpu);
    console.log(ula);
    console.log(registradores);
    console.log(ram);
    console.log(rom);
    console.log(eprom);
    console.log(flash);
    console.log(memoria_de_massa);
    console.log(dma);
    console.log(cs);
    console.log(adress_bus);
    console.log(data_bus);
    console.log(i5);
    console.log(i7);
    console.log(dual_core);
    console.log(quad_core);

    var check = document.getElementsByClassName('check');

    for (var cont = 0; cont < 16; cont++) {
        check[cont].children[0].src = './close.png';
    }

    if (cpu) { check[0].children[0].src = './accept.png'; }
    if (ula) { check[1].children[0].src = './accept.png'; }
    if (registradores) { check[2].children[0].src = './accept.png'; }
    if (ram) { check[3].children[0].src = './accept.png'; }
    if (rom) { check[4].children[0].src = './accept.png'; }
    if (eprom) { check[5].children[0].src = './accept.png'; }
    if (flash) { check[6].children[0].src = './accept.png'; }
    if (memoria_de_massa) { check[7].children[0].src = './accept.png'; }
    if (dma) { check[8].children[0].src = './accept.png'; }
    if (cs) { check[9].children[0].src = './accept.png'; }
    if (adress_bus) { check[10].children[0].src = './accept.png'; }
    if (data_bus) { check[11].children[0].src = './accept.png'; }
    if (i5) { check[12].children[0].src = './accept.png'; }
    if (i7) { check[13].children[0].src = './accept.png'; }
    if (dual_core) { check[14].children[0].src = './accept.png'; }
    if (quad_core) { check[15].children[0].src = './accept.png'; }

    menu();
}