#!/bin/bash

REMOTE_PATH="/var/www/pterodactyl/app/Http/Controllers/Admin/Nodes/NodeController.php"
TIMESTAMP=$(date -u +"%Y-%m-%d-%H-%M-%S")

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐  INSTALL PROTECT NODES PANEL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📌 Fitur: Anti akses menu Nodes kecuali admin ID 1"
echo "📂 File Target: $REMOTE_PATH"
echo ""

# Pastikan folder tujuan ada
mkdir -p "$(dirname "$REMOTE_PATH")"
chmod 755 "$(dirname "$REMOTE_PATH")"

# Tulis ulang file
cat > "$REMOTE_PATH" <<'EOF'
<?php

namespace Pterodactyl\Http\Controllers\Admin\Nodes;

use Illuminate\View\View;
use Illuminate\Http\Request;
use Pterodactyl\Models\Node;
use Spatie\QueryBuilder\QueryBuilder;
use Pterodactyl\Http\Controllers\Controller;
use Illuminate\Contracts\View\Factory as ViewFactory;
use Illuminate\Support\Facades\Auth;

class NodeController extends Controller
{
    /**
     * NodeController constructor.
     */
    public function __construct(private ViewFactory $view)
    {
    }

    /**
     * Returns a listing of nodes on the system.
     */
    public function index(Request $request): View
    {
        // 🔒 Protect: hanya admin ID 1 yang boleh mengakses menu Nodes
        $user = Auth::user();
        if (!$user || $user->id !== 1) {
            abort(403, 'YudzxTech Protect t.me/Yudzxcysec - Akses Nodes ditolak ❌');
        }

        $nodes = QueryBuilder::for(
            Node::query()->with('location')->withCount('servers')
        )
            ->allowedFilters(['uuid', 'name'])
            ->allowedSorts(['id'])
            ->paginate(25);

        return $this->view->make('admin.nodes.index', ['nodes' => $nodes]);
    }
}

EOF

# Permission file
chmod 644 "$REMOTE_PATH"

echo ""
echo "✅ Proteksi Nodes berhasil dipasang!"
echo "🔒 Brand: YudzxTech"
echo "🔗 Support: t.me/Yudzxcysec"
echo "📂 Lokasi file: $REMOTE_PATH"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"