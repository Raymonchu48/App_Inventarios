const STORAGE_KEY = "inventario.supabase.config.v2";

const state = {
  client: null,
  session: null,
  user: null,
  profile: null,
  categorias: [],
  productos: [],
  movimientos: [],
  perfiles: []
};

const els = {};
let deferredInstallPrompt = null;
let globalSearchSelectionIndex = -1;
let globalSearchCurrentResults = [];

async function hardResetClientCaches() {
  try {
    if ("serviceWorker" in navigator) {
      const registrations = await navigator.serviceWorker.getRegistrations();
      for (const reg of registrations) {
        await reg.unregister();
      }
    }

    if ("caches" in window) {
      const keys = await caches.keys();
      for (const key of keys) {
        await caches.delete(key);
      }
    }
  } catch (error) {
    console.error("No pude limpiar service workers/cachés:", error);
  }
}

window.addEventListener("DOMContentLoaded", init);

async function init() {
  captureEls();
  bindUI();
  loadSavedConfigToForms();
  await initSupabaseFromConfig();
}

function captureEls() {
  [
    "authShell", "appShell", "authStatus",
    "loginForm", "registerForm", "configAuthForm", "configForm",
    "authSupabaseUrl", "authSupabaseKey", "supabaseUrl", "supabaseKey",
    "btnAuthTestConnection", "btnAuthClearConfig",
    "btnTestConnection2", "btnClearConfig", "btnOpenSetup",
    "btnLogout", "btnBootstrapAdmin", "btnRefresh", "btnSeed", "btnImportMenajes",
    "btnSidebarToggle", "sidebar", "sidebarOverlay", "btnInstallApp",
    "userName", "userEmail", "roleBadge", "activeBadge", "connectionBadge", "connectionText",
    "viewTitle", "viewSubtitle", "globalSearchInput", "globalSearchResults","cfgPreviewUrl", "cfgPreviewSession", "cfgPreviewRole",
    "cfgPreviewSessionConfig", "cfgPreviewRoleConfig",
    "navAdmin", "usersList",
    "kpiProductos", "kpiStock", "kpiBajoMinimo", "kpiSinStock", "criticalList", "recentMoves",
    "kpiBebidas","kpiMenajes","kpiVarios",
    "kpiMovimientosTotal","kpiOperationalStatus","kpiCriticalCount","kpiRecentMoves",
    "familyCountBebidas","familyCountMenajes","familyCountVarios","executiveSummary",
    "searchInput", "categoryFilter", "stockFilter", "btnNewProduct", "productsTable",
    "menajesSearchInput", "menajesCategoryFilter", "btnNewMenaje", "menajesTable",
    "variosSearchInput", "variosCategoryFilter", "btnNewVarios", "variosTable",
    "btnPrintBebidas","btnPrintMenajes","btnPrintVarios","btnPrintFullInventory",
    "movementReason","movementEvent","movementFilterType","movementFilterText",
    "movementForm", "movementProduct", "movementType", "movementQty", "movementNote", "movementHistory",
    "productDialog", "productForm", "productDialogTitle", "btnCloseDialog", "productId",
    "pStockCode", "pDescripcion", "pPresentacion", "pStDate", "pUnit", "pCantidad",
    "pMinStock", "pPagina", "pFamilia", "pCategoria", "pCantidadOriginal", "pDetalleCantidad",
    "sectionTopBanner","sectionTopBannerEyebrow","sectionTopBannerTitle","sectionTopBannerText"
  ].forEach(id => {
    els[id] = document.getElementById(id);
  });
}

function bindUI() {
  document.querySelectorAll(".nav-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      switchView(btn.dataset.view);
      closeSidebarMobile();
    });
  });

  document.querySelectorAll("[data-auth-tab]").forEach(btn => {
    btn.addEventListener("click", () => switchAuthTab(btn.dataset.authTab));
  });

  els.loginForm?.addEventListener("submit", onLogin);
  els.registerForm?.addEventListener("submit", onRegister);

  els.configAuthForm?.addEventListener("submit", onSaveConfigFromAuth);
  els.configForm?.addEventListener("submit", onSaveConfigFromPanel);

  els.btnAuthTestConnection?.addEventListener("click", onTestConnectionFromAuth);
  els.btnAuthClearConfig?.addEventListener("click", clearConfig);
  els.btnTestConnection2?.addEventListener("click", onTestConnectionFromPanel);
  els.btnClearConfig?.addEventListener("click", clearConfig);
  els.btnPrintBebidas?.addEventListener("click", () => printInventorySheet("bebidas"));
  els.btnPrintMenajes?.addEventListener("click", () => printInventorySheet("menaje"));
  els.btnPrintVarios?.addEventListener("click", () => printInventorySheet("varios"));
  els.btnPrintFullInventory?.addEventListener("click", printFullInventoryByFamily);

  els.btnOpenSetup?.addEventListener("click", () => {
    showAuth("Editar conexión de Supabase");
    switchAuthTab("setup");
  });

  els.btnLogout?.addEventListener("click", onLogout);
  els.btnBootstrapAdmin?.addEventListener("click", onBootstrapAdmin);
  els.btnRefresh?.addEventListener("click", refreshAll);
  els.btnSeed?.addEventListener("click", importInitialData);
  els.btnImportMenajes?.addEventListener("click", importMenajesData);

  els.btnSidebarToggle?.addEventListener("click", toggleSidebarMobile);
  els.sidebarOverlay?.addEventListener("click", closeSidebarMobile);
  els.btnInstallApp?.addEventListener("click", installApp);

  [els.searchInput, els.categoryFilter, els.stockFilter].forEach(el => {
    el?.addEventListener("input", renderProducts);
    el?.addEventListener("change", renderProducts);
  });

  [els.menajesSearchInput, els.menajesCategoryFilter].forEach(el => {
    el?.addEventListener("input", renderMenajes);
    el?.addEventListener("change", renderMenajes);
  });

  [els.variosSearchInput, els.variosCategoryFilter].forEach(el => {
    el?.addEventListener("input", renderVarios);
    el?.addEventListener("change", renderVarios);
  });

  [els.movementFilterType, els.movementFilterText].forEach(el => {
  el?.addEventListener("input", renderMovementHistory);
  el?.addEventListener("change", renderMovementHistory);
});

  els.btnNewProduct?.addEventListener("click", openNewProductDialog);
  els.btnNewMenaje?.addEventListener("click", openNewMenajeDialog);
  els.btnNewVarios?.addEventListener("click", openNewVariosDialog);

  els.btnCloseDialog?.addEventListener("click", closeProductDialog);
  els.productForm?.addEventListener("submit", onSaveProduct);
  els.movementForm?.addEventListener("submit", onSaveMovement);

  els.pFamilia?.addEventListener("change", syncCategoryByFamily);
  els.btnPrintFullInventory?.addEventListener("click", printFullInventoryByFamily);
  els.globalSearchInput?.addEventListener("input", onGlobalSearchInput);
  els.globalSearchInput?.addEventListener("focus", onGlobalSearchInput);
  els.globalSearchInput?.addEventListener("keydown", onGlobalSearchKeydown);

document.addEventListener("click", (e) => {
  const insideSearch = e.target.closest(".search-with-results");
  if (!insideSearch) {
    hideGlobalSearchResults();
  }
});
  window.addEventListener("resize", () => {
    if (window.innerWidth > 980) closeSidebarMobile();
    renderProducts();
    renderMenajes();
    renderVarios();
  });
}

function closeProductDialog() {
  try {
    if (els.productDialog?.open && typeof els.productDialog.close === "function") {
      els.productDialog.close();
    } else {
      els.productDialog?.removeAttribute("open");
    }
  } catch (error) {
    console.error("Error cerrando modal:", error);
  }
}

function toggleSidebarMobile() {
  els.appShell?.classList.toggle("sidebar-open");
}

function closeSidebarMobile() {
  els.appShell?.classList.remove("sidebar-open");
}

function switchAuthTab(tab) {
  document.querySelectorAll("[data-auth-tab]").forEach(btn => {
    btn.classList.toggle("active", btn.dataset.authTab === tab);
  });

  const panels = document.querySelectorAll(".auth-tab");
  panels.forEach((panel, idx) => {
    const active =
      (tab === "login" && idx === 0) ||
      (tab === "register" && idx === 1) ||
      (tab === "setup" && idx === 2);

    panel.classList.toggle("active", active);
  });
}

function saveConfig(url, key) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify({ url, key }));
}

function safeJSON(s) {
  try {
    return JSON.parse(s);
  } catch {
    return null;
  }
}

function readConfig() {
  const fromWindow = window.APP_CONFIG || {};

  return {
    url: (fromWindow.SUPABASE_URL || "").trim(),
    key: (fromWindow.SUPABASE_ANON_KEY || "").trim()
  };
}

function loadSavedConfigToForms() {
  const cfg = readConfig();

  if (els.authSupabaseUrl) els.authSupabaseUrl.value = cfg.url || "";
  if (els.authSupabaseKey) els.authSupabaseKey.value = cfg.key || "";
  if (els.supabaseUrl) els.supabaseUrl.value = cfg.url || "";
  if (els.supabaseKey) els.supabaseKey.value = cfg.key || "";
  if (els.cfgPreviewUrl) els.cfgPreviewUrl.textContent = cfg.url || "—";
}

async function initSupabaseFromConfig() {
  const { url, key } = readConfig();

  flash(`DEBUG URL:${url ? "OK" : "NO"} · KEY:${key ? "OK" : "NO"}`);

  if (!url || !key) {
    showAuth("Falta configurar Supabase.");
    switchAuthTab("setup");
    return;
  }

  try {
    await initSupabase(url, key);
  } catch (e) {
    console.error("ERROR INIT SUPABASE:", e);
    showAuth((e && e.message) ? e.message : "No se pudo iniciar Supabase.", true);
    switchAuthTab("setup");
  }
}

async function initSupabase(url, key) {
  state.client = supabase.createClient(url, key);

  const { data, error } = await state.client.auth.getSession();
  if (error) throw error;

  state.session = data.session;
  state.user = data.session?.user || null;

  state.client.auth.onAuthStateChange(async (_event, session) => {
    state.session = session;
    state.user = session?.user || null;
    await afterAuthChange();
  });

  setConnectionState("neutral", "Supabase listo", "Conexión base preparada.");
  await afterAuthChange();
}

async function afterAuthChange() {
  if (!state.user) {
    state.profile = null;
    renderSessionState();
    showAuth("Accede a tu cuenta");
    switchAuthTab("login");
    return;
  }

  await loadProfile();
  renderSessionState();
  showApp();
  await refreshAll();
  await evaluateBootstrapVisibility();
  switchView("dashboard");
}

async function loadProfile() {
  const { data, error } = await state.client
    .from("profiles")
    .select("*")
    .eq("id", state.user.id)
    .maybeSingle();

  if (error) {
    state.profile = null;
    throwFriendly(error, "No pude cargar el perfil.");
    return;
  }

  state.profile = data || null;
}

function renderSessionState() {
  if (els.userName) {
    els.userName.textContent = state.profile?.full_name || state.user?.email?.split("@")[0] || "Invitado";
  }

  if (els.userEmail) {
    els.userEmail.textContent = state.user?.email || "Sin sesión";
  }

  if (els.roleBadge) {
    els.roleBadge.textContent = state.profile?.role || "viewer";
    els.roleBadge.className = `badge ${roleToBadge(state.profile?.role)}`;
  }

  const active = state.profile?.is_active !== false;

  if (els.activeBadge) {
    els.activeBadge.textContent = active ? "activo" : "bloqueado";
    els.activeBadge.className = `badge ${active ? "success" : "danger"}`;
  }

  if (els.cfgPreviewSession) els.cfgPreviewSession.textContent = state.user ? "Activa" : "Sin sesión";
  if (els.cfgPreviewRole) els.cfgPreviewRole.textContent = state.profile?.role || "viewer";
  if (els.cfgPreviewSessionConfig) els.cfgPreviewSessionConfig.textContent = state.user ? "Activa" : "Sin sesión";
  if (els.cfgPreviewRoleConfig) els.cfgPreviewRoleConfig.textContent = state.profile?.role || "viewer";
  if (els.cfgPreviewUrl) els.cfgPreviewUrl.textContent = readConfig().url || "—";

  if (els.navAdmin) {
    els.navAdmin.classList.toggle("hidden", !isAdmin());
  }

  document.querySelectorAll(".nav-btn").forEach(btn => {
    if (btn.dataset.view === "configuracion") {
      btn.classList.toggle("hidden", !isAdmin());
    }
    if (btn.dataset.view === "admin") {
      btn.classList.toggle("hidden", !isAdmin());
    }
  });

  setConnectionState(
    state.user ? "success" : "neutral",
    state.user ? "Sesión activa" : "Sin sesión",
    state.user ? `Rol actual: ${state.profile?.role || "viewer"}` : "Accede para trabajar."
  );

  applyPermissionsUI();
}

function applyPermissionsUI() {
  const canWrite = canEdit();
  const active = isActiveUser();

  if (els.btnNewProduct) els.btnNewProduct.disabled = !canWrite || !active;
  if (els.btnNewMenaje) els.btnNewMenaje.disabled = !canWrite || !active;
  if (els.btnNewVarios) els.btnNewVarios.disabled = !canWrite || !active;
  if (els.btnSeed) els.btnSeed.disabled = !isAdmin() || !active;
  if (els.btnImportMenajes) els.btnImportMenajes.disabled = !isAdmin() || !active;

  if (els.movementForm) {
    els.movementForm.querySelectorAll("input, select, textarea, button").forEach(el => {
      el.disabled = !canWrite || !active;
    });
  }
}

function showAuth(message, isError = false) {
  els.authShell?.classList.remove("hidden");
  els.appShell?.classList.add("hidden");

  if (els.authStatus) {
    els.authStatus.textContent = message;
    els.authStatus.className = `alert ${isError ? "error" : "info"}`;
  }
}

function showApp() {
  els.authShell?.classList.add("hidden");
  els.appShell?.classList.remove("hidden");
}

function setConnectionState(kind, badgeText, text) {
  const klass =
    kind === "success" ? "success" :
    kind === "danger" ? "danger" :
    kind === "warning" ? "warning" : "neutral";

  if (els.connectionBadge) {
    els.connectionBadge.textContent = badgeText;
    els.connectionBadge.className = `badge ${klass}`;
  }

  if (els.connectionText) {
    els.connectionText.textContent = text;
  }
}

async function onSaveConfigFromAuth(e) {
  e.preventDefault();
  const url = els.authSupabaseUrl?.value.trim();
  const key = els.authSupabaseKey?.value.trim();

  if (!url || !key) return flash("Completa URL y anon key.", true);

  saveConfig(url, key);
  loadSavedConfigToForms();

  try {
    await initSupabase(url, key);
    flash("Conexión guardada.");
    switchAuthTab("login");
  } catch (error) {
    throwFriendly(error, "No se pudo guardar la conexión.");
  }
}

async function onSaveConfigFromPanel(e) {
  e.preventDefault();
  const url = els.supabaseUrl?.value.trim();
  const key = els.supabaseKey?.value.trim();

  if (!url || !key) return flash("Completa URL y anon key.", true);

  saveConfig(url, key);
  loadSavedConfigToForms();

  try {
    await initSupabase(url, key);
    flash("Conexión guardada.");
  } catch (error) {
    throwFriendly(error, "No se pudo guardar la conexión.");
  }
}

async function onTestConnectionFromAuth() {
  const url = els.authSupabaseUrl?.value.trim();
  const key = els.authSupabaseKey?.value.trim();
  if (!url || !key) return flash("Completa URL y anon key.", true);
  await testConnection(url, key);
}

async function onTestConnectionFromPanel() {
  const url = els.supabaseUrl?.value.trim();
  const key = els.supabaseKey?.value.trim();
  if (!url || !key) return flash("Completa URL y anon key.", true);
  await testConnection(url, key);
}

async function testConnection(url, key) {
  try {
    const client = supabase.createClient(url, key);
    const { error } = await client.from("categorias").select("id").limit(1);
    if (error) throw error;
    flash("Conexión correcta con Supabase.");
  } catch (error) {
    throwFriendly(error, "La conexión falló.");
  }
}

function clearConfig() {
  localStorage.removeItem(STORAGE_KEY);

  if (els.authSupabaseUrl) els.authSupabaseUrl.value = "";
  if (els.authSupabaseKey) els.authSupabaseKey.value = "";
  if (els.supabaseUrl) els.supabaseUrl.value = "";
  if (els.supabaseKey) els.supabaseKey.value = "";

  loadSavedConfigToForms();
  flash("Configuración borrada.");
}

async function onLogin(e) {
  e.preventDefault();
  if (!state.client) return flash("Configura Supabase primero.", true);

  const email = document.getElementById("loginEmail")?.value?.trim() || "";
  const password = document.getElementById("loginPassword")?.value || "";

  if (!email || !password) return flash("Completa email y contraseña.", true);

  try {
    const { error } = await state.client.auth.signInWithPassword({ email, password });
    if (error) return throwFriendly(error, "No pude iniciar sesión.");
    flash("Sesión iniciada.");
    els.loginForm?.reset();
  } catch (error) {
    throwFriendly(error, "No pude iniciar sesión.");
  }
}

async function onRegister(e) {
  e.preventDefault();
  if (!state.client) return flash("Configura Supabase primero.", true);

  const email = document.getElementById("registerEmail")?.value?.trim() || "";
  const password = document.getElementById("registerPassword")?.value || "";
  const fullName = document.getElementById("registerName")?.value?.trim() || "";

  if (!email || !password) return flash("Completa email y contraseña.", true);
  if (password.length < 6) return flash("La contraseña debe tener al menos 6 caracteres.", true);

  try {
    const { data, error } = await state.client.auth.signUp({
      email,
      password,
      options: {
        data: { full_name: fullName || email.split("@")[0] },
        emailRedirectTo: window.location.origin + window.location.pathname
      }
    });

    if (error) return throwFriendly(error, "No pude crear la cuenta.");

    const createdUserId = data?.user?.id;
    if (createdUserId) {
      const { error: profileError } = await state.client.from("profiles").upsert({
        id: createdUserId,
        email,
        full_name: fullName || email.split("@")[0],
        role: "viewer",
        is_active: true
      }, { onConflict: "id" });

      if (profileError) {
        console.warn("No pude crear el perfil automáticamente:", profileError);
      }
    }

    flash("Cuenta creada. Revisa tu email si Supabase pide verificación.");
    switchAuthTab("login");
    els.registerForm?.reset();
  } catch (error) {
    throwFriendly(error, "No pude crear la cuenta.");
  }
}

async function onLogout() {
  if (!state.client) return;

  const { error } = await state.client.auth.signOut();
  if (error) return throwFriendly(error, "No pude cerrar sesión.");

  showAuth("Sesión cerrada.");
  switchAuthTab("login");
}

async function evaluateBootstrapVisibility() {
  if (!state.user || !els.btnBootstrapAdmin) return;

  try {
    const { data, error } = await state.client.rpc("admin_count");
    if (error) throw error;
    els.btnBootstrapAdmin.classList.toggle("hidden", Number(data || 0) > 0 || isAdmin());
  } catch {
    els.btnBootstrapAdmin.classList.add("hidden");
  }
}

async function onBootstrapAdmin() {
  const { error } = await state.client.rpc("bootstrap_first_admin");
  if (error) return throwFriendly(error, "No pude asignarte como admin inicial.");

  await loadProfile();
  renderSessionState();
  await evaluateBootstrapVisibility();
  switchView("admin");
  flash("Ahora eres admin inicial del sistema.");
}

function switchView(view) {
  if ((view === "configuracion" || view === "admin") && !isAdmin()) {
    flash("No tienes permisos para acceder a esa sección.", true);
    return;
  }

  const titles = {
    dashboard: ["Dashboard", "Resumen ejecutivo del inventario."],
    productos: ["Bebidas", "Gestión centralizada de stock, edición y control por categoría."],
    menajes: ["Menajes", "Inventario de vajilla, cristalería, cubertería, mantelería y material de servicio."],
    varios: ["Varios", "Artículos auxiliares, suministros y otros no clasificados como bebida o menaje."],
    movimientos: ["Movimientos", "Entradas, salidas y ajustes con trazabilidad."],
    admin: ["Administración", "Usuarios, roles y activación de accesos."],
    configuracion: ["Configuración", "Estado de conexión, sesión y despliegue."]
  };

  document.querySelectorAll(".view").forEach(section => section.classList.remove("active"));
  document.querySelectorAll(".nav-btn").forEach(btn => btn.classList.remove("active"));

  const targetView = document.getElementById(`view-${view}`);
  const targetBtn = document.querySelector(`.nav-btn[data-view="${view}"]`);

  if (targetView) targetView.classList.add("active");
  if (targetBtn) targetBtn.classList.add("active");

  if (titles[view] && els.viewTitle && els.viewSubtitle) {
    els.viewTitle.textContent = titles[view][0];
    els.viewSubtitle.textContent = titles[view][1];
  }
updateSectionTopBanner(view);
  if (view === "dashboard") renderDashboard();
  if (view === "productos") renderProducts();
  if (view === "menajes") renderMenajes();
  if (view === "varios") renderVarios();
  if (view === "movimientos") renderMovementHistory();
  if (view === "admin" && isAdmin()) renderUsersList();
}

async function refreshAll() {
  if (!ensureReady()) return;

  await Promise.all([
    loadCategorias(),
    loadProductos(),
    loadMovimientos(),
    isAdmin() ? loadProfiles() : Promise.resolve()
  ]);

  populateCategoryFilters();
  populateMenajesFilters();
  populateVariosFilters();
  populateProductSelects();

  renderDashboard();
  renderProducts();
  renderMenajes();
  renderVarios();
  renderMovementHistory();

  if (isAdmin()) renderUsersList();
}

function updateSectionTopBanner(view) {
  if (!els.sectionTopBanner || !els.sectionTopBannerEyebrow || !els.sectionTopBannerTitle || !els.sectionTopBannerText) return;

  els.sectionTopBanner.className = "section-top-banner";

  const map = {
    dashboard: {
      className: "hero-dashboard",
      eyebrow: "Inventario Banquetes Pro",
      title: "Visión ejecutiva del inventario",
      text: "Control profesional de stock, alertas y trazabilidad operativa."
    },
    productos: {
      className: "hero-bebidas",
      eyebrow: "Módulo bebidas",
      title: "Control premium de bebidas",
      text: "Vinos, destilados, refrescos, cava y stock operativo de sala y banquetes."
    },
    menajes: {
      className: "hero-menajes",
      eyebrow: "Módulo menaje",
      title: "Material de servicio y montaje",
      text: "Vajilla, cristalería, cubertería, buffet y elementos de apoyo operativo."
    },
    varios: {
      className: "hero-varios",
      eyebrow: "Módulo varios",
      title: "Suministros y auxiliares",
      text: "Consumibles, despensa, apoyo logístico y artículos complementarios."
    },
    movimientos: {
      className: "hero-movimientos",
      eyebrow: "Trazabilidad operativa",
      title: "Entradas, salidas y ajustes",
      text: "Control histórico de movimientos, incidencias y variaciones de stock."
    },
    admin: {
      className: "hero-admin",
      eyebrow: "Gobierno del sistema",
      title: "Usuarios, permisos y control",
      text: "Supervisión de accesos, roles y seguridad operativa."
    },
    configuracion: {
      className: "hero-configuracion",
      eyebrow: "Configuración técnica",
      title: "Entorno y conexión",
      text: "Estado del sistema, sesión activa y configuración de plataforma."
    }
  };

  const cfg = map[view] || map.dashboard;

  els.sectionTopBanner.classList.add(cfg.className);
  els.sectionTopBannerEyebrow.textContent = cfg.eyebrow;
  els.sectionTopBannerTitle.textContent = cfg.title;
  els.sectionTopBannerText.textContent = cfg.text;
}
function onGlobalSearchInput() {
  const q = els.globalSearchInput?.value.trim().toLowerCase() || "";

  if (!els.globalSearchResults) return;

  if (!q) {
    globalSearchSelectionIndex = -1;
    globalSearchCurrentResults = [];
    hideGlobalSearchResults();
    return;
  }

  const results = state.productos
    .filter(p => {
      const text = [
        p.stock_code || "",
        p.descripcion || "",
        p.presentacion || "",
        p.categorias?.nombre || "",
        p.familia || ""
      ].join(" ").toLowerCase();

      return text.includes(q);
    })
    .sort((a, b) =>
      (a.descripcion || "").localeCompare((b.descripcion || ""), "es", { sensitivity: "base" })
    )
    .slice(0, 8);

  globalSearchSelectionIndex = -1;
  globalSearchCurrentResults = results;
  renderGlobalSearchResults(results, q);
}

function onGlobalSearchKeydown(e) {
  if (!globalSearchCurrentResults.length) return;

  if (e.key === "ArrowDown") {
    e.preventDefault();
    globalSearchSelectionIndex = Math.min(globalSearchSelectionIndex + 1, globalSearchCurrentResults.length - 1);
    updateGlobalSearchSelection();
  }

  if (e.key === "ArrowUp") {
    e.preventDefault();
    globalSearchSelectionIndex = Math.max(globalSearchSelectionIndex - 1, 0);
    updateGlobalSearchSelection();
  }

  if (e.key === "Enter") {
    e.preventDefault();
    if (globalSearchSelectionIndex >= 0 && globalSearchCurrentResults[globalSearchSelectionIndex]) {
      goToGlobalSearchResult(globalSearchCurrentResults[globalSearchSelectionIndex], true);
    }
  }

  if (e.key === "Escape") {
    hideGlobalSearchResults();
  }
}

function renderGlobalSearchResults(results, q) {
  if (!els.globalSearchResults) return;

  els.globalSearchResults.innerHTML = "";

  if (!results.length) {
    els.globalSearchResults.innerHTML = `
      <div class="global-search-empty">
        No se encontraron artículos para <strong>${escapeHtml(q)}</strong>
      </div>
    `;
    els.globalSearchResults.classList.remove("hidden");
    return;
  }

  results.forEach((p, index) => {
    const item = document.createElement("button");
    item.type = "button";
    item.className = "global-search-result-item";
    item.dataset.index = index;

    const familyLabel =
      p.familia === "menaje" ? "Menaje" :
      p.familia === "varios" ? "Varios" : "Bebidas";

    const qty = Number(p.cantidad || 0);
    const min = Number(p.min_stock || 0);
    const stockClass = qty <= 0 ? "danger" : qty <= min ? "warn" : "ok";

    item.innerHTML = `
      <div class="global-search-result-main">
        <strong>${escapeHtml(p.descripcion || "Sin descripción")}</strong>
        <small>${escapeHtml(p.presentacion || "")}</small>
      </div>

      <div class="global-search-result-meta">
        <span class="global-search-code">${escapeHtml(p.stock_code || "Sin código")}</span>
        <span class="global-search-family family-${escapeHtml(p.familia || "bebidas")}">${familyLabel}</span>
        <span class="global-search-stock ${stockClass}">Stock: ${formatNum(qty)}</span>
      </div>
    `;

    item.addEventListener("click", () => {
      goToGlobalSearchResult(p, true);
    });

    els.globalSearchResults.appendChild(item);
  });

  els.globalSearchResults.classList.remove("hidden");
}

function updateGlobalSearchSelection() {
  if (!els.globalSearchResults) return;

  const items = els.globalSearchResults.querySelectorAll(".global-search-result-item");
  items.forEach(item => item.classList.remove("selected"));

  const selected = items[globalSearchSelectionIndex];
  if (selected) {
    selected.classList.add("selected");
    selected.scrollIntoView({ block: "nearest" });
  }
}

function hideGlobalSearchResults() {
  if (!els.globalSearchResults) return;
  els.globalSearchResults.classList.add("hidden");
  els.globalSearchResults.innerHTML = "";
  globalSearchSelectionIndex = -1;
  globalSearchCurrentResults = [];
}

function goToGlobalSearchResult(product, openModal = false) {
  if (product.familia === "menaje") {
    switchView("menajes");
    if (els.menajesSearchInput) els.menajesSearchInput.value = product.descripcion || product.stock_code || "";
    renderMenajes();
  } else if (product.familia === "varios") {
    switchView("varios");
    if (els.variosSearchInput) els.variosSearchInput.value = product.descripcion || product.stock_code || "";
    renderVarios();
  } else {
    switchView("productos");
    if (els.familyFilter) els.familyFilter.value = "bebidas";
    populateCategoryFilters();
    if (els.searchInput) els.searchInput.value = product.descripcion || product.stock_code || "";
    renderProducts();
  }

  if (els.globalSearchInput) {
    els.globalSearchInput.value = product.descripcion || product.stock_code || "";
  }

  hideGlobalSearchResults();

  setTimeout(() => {
    highlightProductRow(product.id);

    if (openModal) {
      openEditProductDialog(product.id);
    }
  }, 150);
}

function highlightProductRow(productId) {
  document.querySelectorAll(".row-highlight").forEach(el => {
    el.classList.remove("row-highlight");
  });

  const actionButton = document.querySelector(`[data-id="${productId}"]`);
  const row = actionButton?.closest("tr") || actionButton?.closest(".mobile-product-card");

  if (!row) return;

  row.classList.add("row-highlight");
  row.scrollIntoView({ behavior: "smooth", block: "center" });

  setTimeout(() => {
    row.classList.remove("row-highlight");
  }, 2500);
}
function ensureReady() {
  if (!state.user || !state.client) {
    flash("Primero inicia sesión.", true);
    return false;
  }
  return true;
}

async function loadCategorias() {
  const { data, error } = await state.client
    .from("categorias")
    .select("*")
    .order("nombre");

  if (error) return throwFriendly(error, "No pude cargar categorías.");
  state.categorias = data || [];
}

async function loadProductos() {
  const { data, error } = await state.client
    .from("productos")
    .select("*, categorias(id,nombre)")
    .order("descripcion");

  if (error) return throwFriendly(error, "No pude cargar productos.");
  state.productos = data || [];
}

async function loadMovimientos() {
  const { data, error } = await state.client
    .from("movimientos")
    .select("*, productos(id,descripcion,stock_code)")
    .order("created_at", { ascending: false })
    .limit(120);

  if (error) return throwFriendly(error, "No pude cargar movimientos.");
  state.movimientos = data || [];
}

async function loadProfiles() {
  const { data, error } = await state.client
    .from("profiles")
    .select("*")
    .order("created_at");

  if (error) return throwFriendly(error, "No pude cargar perfiles.");
  state.perfiles = data || [];
}

function isMenajeCategoryName(nombre) {
  const set = [
    "menajes",
    "vajilla",
    "cubertería",
    "cuberteria",
    "cristalería",
    "cristaleria",
    "mantelería",
    "manteleria",
    "buffet",
    "buffet y servicio",
    "extras sala"
  ];

  return set.includes((nombre || "").trim().toLowerCase());
}

function isVariosCategoryName(nombre) {
  const set = [
    "otros",
    "suministros",
    "despensa y condimentos",
    "fruta y verdura",
    "leches y bebidas vegetales"
  ];

  return set.includes((nombre || "").trim().toLowerCase());
}

function getMenajeCategories() {
  return state.categorias.filter(c => isMenajeCategoryName(c.nombre));
}

function getVariosCategories() {
  return state.categorias.filter(c => isVariosCategoryName(c.nombre));
}

function syncCategoryByFamily() {
  if (!els.pFamilia || !els.pCategoria) return;

  const familia = els.pFamilia.value;

  if (familia === "menaje") {
    const menajeCat = getMenajeCategories()[0];
    if (menajeCat) els.pCategoria.value = menajeCat.id;
  }

  if (familia === "varios") {
    const variosCat = getVariosCategories()[0];
    if (variosCat) els.pCategoria.value = variosCat.id;
  }

  if (els.productDialog) {
    els.productDialog.dataset.familia = familia;
  }
}

function populateCategoryFilters() {
  if (!els.categoryFilter || !els.pCategoria) return;

  const current = els.categoryFilter.value;
  const beverageCategories = state.categorias.filter(
    c => !isMenajeCategoryName(c.nombre) && !isVariosCategoryName(c.nombre)
  );

  els.categoryFilter.innerHTML = `<option value="">Todas las categorías</option>`;
  beverageCategories.forEach(c => {
    els.categoryFilter.insertAdjacentHTML(
      "beforeend",
      `<option value="${c.id}">${escapeHtml(c.nombre)}</option>`
    );
  });

  els.pCategoria.innerHTML = `<option value="">Sin categoría</option>`;
  state.categorias.forEach(c => {
    els.pCategoria.insertAdjacentHTML(
      "beforeend",
      `<option value="${c.id}">${escapeHtml(c.nombre)}</option>`
    );
  });

  const validCurrent = beverageCategories.some(c => c.id === current);
  els.categoryFilter.value = validCurrent ? current : "";
}

function populateMenajesFilters() {
  if (!els.menajesCategoryFilter) return;

  const current = els.menajesCategoryFilter.value;
  const menajeCats = getMenajeCategories();

  els.menajesCategoryFilter.innerHTML = `<option value="">Todas las categorías de menaje</option>`;
  menajeCats.forEach(c => {
    els.menajesCategoryFilter.insertAdjacentHTML(
      "beforeend",
      `<option value="${c.id}">${escapeHtml(c.nombre)}</option>`
    );
  });

  const validCurrent = menajeCats.some(c => c.id === current);
  els.menajesCategoryFilter.value = validCurrent ? current : "";
}

function populateVariosFilters() {
  if (!els.variosCategoryFilter) return;

  const current = els.variosCategoryFilter.value;
  const variosCats = getVariosCategories();

  els.variosCategoryFilter.innerHTML = `<option value="">Todas las categorías de varios</option>`;
  variosCats.forEach(c => {
    els.variosCategoryFilter.insertAdjacentHTML(
      "beforeend",
      `<option value="${c.id}">${escapeHtml(c.nombre)}</option>`
    );
  });

  const validCurrent = variosCats.some(c => c.id === current);
  els.variosCategoryFilter.value = validCurrent ? current : "";
}

function populateProductSelects() {
  if (!els.movementProduct) return;

  const current = els.movementProduct.value;
  els.movementProduct.innerHTML = `<option value="">Selecciona un producto</option>`;

  state.productos.forEach(p => {
    els.movementProduct.insertAdjacentHTML(
      "beforeend",
      `<option value="${p.id}">${escapeHtml(p.descripcion)} · ${formatNum(p.cantidad)}</option>`
    );
  });

  if (current) els.movementProduct.value = current;
}

function getFilteredProducts() {
  const q = els.searchInput?.value.trim().toLowerCase() || "";
  const cat = els.categoryFilter?.value || "";
  const stockMode = els.stockFilter?.value || "";

  return state.productos.filter(p => {
    const isBebida = (p.familia || "bebidas") === "bebidas";
    const matchText = !q || [p.stock_code, p.descripcion, p.presentacion]
      .some(v => (v || "").toLowerCase().includes(q));
    const matchCat = !cat || p.categoria_id === cat;
    const qty = Number(p.cantidad || 0);
    const min = Number(p.min_stock || 0);

    const matchStock =
      !stockMode ||
      (stockMode === "low" && qty <= min) ||
      (stockMode === "out" && qty <= 0) ||
      (stockMode === "ok" && qty > min);

    return isBebida && matchText && matchCat && matchStock;
  });
}

function getFilteredMenajes() {
  const q = els.menajesSearchInput?.value.trim().toLowerCase() || "";
  const cat = els.menajesCategoryFilter?.value || "";

  return state.productos.filter(p => {
    const isMenaje = p.familia === "menaje";
    const matchText = !q || [p.stock_code, p.descripcion, p.presentacion]
      .some(v => (v || "").toLowerCase().includes(q));
    const matchCat = !cat || p.categoria_id === cat;
    return isMenaje && matchText && matchCat;
  });
}

function getFilteredVarios() {
  const q = els.variosSearchInput?.value.trim().toLowerCase() || "";
  const cat = els.variosCategoryFilter?.value || "";

  return state.productos.filter(p => {
    const isVarios = p.familia === "varios";
    const matchText = !q || [p.stock_code, p.descripcion, p.presentacion]
      .some(v => (v || "").toLowerCase().includes(q));
    const matchCat = !cat || p.categoria_id === cat;
    return isVarios && matchText && matchCat;
  });
}

function renderDashboard() {
  const totalProductos = state.productos.length;
  const stockTotal = state.productos.reduce((acc, p) => acc + Number(p.cantidad || 0), 0);
  const bajos = state.productos.filter(p => Number(p.cantidad || 0) <= Number(p.min_stock || 0)).length;
  const sin = state.productos.filter(p => Number(p.cantidad || 0) <= 0).length;

  const bebidas = state.productos.filter(p => (p.familia || "bebidas") === "bebidas").length;
  const menajes = state.productos.filter(p => p.familia === "menaje").length;
  const varios = state.productos.filter(p => p.familia === "varios").length;

  const recentMovesCount = state.movimientos.slice(0, 8).length;
  const criticalCount = state.productos.filter(p => Number(p.cantidad || 0) <= Number(p.min_stock || 0)).length;

  let operationalStatus = "Controlado";
  if (sin > 0) {
    operationalStatus = "Crítico";
  } else if (bajos > 0) {
    operationalStatus = "Seguimiento";
  }

  if (els.kpiProductos) els.kpiProductos.textContent = totalProductos;
  if (els.kpiStock) els.kpiStock.textContent = formatNum(stockTotal);
  if (els.kpiBajoMinimo) els.kpiBajoMinimo.textContent = bajos;
  if (els.kpiSinStock) els.kpiSinStock.textContent = sin;

  if (els.kpiBebidas) els.kpiBebidas.textContent = bebidas;
  if (els.kpiMenajes) els.kpiMenajes.textContent = menajes;
  if (els.kpiVarios) els.kpiVarios.textContent = varios;
  if (els.kpiMovimientosTotal) els.kpiMovimientosTotal.textContent = state.movimientos.length;

  if (els.kpiOperationalStatus) els.kpiOperationalStatus.textContent = operationalStatus;
  if (els.kpiCriticalCount) els.kpiCriticalCount.textContent = criticalCount;
  if (els.kpiRecentMoves) els.kpiRecentMoves.textContent = recentMovesCount;

  if (els.familyCountBebidas) els.familyCountBebidas.textContent = bebidas;
  if (els.familyCountMenajes) els.familyCountMenajes.textContent = menajes;
  if (els.familyCountVarios) els.familyCountVarios.textContent = varios;

  if (els.executiveSummary) {
    if (sin > 0) {
      els.executiveSummary.textContent = `Existen ${sin} artículos sin stock y ${bajos} bajo mínimo. Requiere intervención operativa inmediata.`;
    } else if (bajos > 0) {
      els.executiveSummary.textContent = `El inventario está operativo, pero hay ${bajos} artículos bajo mínimo que requieren reposición o seguimiento.`;
    } else {
      els.executiveSummary.textContent = `Inventario estable. No se detectan artículos sin stock ni incidencias críticas activas en este momento.`;
    }
  }

  renderCriticalList();
  renderRecentMoves();
}

function renderCriticalList() {
  if (!els.criticalList) return;

  const rows = state.productos
    .filter(p => Number(p.cantidad || 0) <= Number(p.min_stock || 0))
    .sort((a, b) => Number(a.cantidad || 0) - Number(b.cantidad || 0))
    .slice(0, 10);

  els.criticalList.innerHTML = "";

  if (!rows.length) {
    return renderEmpty(els.criticalList, "No hay productos críticos.");
  }

  rows.forEach(p => {
    const div = document.createElement("div");
    div.className = "item";
    div.innerHTML = `<strong>${escapeHtml(p.descripcion)} <span class="tag danger">${formatNum(p.cantidad)} / mín. ${formatNum(p.min_stock)}</span></strong><small>${escapeHtml(p.stock_code || "Sin código")} · ${escapeHtml(p.categorias?.nombre || "Sin categoría")}</small>`;
    els.criticalList.appendChild(div);
  });
}

function renderRecentMoves() {
  if (!els.recentMoves) return;

  els.recentMoves.innerHTML = "";

  if (!state.movimientos.length) {
    return renderEmpty(els.recentMoves, "Todavía no hay movimientos.");
  }

  state.movimientos.slice(0, 8).forEach(m => {
    const color = m.tipo === "salida" ? "danger" : m.tipo === "ajuste" ? "warn" : "ok";
    const div = document.createElement("div");
    div.className = "item";
    div.innerHTML = `<strong>${escapeHtml(m.productos?.descripcion || "Producto")} <span class="tag ${color}">${escapeHtml(m.tipo)}</span></strong><small>${formatNum(m.cantidad)} · ${formatDate(m.created_at)}${m.nota ? " · " + escapeHtml(m.nota) : ""}</small>`;
    els.recentMoves.appendChild(div);
  });
}

function renderProducts() {
  if (!els.productsTable) return;

  const rows = getFilteredProducts();
  els.productsTable.innerHTML = "";

  if (!rows.length) {
    els.productsTable.innerHTML = `<tr><td colspan="8"><div class="empty-state">No hay bebidas para ese filtro.</div></td></tr>`;
    return;
  }

  const isMobile = window.innerWidth <= 640;

  rows.forEach(p => {
    const qty = Number(p.cantidad || 0);
    const min = Number(p.min_stock || 0);
    const statusClass = qty <= 0 ? "danger" : qty <= min ? "warn" : "ok";
    const canWrite = canEdit() && isActiveUser();

    const tr = document.createElement("tr");

    if (isMobile) {
      tr.className = "mobile-product-row";
      tr.innerHTML = `
        <td colspan="8">
          <div class="mobile-product-card">
            <div class="mobile-product-top">
              <div>
                <div class="mobile-label">Código</div>
                <div class="mobile-code">${escapeHtml(p.stock_code || "")}</div>
              </div>
              <div>
                <span class="tag ${statusClass}">${formatNum(qty)}</span>
              </div>
            </div>

            <div class="mobile-product-body">
              <div class="mobile-label">Descripción</div>
              <div class="mobile-title">${escapeHtml(p.descripcion)}</div>
              <div class="mobile-sub">${escapeHtml(p.presentacion || "")}</div>
            </div>

            <div class="mobile-product-grid">
              <div>
                <div class="mobile-label">Categoría</div>
                <div>${escapeHtml(p.categorias?.nombre || "Sin categoría")}</div>
              </div>
              <div>
                <div class="mobile-label">Unidad</div>
                <div>${escapeHtml(p.unit || "")}</div>
              </div>
              <div>
                <div class="mobile-label">Stock</div>
                <div>${formatNum(qty)}</div>
              </div>
              <div>
                <div class="mobile-label">Mínimo</div>
                <div>${formatNum(min)}</div>
              </div>
            </div>

            <div class="mobile-product-actions">
              <button class="btn-mini" data-action="edit" data-id="${p.id}" ${canWrite ? "" : "disabled"}>Editar</button>
              <button class="btn-mini danger" data-action="delete" data-id="${p.id}" ${isAdmin() && isActiveUser() ? "" : "disabled"}>Borrar</button>
            </div>
          </div>
        </td>
      `;
    } else {
      tr.innerHTML = `
        <td>${escapeHtml(p.stock_code || "")}</td>
        <td><strong>${escapeHtml(p.descripcion)}</strong><br><small class="muted">${escapeHtml(p.presentacion || "")}</small></td>
        <td>${escapeHtml(p.categorias?.nombre || "Sin categoría")}</td>
        <td>${escapeHtml(p.unit || "")}</td>
        <td><span class="tag ${statusClass}">${formatNum(qty)}</span></td>
        <td>${formatNum(min)}</td>
        <td>${p.pagina ?? ""}</td>
        <td>
          <div class="form-actions">
            <button class="btn-mini" data-action="edit" data-id="${p.id}" ${canWrite ? "" : "disabled"}>Editar</button>
            <button class="btn-mini danger" data-action="delete" data-id="${p.id}" ${isAdmin() && isActiveUser() ? "" : "disabled"}>Borrar</button>
          </div>
        </td>
      `;
    }

    els.productsTable.appendChild(tr);
  });

  els.productsTable.querySelectorAll("[data-action='edit']").forEach(btn => {
    btn.addEventListener("click", () => openEditProductDialog(btn.dataset.id));
  });

  els.productsTable.querySelectorAll("[data-action='delete']").forEach(btn => {
    btn.addEventListener("click", () => deleteProduct(btn.dataset.id));
  });
}

function renderMenajes() {
  if (!els.menajesTable) return;

  const rows = getFilteredMenajes();
  els.menajesTable.innerHTML = "";

  if (!rows.length) {
    els.menajesTable.innerHTML = `<tr><td colspan="8"><div class="empty-state">No hay menajes para ese filtro.</div></td></tr>`;
    return;
  }

  const isMobile = window.innerWidth <= 640;

  rows.forEach(p => {
    const qty = Number(p.cantidad || 0);
    const min = Number(p.min_stock || 0);
    const statusClass = qty <= 0 ? "danger" : qty <= min ? "warn" : "ok";
    const canWrite = canEdit() && isActiveUser();

    const tr = document.createElement("tr");

    if (isMobile) {
      tr.className = "mobile-product-row";
      tr.innerHTML = `
        <td colspan="8">
          <div class="mobile-product-card">
            <div class="mobile-product-top">
              <div>
                <div class="mobile-label">Código</div>
                <div class="mobile-code">${escapeHtml(p.stock_code || "")}</div>
              </div>
              <div>
                <span class="tag ${statusClass}">${formatNum(qty)}</span>
              </div>
            </div>

            <div class="mobile-product-body">
              <div class="mobile-label">Descripción</div>
              <div class="mobile-title">${escapeHtml(p.descripcion)}</div>
              <div class="mobile-sub">${escapeHtml(p.presentacion || "")}</div>
            </div>

            <div class="mobile-product-grid">
              <div>
                <div class="mobile-label">Categoría</div>
                <div>${escapeHtml(p.categorias?.nombre || "Sin categoría")}</div>
              </div>
              <div>
                <div class="mobile-label">Unidad</div>
                <div>${escapeHtml(p.unit || "")}</div>
              </div>
              <div>
                <div class="mobile-label">Stock</div>
                <div>${formatNum(qty)}</div>
              </div>
              <div>
                <div class="mobile-label">Mínimo</div>
                <div>${formatNum(min)}</div>
              </div>
            </div>

            <div class="mobile-product-actions">
              <button class="btn-mini" data-menaje-action="edit" data-id="${p.id}" ${canWrite ? "" : "disabled"}>Editar</button>
              <button class="btn-mini danger" data-menaje-action="delete" data-id="${p.id}" ${isAdmin() && isActiveUser() ? "" : "disabled"}>Borrar</button>
            </div>
          </div>
        </td>
      `;
    } else {
      tr.innerHTML = `
        <td>${escapeHtml(p.stock_code || "")}</td>
        <td><strong>${escapeHtml(p.descripcion)}</strong><br><small class="muted">${escapeHtml(p.presentacion || "")}</small></td>
        <td>${escapeHtml(p.categorias?.nombre || "Sin categoría")}</td>
        <td>${escapeHtml(p.unit || "")}</td>
        <td><span class="tag ${statusClass}">${formatNum(qty)}</span></td>
        <td>${formatNum(min)}</td>
        <td>${p.pagina ?? ""}</td>
        <td>
          <div class="form-actions">
            <button class="btn-mini" data-menaje-action="edit" data-id="${p.id}" ${canWrite ? "" : "disabled"}>Editar</button>
            <button class="btn-mini danger" data-menaje-action="delete" data-id="${p.id}" ${isAdmin() && isActiveUser() ? "" : "disabled"}>Borrar</button>
          </div>
        </td>
      `;
    }

    els.menajesTable.appendChild(tr);
  });

  els.menajesTable.querySelectorAll("[data-menaje-action='edit']").forEach(btn => {
    btn.addEventListener("click", () => openEditProductDialog(btn.dataset.id));
  });

  els.menajesTable.querySelectorAll("[data-menaje-action='delete']").forEach(btn => {
    btn.addEventListener("click", () => deleteProduct(btn.dataset.id));
  });
}

function renderVarios() {
  if (!els.variosTable) return;

  const rows = getFilteredVarios();
  els.variosTable.innerHTML = "";

  if (!rows.length) {
    els.variosTable.innerHTML = `<tr><td colspan="8"><div class="empty-state">No hay artículos en Varios.</div></td></tr>`;
    return;
  }

  const isMobile = window.innerWidth <= 640;

  rows.forEach(p => {
    const qty = Number(p.cantidad || 0);
    const min = Number(p.min_stock || 0);
    const statusClass = qty <= 0 ? "danger" : qty <= min ? "warn" : "ok";
    const canWrite = canEdit() && isActiveUser();

    const tr = document.createElement("tr");

    if (isMobile) {
      tr.className = "mobile-product-row";
      tr.innerHTML = `
        <td colspan="8">
          <div class="mobile-product-card">
            <div class="mobile-product-top">
              <div>
                <div class="mobile-label">Código</div>
                <div class="mobile-code">${escapeHtml(p.stock_code || "")}</div>
              </div>
              <div>
                <span class="tag ${statusClass}">${formatNum(qty)}</span>
              </div>
            </div>

            <div class="mobile-product-body">
              <div class="mobile-label">Descripción</div>
              <div class="mobile-title">${escapeHtml(p.descripcion)}</div>
              <div class="mobile-sub">${escapeHtml(p.presentacion || "")}</div>
            </div>

            <div class="mobile-product-grid">
              <div>
                <div class="mobile-label">Categoría</div>
                <div>${escapeHtml(p.categorias?.nombre || "Sin categoría")}</div>
              </div>
              <div>
                <div class="mobile-label">Unidad</div>
                <div>${escapeHtml(p.unit || "")}</div>
              </div>
              <div>
                <div class="mobile-label">Stock</div>
                <div>${formatNum(qty)}</div>
              </div>
              <div>
                <div class="mobile-label">Mínimo</div>
                <div>${formatNum(min)}</div>
              </div>
            </div>

            <div class="mobile-product-actions">
              <button class="btn-mini" data-varios-action="edit" data-id="${p.id}" ${canWrite ? "" : "disabled"}>Editar</button>
              <button class="btn-mini danger" data-varios-action="delete" data-id="${p.id}" ${isAdmin() && isActiveUser() ? "" : "disabled"}>Borrar</button>
            </div>
          </div>
        </td>
      `;
    } else {
      tr.innerHTML = `
        <td>${escapeHtml(p.stock_code || "")}</td>
        <td><strong>${escapeHtml(p.descripcion)}</strong><br><small class="muted">${escapeHtml(p.presentacion || "")}</small></td>
        <td>${escapeHtml(p.categorias?.nombre || "Sin categoría")}</td>
        <td>${escapeHtml(p.unit || "")}</td>
        <td><span class="tag ${statusClass}">${formatNum(qty)}</span></td>
        <td>${formatNum(min)}</td>
        <td>${p.pagina ?? ""}</td>
        <td>
          <div class="form-actions">
            <button class="btn-mini" data-varios-action="edit" data-id="${p.id}" ${canWrite ? "" : "disabled"}>Editar</button>
            <button class="btn-mini danger" data-varios-action="delete" data-id="${p.id}" ${isAdmin() && isActiveUser() ? "" : "disabled"}>Borrar</button>
          </div>
        </td>
      `;
    }

    els.variosTable.appendChild(tr);
  });

  els.variosTable.querySelectorAll("[data-varios-action='edit']").forEach(btn => {
    btn.addEventListener("click", () => openEditProductDialog(btn.dataset.id));
  });

  els.variosTable.querySelectorAll("[data-varios-action='delete']").forEach(btn => {
    btn.addEventListener("click", () => deleteProduct(btn.dataset.id));
  });
}

function renderMovementHistory() {
  if (!els.movementHistory) return;

  const typeFilter = els.movementFilterType?.value || "";
  const textFilter = els.movementFilterText?.value.trim().toLowerCase() || "";

  const rows = state.movimientos.filter(m => {
    const matchType = !typeFilter || m.tipo === typeFilter;

    const textBase = [
      m.productos?.descripcion || "",
      m.nota || "",
      m.motivo || "",
      m.evento_ref || ""
    ].join(" ").toLowerCase();

    const matchText = !textFilter || textBase.includes(textFilter);

    return matchType && matchText;
  });

  els.movementHistory.innerHTML = "";

  if (!rows.length) {
    return renderEmpty(els.movementHistory, "No hay movimientos registrados para ese filtro.");
  }

  rows.forEach(m => {
    const div = document.createElement("div");
    div.className = "item movement-item-premium";

    const typeClass =
      m.tipo === "entrada" ? "ok" :
      m.tipo === "salida" ? "danger" : "warn";

    const motivo = formatMovementReason(m.motivo);
    const referencia = m.evento_ref ? ` · ${escapeHtml(m.evento_ref)}` : "";
    const nota = m.nota ? ` · ${escapeHtml(m.nota)}` : "";

    div.innerHTML = `
      <strong>
        ${escapeHtml(m.productos?.descripcion || "Producto")}
        <span class="tag ${typeClass}">${escapeHtml(m.tipo)}</span>
      </strong>
      <small>
        ${formatNum(m.cantidad)} · stock ${formatNum(m.stock_anterior)} → ${formatNum(m.stock_nuevo)}
        · ${formatDate(m.created_at)}
        ${motivo ? " · " + escapeHtml(motivo) : ""}
        ${referencia}
        ${nota}
      </small>
    `;

    els.movementHistory.appendChild(div);
  });
}
function renderUsersList() {
  if (!els.usersList) return;

  els.usersList.innerHTML = "";

  if (!state.perfiles.length) {
    return renderEmpty(els.usersList, "No hay usuarios.");
  }

  state.perfiles.forEach(profile => {
    const row = document.createElement("div");
    row.className = "user-row";
    row.innerHTML = `
      <div class="user-main">
        <strong class="truncate">${escapeHtml(profile.full_name || profile.email || "Usuario")}</strong>
        <div class="muted small truncate">${escapeHtml(profile.email || "")}</div>
      </div>
      <select data-role-id="${profile.id}">
        <option value="viewer" ${profile.role === "viewer" ? "selected" : ""}>viewer</option>
        <option value="editor" ${profile.role === "editor" ? "selected" : ""}>editor</option>
        <option value="admin" ${profile.role === "admin" ? "selected" : ""}>admin</option>
      </select>
      <select data-active-id="${profile.id}">
        <option value="true" ${profile.is_active ? "selected" : ""}>activo</option>
        <option value="false" ${!profile.is_active ? "selected" : ""}>bloqueado</option>
      </select>
      <button class="btn ghost" data-save-profile="${profile.id}">Guardar</button>
    `;
    els.usersList.appendChild(row);
  });

  els.usersList.querySelectorAll("[data-save-profile]").forEach(btn => {
    btn.addEventListener("click", () => saveProfilePermissions(btn.dataset.saveProfile));
  });
}

async function saveProfilePermissions(id) {
  const roleEl = els.usersList?.querySelector(`[data-role-id='${id}']`);
  const activeEl = els.usersList?.querySelector(`[data-active-id='${id}']`);

  if (!roleEl || !activeEl) return;

  const role = roleEl.value;
  const is_active = activeEl.value === "true";

  const { error } = await state.client
    .from("profiles")
    .update({ role, is_active })
    .eq("id", id);

  if (error) return throwFriendly(error, "No pude actualizar permisos.");

  flash("Permisos actualizados.");
  await refreshAll();
}

function openNewProductDialog() {
  if (!canEdit()) return flash("Tu rol no puede crear productos.", true);

  els.productForm?.reset();
  if (els.productId) els.productId.value = "";
  if (els.productDialogTitle) els.productDialogTitle.textContent = "Nueva bebida";
  if (els.pFamilia) els.pFamilia.value = "bebidas";
  if (els.pCategoria) els.pCategoria.value = "";
  if (els.productDialog) els.productDialog.dataset.familia = "bebidas";

  tryOpenDialog();
}

function openNewMenajeDialog() {
  if (!canEdit()) return flash("Tu rol no puede crear menajes.", true);

  els.productForm?.reset();
  if (els.productId) els.productId.value = "";
  if (els.productDialogTitle) els.productDialogTitle.textContent = "Nuevo menaje";
  if (els.pFamilia) els.pFamilia.value = "menaje";
  if (els.productDialog) els.productDialog.dataset.familia = "menaje";

  const menajeCat = getMenajeCategories()[0];
  if (els.pCategoria && menajeCat) els.pCategoria.value = menajeCat.id;

  tryOpenDialog();
}

function openNewVariosDialog() {
  if (!canEdit()) return flash("Tu rol no puede crear artículos varios.", true);

  els.productForm?.reset();
  if (els.productId) els.productId.value = "";
  if (els.productDialogTitle) els.productDialogTitle.textContent = "Nuevo artículo varios";
  if (els.pFamilia) els.pFamilia.value = "varios";
  if (els.productDialog) els.productDialog.dataset.familia = "varios";

  const variosCat = getVariosCategories()[0];
  if (els.pCategoria && variosCat) els.pCategoria.value = variosCat.id;

  tryOpenDialog();
}

function tryOpenDialog() {
  try {
    if (typeof els.productDialog?.showModal === "function") {
      els.productDialog.showModal();
    } else {
      els.productDialog?.setAttribute("open", "open");
    }
  } catch (error) {
    console.error("Error abriendo modal:", error);
    flash("No pude abrir la ventana de edición.", true);
  }
}

function openEditProductDialog(id) {
  const p = state.productos.find(x => String(x.id) === String(id));
  if (!p) {
    return flash("No pude localizar el artículo para editar.", true);
  }

  if (els.productDialogTitle) els.productDialogTitle.textContent = "Editar producto";
  if (els.productId) els.productId.value = p.id || "";
  if (els.pStockCode) els.pStockCode.value = p.stock_code || "";
  if (els.pDescripcion) els.pDescripcion.value = p.descripcion || "";
  if (els.pPresentacion) els.pPresentacion.value = p.presentacion || "";
  if (els.pStDate) els.pStDate.value = p.st_date || "";
  if (els.pUnit) els.pUnit.value = p.unit || "";
  if (els.pCantidad) els.pCantidad.value = p.cantidad ?? 0;
  if (els.pMinStock) els.pMinStock.value = p.min_stock ?? 0;
  if (els.pPagina) els.pPagina.value = p.pagina ?? "";
  if (els.pFamilia) els.pFamilia.value = p.familia || "bebidas";
  if (els.pCategoria) els.pCategoria.value = p.categoria_id || "";
  if (els.pCantidadOriginal) els.pCantidadOriginal.value = p.cantidad_original || "";
  if (els.pDetalleCantidad) els.pDetalleCantidad.value = p.detalle_cantidad || "";
  if (els.productDialog) els.productDialog.dataset.familia = p.familia || "bebidas";

  tryOpenDialog();
}

async function onSaveProduct(e) {
  e.preventDefault();

  if (!canEdit() || !isActiveUser()) {
    return flash("No tienes permisos para editar productos.", true);
  }

  const payload = {
    stock_code: els.pStockCode?.value.trim() || null,
    descripcion: els.pDescripcion?.value.trim() || "",
    presentacion: els.pPresentacion?.value.trim() || null,
    st_date: els.pStDate?.value.trim() || null,
    unit: els.pUnit?.value.trim() || null,
    cantidad: Number(els.pCantidad?.value || 0),
    min_stock: Number(els.pMinStock?.value || 0),
    pagina: els.pPagina?.value ? Number(els.pPagina.value) : null,
    categoria_id: els.pCategoria?.value || null,
    cantidad_original: els.pCantidadOriginal?.value.trim() || null,
    detalle_cantidad: els.pDetalleCantidad?.value.trim() || null,
    familia: els.pFamilia?.value || els.productDialog?.dataset.familia || "bebidas"
  };

  if (!payload.descripcion) {
    return flash("La descripción es obligatoria.", true);
  }

  try {
    let result;

    if (els.productId?.value) {
      result = await state.client
        .from("productos")
        .update(payload)
        .eq("id", els.productId.value)
        .select()
        .single();
    } else {
      result = await state.client
        .from("productos")
        .insert([payload])
        .select()
        .single();
    }

    if (result.error) {
      return throwFriendly(result.error, "No pude guardar el producto.");
    }

    closeProductDialog();
    flash("Producto guardado.");
    await refreshAll();
  } catch (error) {
    throwFriendly(error, "Error inesperado al guardar el producto.");
  }
}

async function deleteProduct(id) {
  if (!isAdmin() || !isActiveUser()) {
    return flash("Solo admin puede borrar productos.", true);
  }

  if (!confirm("¿Seguro que quieres borrar este producto?")) return;

  try {
    const { error } = await state.client
      .from("productos")
      .delete()
      .eq("id", id);

    if (error) {
      return throwFriendly(error, "No pude borrar el producto.");
    }

    flash("Producto borrado.");
    await refreshAll();
  } catch (error) {
    throwFriendly(error, "Error inesperado al borrar el producto.");
  }
}

async function onSaveMovement(e) {
  e.preventDefault();

  if (!canEdit() || !isActiveUser()) {
    return flash("Tu rol no puede registrar movimientos.", true);
  }

  const productoId = els.movementProduct?.value;
  const producto = state.productos.find(p => String(p.id) === String(productoId));

  if (!producto) {
    return flash("Selecciona un producto.", true);
  }

  const tipo = els.movementType?.value;
  const qty = Number(els.movementQty?.value || 0);
  const motivo = els.movementReason?.value || null;
  const evento_ref = els.movementEvent?.value.trim() || null;
  const nota = els.movementNote?.value.trim() || null;
  const anterior = Number(producto.cantidad || 0);

  if (!qty || qty <= 0) {
    return flash("Introduce una cantidad mayor que 0.", true);
  }

  let nuevo = anterior;
  if (tipo === "entrada") nuevo = anterior + qty;
  if (tipo === "salida") nuevo = anterior - qty;
  if (tipo === "ajuste") nuevo = qty;

  if (nuevo < 0) {
    return flash("El stock no puede quedar negativo.", true);
  }

  try {
    const { error: updateError } = await state.client
      .from("productos")
      .update({ cantidad: nuevo })
      .eq("id", producto.id);

    if (updateError) {
      return throwFriendly(updateError, "No pude actualizar el stock.");
    }

    const { error: moveError } = await state.client
      .from("movimientos")
      .insert([{
        producto_id: producto.id,
        tipo,
        cantidad: qty,
        stock_anterior: anterior,
        stock_nuevo: nuevo,
        motivo,
        evento_ref,
        nota,
        created_by: state.user.id
      }]);

    if (moveError) {
      return throwFriendly(moveError, "No pude guardar el movimiento.");
    }

    els.movementForm?.reset();
    flash("Movimiento guardado.");
    await refreshAll();
  } catch (error) {
    throwFriendly(error, "Error inesperado al guardar el movimiento.");
  }
}

async function importInitialData() {
  if (!isAdmin() || !isActiveUser()) {
    return flash("Solo admin puede importar la carga inicial.", true);
  }

  if (!confirm("Esto importará o actualizará la carga inicial de bebidas desde data.json. ¿Continuar?")) return;

  try {
    const raw = await fetch("data.json").then(r => r.json());

    const names = [...new Set(raw.map(x => (x.categoria || "Otros").trim()).filter(Boolean))];
    if (names.length) {
      const { error } = await state.client
        .from("categorias")
        .upsert(names.map(nombre => ({ nombre })), { onConflict: "nombre" });

      if (error) throw error;
    }

    await loadCategorias();
    const catMap = Object.fromEntries(state.categorias.map(c => [c.nombre, c.id]));

    const productos = raw.map(r => ({
      stock_code: cleanVal(r.stock_code),
      descripcion: cleanVal(r.descripcion) || "Sin descripción",
      presentacion: cleanVal(r.presentacion),
      st_date: cleanVal(r.st_date),
      unit: cleanVal(r.unit),
      cantidad: Number(r.cantidad || 0),
      cantidad_original: cleanVal(r.cantidad_original),
      detalle_cantidad: cleanVal(r.detalle_cantidad),
      pagina: r.pagina ? Number(r.pagina) : null,
      min_stock: Number(r.min_stock || 0),
      categoria_id: catMap[(r.categoria || "Otros").trim()] || null,
      familia: "bebidas"
    }));

    const chunkSize = 200;
    for (let i = 0; i < productos.length; i += chunkSize) {
      const chunk = productos.slice(i, i + chunkSize);
      const { error } = await state.client
        .from("productos")
        .upsert(chunk, { onConflict: "stock_code" });

      if (error) throw error;
    }

    flash("Importación inicial de bebidas completada.");
    await refreshAll();
  } catch (error) {
    throwFriendly(error, "Falló la importación inicial de bebidas.");
  }
}

async function importMenajesData() {
  if (!isAdmin() || !isActiveUser()) {
    return flash("Solo admin puede importar menajes.", true);
  }

  if (!confirm("Esto importará o actualizará el inventario de menajes desde data_menajes.json. ¿Continuar?")) return;

  try {
    const raw = await fetch("data_menajes.json").then(r => r.json());

    const names = [...new Set(raw.map(x => (x.categoria || "Menajes").trim()).filter(Boolean))];
    if (names.length) {
      const { error: catError } = await state.client
        .from("categorias")
        .upsert(names.map(nombre => ({ nombre })), { onConflict: "nombre" });

      if (catError) throw catError;
    }

    await loadCategorias();
    const catMap = Object.fromEntries(state.categorias.map(c => [c.nombre, c.id]));

    const productos = raw.map(r => ({
      stock_code: cleanVal(r.stock_code),
      descripcion: cleanVal(r.descripcion) || "Sin descripción",
      presentacion: cleanVal(r.presentacion),
      st_date: cleanVal(r.st_date),
      unit: cleanVal(r.unit) || "ud",
      cantidad: Number(r.cantidad || 0),
      cantidad_original: cleanVal(r.cantidad_original),
      detalle_cantidad: cleanVal(r.detalle_cantidad),
      pagina: r.pagina ? Number(r.pagina) : null,
      min_stock: Number(r.min_stock || 0),
      categoria_id: catMap[(r.categoria || "Menajes").trim()] || null,
      familia: "menaje"
    }));

    const chunkSize = 200;
    for (let i = 0; i < productos.length; i += chunkSize) {
      const chunk = productos.slice(i, i + chunkSize);
      const { error } = await state.client
        .from("productos")
        .upsert(chunk, { onConflict: "stock_code" });

      if (error) throw error;
    }

    flash("Importación de menajes completada.");
    await refreshAll();
  } catch (error) {
    throwFriendly(error, "Falló la importación de menajes.");
  }
}

function printInventorySheet(familia) {
  let rows = [];
  let title = "";

  if (familia === "bebidas") {
    rows = getFilteredProducts();
    title = "Inventario de Bebidas";
  }

  if (familia === "menaje") {
    rows = getFilteredMenajes();
    title = "Inventario de Menaje";
  }

  if (familia === "varios") {
    rows = getFilteredVarios();
    title = "Inventario de Varios";
  }

  const today = new Date().toLocaleDateString("es-ES");

  const tableRows = rows.map(p => `
    <tr>
      <td>${escapeHtml(p.stock_code || "")}</td>
      <td>${escapeHtml(p.descripcion || "")}</td>
      <td>${escapeHtml(p.categorias?.nombre || "Sin categoría")}</td>
      <td>${escapeHtml(p.unit || "")}</td>
      <td>${formatNum(p.cantidad || 0)}</td>
      <td>${formatNum(p.min_stock || 0)}</td>
      <td></td>
      <td></td>
    </tr>
  `).join("");

  const printWindow = window.open("", "_blank", "width=1200,height=800");

  if (!printWindow) {
    return flash("El navegador bloqueó la ventana de impresión.", true);
  }

  printWindow.document.write(`
    <html>
      <head>
        <title>${title}</title>
        <style>
          body{
            font-family: Arial, Helvetica, sans-serif;
            margin: 24px;
            color: #10233a;
          }
          h1{
            margin: 0 0 6px;
            font-size: 24px;
          }
          .meta{
            margin-bottom: 18px;
            color: #4b5f75;
            font-size: 13px;
          }
          table{
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
          }
          th, td{
            border: 1px solid #cfd9e3;
            padding: 8px 10px;
            text-align: left;
            vertical-align: top;
          }
          th{
            background: #eef4fb;
            text-transform: uppercase;
            font-size: 11px;
            letter-spacing: .03em;
          }
          .sign-row{
            margin-top: 28px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
          }
          .sign-box{
            margin-top: 40px;
            border-top: 1px solid #7f8fa3;
            padding-top: 8px;
            font-size: 12px;
          }
          @media print{
            body{ margin: 12mm; }
          }
        </style>
      </head>
      <body>
        <h1>${title}</h1>
        <div class="meta">
          Fecha: ${today} · Total artículos: ${rows.length}
        </div>

        <table>
          <thead>
            <tr>
              <th>Código</th>
              <th>Descripción</th>
              <th>Categoría</th>
              <th>Unidad</th>
              <th>Stock sistema</th>
              <th>Mínimo</th>
              <th>Conteo físico</th>
              <th>Observaciones</th>
            </tr>
          </thead>
          <tbody>
            ${tableRows || `<tr><td colspan="8">No hay artículos para imprimir.</td></tr>`}
          </tbody>
        </table>

        <div class="sign-row">
          <div class="sign-box">Responsable de conteo</div>
          <div class="sign-box">Supervisor / validación</div>
        </div>

        <script>
          window.onload = function() {
            window.print();
          };
        </script>
      </body>
    </html>
  `);

  printWindow.document.close();
}

function printFullInventoryByFamily() {
  const all = [...state.productos].sort((a, b) =>
    (a.descripcion || "").localeCompare((b.descripcion || ""), "es", { sensitivity: "base" })
  );

  const bebidas = all.filter(p => (p.familia || "bebidas") === "bebidas");
  const menaje = all.filter(p => p.familia === "menaje");
  const varios = all.filter(p => p.familia === "varios");

  const today = new Date().toLocaleDateString("es-ES");

  const makeRows = rows => {
    return rows.map(p => `
      <tr>
        <td>${escapeHtml(p.stock_code || "")}</td>
        <td>${escapeHtml(p.descripcion || "")}</td>
        <td>${escapeHtml(p.categorias?.nombre || "Sin categoría")}</td>
        <td>${escapeHtml(p.unit || "")}</td>
        <td>${formatNum(p.cantidad || 0)}</td>
        <td>${formatNum(p.min_stock || 0)}</td>
        <td></td>
        <td></td>
      </tr>
    `).join("");
  };

  const sectionHtml = (title, rows) => `
    <section class="print-section">
      <h2>${title}</h2>
      <table>
        <thead>
          <tr>
            <th>Código</th>
            <th>Descripción</th>
            <th>Categoría</th>
            <th>Unidad</th>
            <th>Stock sistema</th>
            <th>Mínimo</th>
            <th>Conteo físico</th>
            <th>Observaciones</th>
          </tr>
        </thead>
        <tbody>
          ${rows.length ? makeRows(rows) : `<tr><td colspan="8">No hay artículos en esta familia.</td></tr>`}
        </tbody>
      </table>
    </section>
  `;

  const printWindow = window.open("", "_blank", "width=1280,height=900");

  if (!printWindow) {
    return flash("El navegador bloqueó la ventana de impresión.", true);
  }

  printWindow.document.write(`
    <html>
      <head>
        <title>Inventario completo por familias</title>
        <style>
          body{
            font-family: Arial, Helvetica, sans-serif;
            margin: 24px;
            color: #10233a;
          }
          h1{
            margin: 0 0 6px;
            font-size: 24px;
          }
          h2{
            margin: 28px 0 10px;
            font-size: 18px;
            color: #132235;
            border-bottom: 2px solid #d8e2ec;
            padding-bottom: 6px;
          }
          .meta{
            margin-bottom: 18px;
            color: #4b5f75;
            font-size: 13px;
          }
          .summary{
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin: 18px 0 22px;
          }
          .summary-box{
            border: 1px solid #d6e0ea;
            border-radius: 10px;
            padding: 12px 14px;
            background: #f8fbff;
          }
          .summary-box strong{
            display: block;
            font-size: 20px;
            margin-top: 4px;
          }
          table{
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
            margin-bottom: 12px;
          }
          th, td{
            border: 1px solid #cfd9e3;
            padding: 8px 10px;
            text-align: left;
            vertical-align: top;
          }
          th{
            background: #eef4fb;
            text-transform: uppercase;
            font-size: 11px;
            letter-spacing: .03em;
          }
          .print-section{
            margin-bottom: 24px;
          }
          .sign-row{
            margin-top: 30px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
          }
          .sign-box{
            margin-top: 40px;
            border-top: 1px solid #7f8fa3;
            padding-top: 8px;
            font-size: 12px;
          }
          @media print{
            body{ margin: 10mm; }
            .print-section{ page-break-inside: avoid; }
          }
        </style>
      </head>
      <body>
        <h1>Inventario completo por familias</h1>
        <div class="meta">
          Fecha: ${today} · Total artículos: ${all.length}
        </div>

        <div class="summary">
          <div class="summary-box">
            Bebidas
            <strong>${bebidas.length}</strong>
          </div>
          <div class="summary-box">
            Menaje
            <strong>${menaje.length}</strong>
          </div>
          <div class="summary-box">
            Varios
            <strong>${varios.length}</strong>
          </div>
        </div>

        ${sectionHtml("Bebidas", bebidas)}
        ${sectionHtml("Menaje", menaje)}
        ${sectionHtml("Varios", varios)}

        <div class="sign-row">
          <div class="sign-box">Responsable de inventario</div>
          <div class="sign-box">Supervisor / validación</div>
        </div>

        <script>
          window.onload = function() {
            window.print();
          };
        </script>
      </body>
    </html>
  `);

  printWindow.document.close();
}
function roleToBadge(role) {
  return role === "admin" ? "danger" : role === "editor" ? "warning" : "neutral";
}

function isAdmin() {
  return state.profile?.role === "admin";
}

function canEdit() {
  return ["admin", "editor"].includes(state.profile?.role);
}

function isActiveUser() {
  return state.profile?.is_active !== false;
}

function cleanVal(v) {
  const s = (v ?? "").toString().trim();
  return s || null;
}


function formatNum(n) {
  return new Intl.NumberFormat("es-ES", { maximumFractionDigits: 2 }).format(Number(n || 0));
}

function formatDate(v) {
  return v ? new Date(v).toLocaleString("es-ES") : "";
}

function formatMovementReason(value) {
  const map = {
    compra_proveedor: "Compra proveedor",
    reposicion_interna: "Reposición interna",
    salida_evento: "Salida a evento",
    consumo_interno: "Consumo interno",
    rotura: "Rotura",
    merma: "Merma",
    ajuste_inventario: "Ajuste inventario",
    devolucion: "Devolución",
    otro: "Otro"
  };

  return map[value] || value || "";
}

function escapeHtml(value) {
  return String(value ?? "").replace(/[&<>'"]/g, ch => ({
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    "'": "&#39;",
    "\"": "&quot;"
  }[ch]));
}

function renderEmpty(container, text) {
  const div = document.createElement("div");
  div.className = "empty-state";
  div.textContent = text;
  container.appendChild(div);
}

function flash(msg, isError = false) {
  if (els.authStatus) {
    els.authStatus.textContent = msg;
    els.authStatus.className = `alert ${isError ? "error" : "success"}`;
  }

  if (els.appShell && !els.appShell.classList.contains("hidden")) {
    setConnectionState(isError ? "danger" : "success", isError ? "Aviso" : "OK", msg);
  }
}

function throwFriendly(error, fallback) {
  console.error(error);
  flash(`${fallback}${error?.message ? " · " + error.message : ""}`, true);
}

function registerServiceWorker() {
  return;
}

function setupInstallPrompt() {
  return;
}

async function installApp() {
  return;
}
