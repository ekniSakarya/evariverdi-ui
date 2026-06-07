export default function Home() {
  return (
    <div
      className="min-h-screen w-full flex items-center justify-center bg-cover bg-center bg-no-repeat"
      style={{ backgroundImage: "url('/vox-main.jpg')" }}
    >
      {/* Koyu overlay - görsel üzerine yarı saydam siyah katman */}
      <div className="absolute inset-0 bg-black/40" />
      {/* VOX yazısı - görselin üzerinde görünecek */}
      <h1 className="relative z-10 text-white text-9xl font-bold tracking-wider font-playfair drop-shadow-2xl">
        work in progress
      </h1>
    </div>
  );
}