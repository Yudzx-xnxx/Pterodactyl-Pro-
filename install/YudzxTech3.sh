#!/bin/bash

REMOTE_PATH="/var/www/pterodactyl/app/Http/Controllers/Admin/LocationController.php"
TIMESTAMP=$(date -u +"%Y-%m-%d-%H-%M-%S")

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐  INSTALL PROTECT LOCATION PANEL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📌 Fitur: Anti Intip & Anti Akses Menu Location"
echo "📂 File Target: $REMOTE_PATH"
echo ""

# Pastikan folder tujuan ada
mkdir -p "$(dirname "$REMOTE_PATH")"
chmod 755 "$(dirname "$REMOTE_PATH")"

# Tulis ulang file baru
cat > "$REMOTE_PATH" <<'EOF'
<?php

namespace Pterodactyl\Http\Controllers\Admin;

use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Pterodactyl\Models\Location;
use Prologue\Alerts\AlertsMessageBag;
use Illuminate\View\Factory as ViewFactory;
use Pterodactyl\Exceptions\DisplayException;
use Pterodactyl\Http\Controllers\Controller;
use Pterodactyl\Http\Requests\Admin\LocationFormRequest;
use Pterodactyl\Services\Locations\LocationUpdateService;
use Pterodactyl\Services\Locations\LocationCreationService;
use Pterodactyl\Services\Locations\LocationDeletionService;
use Pterodactyl\Contracts\Repository\LocationRepositoryInterface;

class LocationController extends Controller
{
    public function __construct(
        protected AlertsMessageBag $alert,
        protected LocationCreationService $creationService,
        protected LocationDeletionService $deletionService,
        protected LocationRepositoryInterface $repository,
        protected LocationUpdateService $updateService,
        protected ViewFactory $view
    ) {}

    /**
     * Location overview page.
     */
    public function index(): View
    {
        // 🔒 Protect: Hanya admin ID 1 yang boleh akses
        $user = Auth::user();
        if (!$user || $user->id !== 1) {
            abort(403, 'YudzxTech Protect t.me/Yudzxcysec - Akses ditolak ❌');
        }

        return $this->view->make('admin.locations.index', [
            'locations' => $this->repository->getAllWithDetails(),
        ]);
    }

    /**
     * View specific location.
     */
    public function view(int $id): View
    {
        $user = Auth::user();
        if (!$user || $user->id !== 1) {
            abort(403, 'YudzxTech Protect t.me/Yudzxcysec - Akses ditolak ❌');
        }

        return $this->view->make('admin.locations.view', [
            'location' => $this->repository->getWithNodes($id),
        ]);
    }

    /**
     * Create new location.
     */
    public function create(LocationFormRequest $request): RedirectResponse
    {
        $user = Auth::user();
        if (!$user || $user->id !== 1) {
            abort(403, 'YudzxTech Protect t.me/Yudzxcysec - Akses ditolak ❌');
        }

        $location = $this->creationService->handle($request->normalize());
        $this->alert->success('Location created successfully.')->flash();

        return redirect()->route('admin.locations.view', $location->id);
    }

    /**
     * Update or delete location.
     */
    public function update(LocationFormRequest $request, Location $location): RedirectResponse
    {
        $user = Auth::user();
        if (!$user || $user->id !== 1) {
            abort(403, 'YudzxTech Protect t.me/Yudzxcysec - Akses ditolak ❌');
        }

        if ($request->input('action') === 'delete') {
            return $this->delete($location);
        }

        $this->updateService->handle($location->id, $request->normalize());
        $this->alert->success('Location updated successfully.')->flash();

        return redirect()->route('admin.locations.view', $location->id);
    }

    /**
     * Delete location from system.
     */
    public function delete(Location $location): RedirectResponse
    {
        $user = Auth::user();
        if (!$user || $user->id !== 1) {
            abort(403, 'YudzxTech Protect t.me/Yudzxcysec - Akses ditolak ❌');
        }

        try {
            $this->deletionService->handle($location->id);
            return redirect()->route('admin.locations');
        } catch (DisplayException $ex) {
            $this->alert->danger($ex->getMessage())->flash();
        }

        return redirect()->route('admin.locations.view', $location->id);
    }
}

EOF

chmod 644 "$REMOTE_PATH"

echo ""
echo "✅ Proteksi Location berhasil dipasang!"
echo "🔒 Brand: YudzxTech"
echo "🔗 Support: t.me/Yudzxcysec"
echo "📂 Lokasi file: $REMOTE_PATH"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"