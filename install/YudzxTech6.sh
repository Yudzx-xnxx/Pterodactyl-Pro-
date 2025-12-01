#!/bin/bash

REMOTE_PATH="/var/www/pterodactyl/app/Http/Controllers/Admin/Settings/IndexController.php"
TIMESTAMP=$(date -u +"%Y-%m-%d-%H-%M-%S")

echo "🚀 Memasang Proteksi Anti Akses Settings..."

# Pastikan folder tujuan ada
mkdir -p "$(dirname "$REMOTE_PATH")"
chmod 755 "$(dirname "$REMOTE_PATH")"

# Tulis ulang file
cat > "$REMOTE_PATH" <<'EOF'
<?php

namespace Pterodactyl\Http\Controllers\Admin\Settings;

use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Prologue\Alerts\AlertsMessageBag;
use Illuminate\Contracts\Console\Kernel;
use Illuminate\View\Factory as ViewFactory;
use Pterodactyl\Http\Controllers\Controller;
use Pterodactyl\Traits\Helpers\AvailableLanguages;
use Pterodactyl\Services\Helpers\SoftwareVersionService;
use Pterodactyl\Contracts\Repository\SettingsRepositoryInterface;
use Pterodactyl\Http\Requests\Admin\Settings\BaseSettingsFormRequest;

class IndexController extends Controller
{
    use AvailableLanguages;

    public function __construct(
        private AlertsMessageBag $alert,
        private Kernel $kernel,
        private SettingsRepositoryInterface $settings,
        private SoftwareVersionService $versionService,
        private ViewFactory $view
    ) {}

    /**
     * Render Settings Page
     */
    public function index(): View
    {
        // 🔒 Proteksi: hanya user ID 1 (superadmin)
        $user = Auth::user();
        if (!$user || $user->id !== 1) {
            abort(403, '🚫 Akses ditolak! Hanya admin utama (ID 1) yang bisa membuka menu Settings. ©Protect By FyzzOfficial');
        }

        return $this->view->make('admin.settings.index', [
            'version' => $this->versionService,
            'languages' => $this->getAvailableLanguages(true),
        ]);
    }

    /**
     * Handle update settings
     */
    public function update(BaseSettingsFormRequest $request): RedirectResponse
    {
        // 🔒 Proteksi: hanya ID 1 yang boleh update
        $user = Auth::user();
        if (!$user || $user->id !== 1) {
            abort(403, '🚫 Akses ditolak! Hanya admin utama yang boleh mengubah Settings. ©Protect By FyzzOfficial');
        }

        foreach ($request->normalize() as $key => $value) {
            $this->settings->set('settings::' . $key, $value);
        }

        // Restart queue worker
        $this->kernel->call('queue:restart');

        $this->alert->success(
            'Settings berhasil diperbarui. Worker queue telah direstart untuk menerapkan perubahan.'
        )->flash();

        return redirect()->route('admin.settings');
    }
}

EOF

# Atur permission
chmod 644 "$REMOTE_PATH"

echo "✅ Proteksi Settings berhasil dipasang!"
echo "📂 Lokasi file: $REMOTE_PATH"