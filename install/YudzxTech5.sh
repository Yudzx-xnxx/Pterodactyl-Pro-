#!/bin/bash

REMOTE_PATH="/var/www/pterodactyl/app/Http/Controllers/Admin/Nests/NestController.php"
TIMESTAMP=$(date -u +"%Y-%m-%d-%H-%M-%S")

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐  INSTALL PROTECT NESTS PANEL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📌 Fitur: Anti akses menu Nests kecuali admin ID 1"
echo "📂 File Target: $REMOTE_PATH"
echo ""

# Pastikan folder tujuan ada
mkdir -p "$(dirname "$REMOTE_PATH")"
chmod 755 "$(dirname "$REMOTE_PATH")"

# Tulis ulang file baru
cat > "$REMOTE_PATH" <<'EOF'
<?php

namespace Pterodactyl\Http\Controllers\Admin\Nests;

use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Prologue\Alerts\AlertsMessageBag;
use Illuminate\View\Factory as ViewFactory;
use Pterodactyl\Http\Controllers\Controller;
use Pterodactyl\Services\Nests\NestUpdateService;
use Pterodactyl\Services\Nests\NestCreationService;
use Pterodactyl\Services\Nests\NestDeletionService;
use Pterodactyl\Contracts\Repository\NestRepositoryInterface;
use Pterodactyl\Http\Requests\Admin\Nest\StoreNestFormRequest;
use Illuminate\Support\Facades\Auth;

class NestController extends Controller
{
    /**
     * NestController constructor.
     */
    public function __construct(
        protected AlertsMessageBag $alert,
        protected NestCreationService $nestCreationService,
        protected NestDeletionService $nestDeletionService,
        protected NestRepositoryInterface $repository,
        protected NestUpdateService $nestUpdateService,
        protected ViewFactory $view
    ) {
    }

    /**
     * Render nest listing page.
     */
    public function index(): View
    {
        // 🔒 Proteksi: hanya admin ID 1 dapat akses menu Nest
        $user = Auth::user();
        if (!$user || $user->id !== 1) {
            abort(403, 'YudzxTech Protect t.me/Yudzxcysec - Akses Nests ditolak ❌');
        }

        return $this->view->make('admin.nests.index', [
            'nests' => $this->repository->getWithCounts(),
        ]);
    }

    /**
     * Render nest creation page.
     */
    public function create(): View
    {
        return $this->view->make('admin.nests.new');
    }

    /**
     * Store a new nest.
     */
    public function store(StoreNestFormRequest $request): RedirectResponse
    {
        $nest = $this->nestCreationService->handle($request->normalize());
        $this->alert->success(
            trans('admin/nests.notices.created', ['name' => htmlspecialchars($nest->name)])
        )->flash();

        return redirect()->route('admin.nests.view', $nest->id);
    }

    /**
     * Show a Nest with eggs and server counts.
     */
    public function view(int $nest): View
    {
        return $this->view->make('admin.nests.view', [
            'nest' => $this->repository->getWithEggServers($nest),
        ]);
    }

    /**
     * Update an existing nest.
     */
    public function update(StoreNestFormRequest $request, int $nest): RedirectResponse
    {
        $this->nestUpdateService->handle($nest, $request->normalize());
        $this->alert->success(trans('admin/nests.notices.updated'))->flash();

        return redirect()->route('admin.nests.view', $nest);
    }

    /**
     * Delete a nest.
     */
    public function destroy(int $nest): RedirectResponse
    {
        $this->nestDeletionService->handle($nest);
        $this->alert->success(trans('admin/nests.notices.deleted'))->flash();

        return redirect()->route('admin.nests');
    }
}

EOF

# Atur permission file
chmod 644 "$REMOTE_PATH"

echo ""
echo "✅ Proteksi Nests berhasil dipasang!"
echo "🔒 Brand: YudzxTech"
echo "🔗 Support: t.me/Yudzxcysec"
echo "📂 Lokasi file: $REMOTE_PATH"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"