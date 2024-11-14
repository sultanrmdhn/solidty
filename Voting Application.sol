// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingApp {
    // Alamat admin
    address public admin;

    // Enum untuk mendefinisikan fase pemilihan
    enum FasePemilihan { BelumDimulai, Dibuka, Ditutup }
    FasePemilihan public fasePemilihan;

    // Struktur untuk menyimpan detail kandidat
    struct Kandidat {
        uint id;
        string nama;
        uint jumlahSuara;
    }

    // Struktur untuk menyimpan detail pemilih
    struct Pemilih {
        bool sudahMemilih;
        uint idKandidat;
    }

    // Mapping untuk kandidat dan pemilih
    mapping(uint => Kandidat) public kandidat;
    mapping(address => Pemilih) public pemilih;

    // Jumlah kandidat
    uint public jumlahKandidat;

    // Events untuk pencatatan
    event KandidatDitambahkan(uint indexed idKandidat, string nama);
    event PemilihDitambahkan(address indexed pemilih);
    event SuaraDiberikan(address indexed pemilih, uint indexed idKandidat);
    event PemilihanDibuka();
    event PemilihanDitutup();

    // Modifiers untuk mengatur akses fungsi
    modifier hanyaAdmin() {
        require(msg.sender == admin, "Hanya admin yang bisa melakukan aksi ini.");
        _;
    }

    modifier hanyaPemilih() {
        require(!pemilih[msg.sender].sudahMemilih, "Hanya pemilih yang belum memberikan suara.");
        _;
    }

    modifier hanyaSaatVoting() {
        require(fasePemilihan == FasePemilihan.Dibuka, "Pemilihan belum dibuka.");
        _;
    }

    modifier hanyaSekali() {
        require(!pemilih[msg.sender].sudahMemilih, "Anda hanya bisa memberikan suara sekali.");
        _;
    }

    // Konstruktor untuk menetapkan admin dan fase pemilihan awal
    constructor() {
        admin = msg.sender;
        fasePemilihan = FasePemilihan.BelumDimulai;
    }

    // Fungsi untuk menambahkan kandidat (hanya oleh admin)
    function tambahKandidat(string memory _nama) public hanyaAdmin {
        jumlahKandidat++;
        kandidat[jumlahKandidat] = Kandidat(jumlahKandidat, _nama, 0);
        emit KandidatDitambahkan(jumlahKandidat, _nama);
    }

    // Fungsi untuk menambahkan pemilih (hanya oleh admin)
    function tambahPemilih(address _pemilih) public hanyaAdmin {
        require(!pemilih[_pemilih].sudahMemilih, "Pemilih sudah terdaftar.");
        pemilih[_pemilih] = Pemilih(false, 0);
        emit PemilihDitambahkan(_pemilih);
    }

    // Fungsi untuk membuka pemilihan (hanya oleh admin)
    function bukaPemilihan() public hanyaAdmin {
        require(fasePemilihan == FasePemilihan.BelumDimulai, "Pemilihan sudah dimulai.");
        fasePemilihan = FasePemilihan.Dibuka;
        emit PemilihanDibuka();
    }

    // Fungsi untuk menutup pemilihan (hanya oleh admin)
    function tutupPemilihan() public hanyaAdmin {
        require(fasePemilihan == FasePemilihan.Dibuka, "Pemilihan tidak sedang berlangsung.");
        fasePemilihan = FasePemilihan.Ditutup;
        emit PemilihanDitutup();
    }

    // Fungsi untuk memberikan suara (hanya untuk pemilih terdaftar dan selama fase voting)
    function beriSuara(uint _idKandidat) public hanyaPemilih hanyaSaatVoting hanyaSekali {
        require(_idKandidat > 0 && _idKandidat <= jumlahKandidat, "ID kandidat tidak valid.");
        
        // Mencatat suara pemilih
        pemilih[msg.sender].sudahMemilih = true;
        pemilih[msg.sender].idKandidat = _idKandidat;
        
        // Meningkatkan jumlah suara kandidat yang dipilih
        kandidat[_idKandidat].jumlahSuara++;

        emit SuaraDiberikan(msg.sender, _idKandidat);
    }

    // Fungsi untuk melihat jumlah suara dari kandidat tertentu
    function lihatJumlahSuara(uint _idKandidat) public view returns (uint) {
        require(_idKandidat > 0 && _idKandidat <= jumlahKandidat, "ID kandidat tidak valid.");
        return kandidat[_idKandidat].jumlahSuara;
    }

    // Fungsi untuk melihat status pemilihan saat ini
    function lihatStatusPemilihan() public view returns (FasePemilihan) {
        return fasePemilihan;
    }
}
