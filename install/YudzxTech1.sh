#!/bin/bash

# ============================================================
#   PTERODACTYL PROTECT – ANTI DELETE SERVER (OWNER ONLY)
#   By Yudzx – Enhanced & Optimized Version
# ============================================================

RESET="\e[0m"
GREEN="\e[92m"
YELLOW="\e[93m"
RED="\e[91m"
BLUE="\e[94m"

REMOTE_PATH="/var/www/pterodactyl/app/Services/Servers/ServerDeletionService.php"
BACKUP_PATH="/var/www/pterodactyl/app/Services/Servers/ServerDeletionService.php.backup-$(date -u +"%Y%m%d-%H%M%S")"

echo -e "${BLUE}🚀 Memasang proteksi Anti Delete Server...${RESET}"
sleep 1

# ============================================================
# CEK FILE EXIST
# ============================================================
if [ ! -f "$REMOTE_PATH" ]; then
    echo -e "${RED}❌ File asli tidak ditemukan:${RESET} $REMOTE_PATH"
    echo -e "${YELLOW}⚠ Pastikan path panel kamu benar.${RESET}"
    exit 1
fi

# ============================================================
# BACKUP OTOMATIS
# ============================================================
echo -e "${YELLOW}📦 Membuat backup file original...${RESET}"

cp "$REMOTE_PATH" "$BACKUP_PATH"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Gagal membuat backup. Proteksi dibatalkan.${RESET}"
    exit 1
fi

echo -e "${GREEN}✅ Backup tersimpan:${RESET} $BACKUP_PATH"
sleep 1

# ============================================================
# TULIS ULANG FILE SECURE VERSION
# ============================================================
echo -e "${BLUE}✍ Menulis ulang ServerDeletionService.php dengan versi aman...${RESET}"
sleep 1

cat > "$REMOTE_PATH" <<'EOF'
<?php

namespace Pterodactyl\Services\Servers;

use Illuminate\Support\Facades\Auth;
use Pterodactyl\Exceptions\DisplayException;
use Illuminate\Http\Response;
use Pterodactyl\Models\Server;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\ConnectionInterface;
use Pterodactyl\Repositories\Wings\DaemonServerRepository;
use Pterodactyl\Services\Databases\DatabaseManagementService;
use Pterodactyl\Exceptions\Http\Connection\DaemonConnectionException;

class ServerDeletionService
{
    protected bool $force = false;

    public function __construct(
        private ConnectionInterface $connection,
        private DaemonServerRepository $daemonServerRepository,
        private DatabaseManagementService $databaseManagementService
    ) {}

    public function withForce(bool $bool = true): self
    {
        $this->force = $bool;
        return $this;
    }

    /**
     * Delete a server from the panel with restricted permissions.
     *
     * @throws \Throwable
     * @throws \Pterodactyl\Exceptions\DisplayException
     */
    public function handle(Server $server): void
    {
        $user = Auth::user();

        // 🛡 Proteksi: hanya user ID 1 (superadmin) yang bisa hapus server siapa saja.
        if ($user && $user->id !== 1) {
            $ownerId = $server->owner_id
                ?? $server->user_id
                ?? ($server->owner?->id ?? null)
                ?? ($server->user?->id ?? null);

            if ($ownerId === null) {
                throw new DisplayException('Akses ditolak: informasi pemilik server tidak tersedia.');
            }

            if ($ownerId !== $user->id) {
                throw new DisplayException('Akses ditolak: Anda hanya dapat menghapus server milik Anda sendiri (Protected by Yudzx).');
            }
        }

        try {
            $this->daemonServerRepository->setServer($server)->delete();
        } catch (DaemonConnectionException $exception) {
            if (!$this->force && $exception->getStatusCode() !== Response::HTTP_NOT_FOUND) {
                throw $exception;
            }

            Log::warning($exception);
        }

        $this->connection->transaction(function () use ($server) {
            foreach ($server->databases as $database) {
                try {
                    $this->databaseManagementService->delete($database);
                } catch (\Exception $exception) {
                    if (!$this->force) {
                        throw $exception;
                    }

                    $database->delete();
                    Log::warning($exception);
                }
            }

            $server->delete();
        });
    }
}

EOF

# ============================================================
# PERMISSION SETTING
# ============================================================
chmod 644 "$REMOTE_PATH"

echo -e "${GREEN}✅ Proteksi berhasil dipasang!${RESET}"
echo -e "${BLUE}📂 Lokasi file:${RESET} $REMOTE_PATH"
echo -e "${GREEN}💾 Backup file original:${RESET} $BACKUP_PATH"
echo -e "${YELLOW}🔐 ServerDeletionService sekarang aman dari delete sembarangan.${RESET}"