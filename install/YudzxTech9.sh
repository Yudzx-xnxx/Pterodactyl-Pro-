#!/bin/bash

# ============================================================
#  Pterodactyl - Protect Server Details Modification
#  Author  : FyzzOfficial
#  Version : 1.0
#  Feature : Hanya user ID 1 yang dapat modifikasi detail server
# ============================================================

REMOTE_PATH="/var/www/pterodactyl/app/Services/Servers/DetailsModificationService.php"
TIMESTAMP=$(date -u +"%Y-%m-%d-%H-%M-%S")

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 Memasang Proteksi Anti Modifikasi Detail Server..."
echo "📌 File: $REMOTE_PATH"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Pastikan folder tujuan ada
mkdir -p "$(dirname "$REMOTE_PATH")"
chmod 755 "$(dirname "$REMOTE_PATH")"

# Tulis isi file baru
cat > "$REMOTE_PATH" <<'EOF'
<?php

namespace Pterodactyl\Services\Servers;

use Illuminate\Support\Arr;
use Pterodactyl\Models\Server;
use Illuminate\Database\ConnectionInterface;
use Pterodactyl\Traits\Services\ReturnsUpdatedModels;
use Pterodactyl\Repositories\Wings\DaemonServerRepository;
use Pterodactyl\Exceptions\Http\Connection\DaemonConnectionException;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

class DetailsModificationService
{
    use ReturnsUpdatedModels;

    public function __construct(
        private ConnectionInterface $connection,
        private DaemonServerRepository $serverRepository
    ) {}

    /**
     * Update the details for a single server instance.
     *
     * @throws \Throwable
     */
    public function handle(Server $server, array $data): Server
    {
        // ============================================
        // 🔒 Proteksi: Hanya user ID 1 yang boleh ubah
        // ============================================
        $user = auth()->user();
        if (!$user || $user->id !== 1) {
            throw new AccessDeniedHttpException(
                '❌ Kamu tidak diizinkan mengubah detail server ini - Protect By t.me/Yudzxcysec © YudzxTech.'
            );
        }

        return $this->connection->transaction(function () use ($data, $server) {
            $owner = $server->owner_id;

            $server->forceFill([
                'external_id' => Arr::get($data, 'external_id'),
                'owner_id' => Arr::get($data, 'owner_id'),
                'name' => Arr::get($data, 'name'),
                'description' => Arr::get($data, 'description') ?? '',
            ])->saveOrFail();

            // Revoke token jika owner berubah
            if ($server->owner_id !== $owner) {
                try {
                    $this->serverRepository->setServer($server)->revokeUserJTI($owner);
                } catch (DaemonConnectionException $exception) {
                    // Abaikan jika gagal koneksi ke Wings
                }
            }

            return $server;
        });
    }
}

EOF

# Atur permission file
chmod 644 "$REMOTE_PATH"

echo "✅ Proteksi Anti Modifikasi Detail Server berhasil dipasang!"
echo "📂 Lokasi file: $REMOTE_PATH"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"