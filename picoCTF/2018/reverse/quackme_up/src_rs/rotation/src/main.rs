use std::string::String;

fn decrypt(buf: &[u8]) -> Vec<u8> {
    let mut out : Vec<u8> = Vec::new();
    for x in buf.iter() {
        let y = x.rotate_left(8) ^ 0x16;
        let z = y.rotate_right(4);
        out.push(z);
    }

    out
}

fn main() {
    let enc_flag = b"\x11\x80\x20\xe0\x22\x53\x72\xa1\x01\x41\x55\x20\xa0\xc0\x25\xe3\x35\x40\x55\x30\x85\x55\x70\x20\xc1";

    let rs : Vec<u8> = decrypt(enc_flag);

    let rs = String::from_utf8(rs).unwrap();

    println!("{}", rs);
}
