const STORAGE_KEY = "inventario.supabase.config.v2";

const state = {
  client: null,
  session: null,
  user: null,
  profile: null,
  categorias: [],
  productos: [],
  movimientos: [],
  perfiles: [],
  ready: false,
};

const els = {};

window.addEventListener("DOMContentLoaded", init);

async function init() {
  captureEls();
  bindUI();
  loadSavedConfig();
  await initSupabaseFromConfig();
}

function captureEls() {
  [
    "authShell", "appShell", "authStatus", "loginForm", "registerForm", "configForm", "supabaseUrl", "supabaseKey",
    "btnTestConnection", "btnClearConfig", "btnOpenSetup", "btnTestConnection2", "btnLogout", "btnBootstrapAdmin",
    "userName", "userEmail", "roleBadge", "activeBadge", "connectionBadge", "connectionText", "viewTitle", "viewSubtitle",
    "btnRefresh", "btnSeed", "searchInput", "categoryFilter", "stockFilter", "btnNewProduct", "productsTable", "criticalList",
    "recentMoves", "movementForm", "movementProduct", "movementType", "movementQty", "movementNote", "movementHistory",
    "productDialog", "productForm", "productDialogTitle", "btnCloseDialog", "productId", "pStockCode", "pDescripcion",
    "pPresentacion", "pStDate", "pUnit", "pCantidad", "pMinStock", "pPagina", "pCategoria", "pCantidadOriginal",
    "pDetalleCantidad", "kpiProductos", "kpiStock", "kpiBajoMinimo", "kpiSinStock", "cfgPreviewUrl", "cfgPreviewSession",
    "cfgPreviewRole", "navAdmin", "usersList"
  ].forEach(id => {
    els[id] = document.getElementById(id);
  });
}

function bindUI() {
  document.querySelectorAll(".nav-btn").forEach(btn => {
    btn.addEventListener("click", () => switchView(btn.dataset.view));
  });

  document.querySelectorAll("[data-auth-tab]").forEach(btn => {
    btn.addEventListener("click", () => switchAuthTab(btn.dataset.authTab));
  });

  els.configForm?.addEventListener("submit", onSaveConfig);
  els.btnTestConnection?.addEventListener("click", onTestConnection);
  els.btnClearConfig?.addEventListener("click", clearConfig);
  els.btnOpenSetup?.addEventListener("click", () => showAuth("Editar conexión de Supabase"));
  els.btnTestConnection2?.addEventListener("click", onTestConnection);
  els.loginForm?.addEventListener("submit", onLogin);
  els.registerForm?.addEventListener("submit", onRegister);
  els.btnLogout?.addEventListener("click", onLogout);
  els.btnBootstrapAdmin?.addEventListener("click", onBootstrapAdmin);
  els.btnRefresh?.addEventListener("click", refreshAll);
  els.btnSeed?.addEventListener("click", importInitialData);

  [els.searchInput, els.categoryFilter, els.stockFilter].forEach(el => {
    el?.addEventListener("input", renderProducts);
  });

  els.btnNewProduct?.addEventListener("click", openNewProductDialog);

  els.btnCloseDialog?.addEventListener("click", () => {
    if (els.productDialog?.open) els.productDialog.close();
  });

  els.productForm?.addEventListener("submit", onSaveProduct);
  els.movementForm?.addEventListener("submit", onSaveMovement);
}

function switchAuthTab(tab) {
  document.querySelectorAll("[data-auth-tab]").forEach(btn => {
    btn.classList.toggle("active", btn.dataset.authTab === tab);
  });

  document.querySelectorAll(".auth-tab").forEach((panel, idx) => {
    panel.classList.toggle("active", (tab === "login" && idx === 0) || (tab === "register" && idx === 1));
  });
}

function saveConfig(url, key) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify({ url, key }));
}

function loadSavedConfig() {
  const cfg = readConfig();
  if (els.supabaseUrl) els.supabaseUrl.value = cfg.url || "";
  if (els.supabaseKey) els.supabaseKey.value = cfg.key || "";
  if (els.cfgPreviewUrl) els.cfgPreviewUrl.textContent = cfg.url || "—";
}

function readConfig() {
  const fromStorage = safeJSON(localStorage.getItem(STORAGE_KEY)) || {};
  const fromWindow = window.APP_CONFIG || {};
  return {
    url: fromStorage.url || fromWindow.SUPABASE_URL || "",
    key: fromStorage.key || fromWindow.SUPABASE_ANON_KEY || "",
  };
}

function safeJSON(s) {
  try {
    return JSON.parse(s);
  } catch {
    return null;
  }
}

async function initSupabaseFromConfig() {
  const { url, key } = readConfig();
  if (!url || !key) {
    showAuth("Falta configurar Supabase.");
    return;
  }

  try {
    await initSupabase(url, key);
  } catch (e) {
    showAuth(e.message || "No se pudo iniciar Supabase.", true);
  }
}

async function initSupabase(url, key) {
  state.client = supabase.createClient(url.trim(), key.trim());

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
    state.ready = true;
    renderSessionState();
    showAuth("Accede con tu cuenta para continuar.");
    return;
  }

  await loadProfile();
  state.ready = true;
  renderSessionState();
  showApp();
  await refreshAll();
  await evaluateBootstrapVisibility();
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
  if (els.btnSeed) els.btnSeed.disabled = !isAdmin() || !active;

  if (els.movementForm) {
    els.movementForm.querySelectorAll("input,select,textarea,button").forEach(el => {
      el.disabled = !canWrite || !active;
    });
  }

  document.querySelectorAll(".requires-admin").forEach(el => {
    el.classList.toggle("hidden", !isAdmin());
  });

  if (!active) {
    setConnectionState("danger", "Usuario inactivo", "Tu acceso está bloqueado. Contacta con un administrador.");
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

async function onSaveConfig(e) {
  e.preventDefault();

  const url = els.supabaseUrl?.value.trim();
  const key = els.supabaseKey?.value.trim();

  if (!url || !key) return flash("Completa URL y anon key.", true);

  saveConfig(url, key);
  loadSavedConfig();

  try {
    await initSupabase(url, key);
    flash("Conexión guardada.");
  } catch (error) {
    throwFriendly(error, "No se pudo guardar la conexión.");
  }
}

async function onTestConnection() {
  const { url, key } = readConfig();
  if (!url || !key) return flash("Primero guarda la configuración de Supabase.", true);

  try {
    const client = supabase.createClient(url.trim(), key.trim());
    const { error } = await client.from("categorias").select("id").limit(1);
    if (error) throw error;
    flash("Conexión correcta con Supabase.");
  } catch (error) {
    throwFriendly(error, "La conexión falló. Revisa URL, anon key o schema.sql.");
  }
}

function clearConfig() {
  localStorage.removeItem(STORAGE_KEY);
  if (els.supabaseUrl) els.supabaseUrl.value = "";
  if (els.supabaseKey) els.supabaseKey.value = "";
  flash("Configuración borrada.");
}

async function onLogin(e) {
  e.preventDefault();
  if (!state.client) return flash("Configura Supabase primero.", true);

  const loginEmailEl = document.getElementById("loginEmail");
  const loginPasswordEl = document.getElementById("loginPassword");
  const email = loginEmailEl?.value?.trim() || "";
  const password = loginPasswordEl?.value || "";

  if (!email || !password) return flash("Completa email y contraseña.", true);

  const submitBtn = els.loginForm?.querySelector('button[type="submit"]');
  if (submitBtn) submitBtn.disabled = true;

  try {
    const { error } = await state.client.auth.signInWithPassword({ email, password });
    if (error) return throwFriendly(error, "No pude iniciar sesión.");
    flash("Sesión iniciada.");
    els.loginForm?.reset();
  } finally {
    if (submitBtn) submitBtn.disabled = false;
  }
}

async function onRegister(e) {
  e.preventDefault();
  if (!state.client) return flash("Configura Supabase primero.", true);

  const registerEmailEl = document.getElementById("registerEmail");
  const registerPasswordEl = document.getElementById("registerPassword");
  const registerNameEl = document.getElementById("registerName");

  const email = registerEmailEl?.value?.trim() || "";
  const password = registerPasswordEl?.value || "";
  const fullName = registerNameEl?.value?.trim() || "";

  if (!email || !password) return flash("Completa email y contraseña.", true);
  if (password.length < 6) return flash("La contraseña debe tener al menos 6 caracteres.", true);

  const submitBtn = els.registerForm?.querySelector('button[type="submit"]');
  if (submitBtn) submitBtn.disabled = true;

  try {
    const { data, error } = await state.client.auth.signUp({
      email,
      password,
      options: {
        data: { full_name: fullName || email.split("@")[0] },
        emailRedirectTo: "https://raymonchu48.github.io/App_Inventarios/",
      }
    });

    if (error) return throwFriendly(error, "No pude crear la cuenta.");

    const createdUserId = data?.user?.id;
    if (createdUserId) {
      const { error: profileError } = await state.client
        .from("profiles")
        .upsert({
          id: createdUserId,
          email,
          full_name: fullName || email.split("@")[0],
          role: "viewer",
          is_active: true,
        }, { onConflict: "id" });

      if (profileError) {
        console.warn("No pude crear el perfil automáticamente:", profileError);
      }
    }

    flash("Cuenta creada. Revisa tu email si Supabase pide verificación y luego entra.");
    switchAuthTab("login");
    els.registerForm?.reset();
  } finally {
    if (submitBtn) submitBtn.disabled = false;
  }
}

async function onLogout() {
  if (!state.client) return;
  const { error } = await state.client.auth.signOut();
  if (error) return throwFriendly(error, "No pude cerrar sesión.");
  showAuth("Sesión cerrada.");
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

  if (isAdmin()) switchView("admin");
  flash("Ahora eres admin inicial del sistema.");
}

function switchView(view) {
  if ((view === "configuracion" || view === "admin") && !isAdmin()) {
    flash("No tienes permisos para acceder a esa sección.", true);
    return;
  }

  const titles = {
    dashboard: ["Dashboard", "Resumen ejecutivo del inventario."],
    productos: ["Productos", "Alta, edición y consulta con permisos por rol."],
    movimientos: ["Movimientos", "Entradas, salidas y ajustes con trazabilidad."],
    admin: ["Administración", "Usuarios, roles y activación de accesos."],
    configuracion: ["Configuración", "Estado de conexión, sesión y despliegue."]
  };

  document.querySelectorAll(".view").forEach(v => {
    v.classList.toggle("active", v.id === `view-${view}`);
  });

  document.querySelectorAll(".nav-btn").forEach(b => {
    b.classList.toggle("active", b.dataset.view === view);
  });

  if (titles[view] && els.viewTitle && els.viewSubtitle) {
    els.viewTitle.textContent = titles[view][0];
    els.viewSubtitle.textContent = titles[view][1];
  }
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
  populateProductSelects();
  renderDashboard();
  renderProducts();
  renderMovementHistory();

  if (isAdmin()) renderUsersList();
}

function ensureReady() {
  if (!state.user || !state.client) {
    flash("Primero inicia sesión.", true);
    return false;
  }

  if (!isActiveUser()) {
    flash("Tu usuario está inactivo. Solo puedes consultar, no editar.", true);
  }

  return true;
}

async function loadCategorias() {
  const { data, error } = await state.client.from("categorias").select("*").order("nombre");
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
  const { data, error } = await state.client.from("profiles").select("*").order("created_at");
  if (error) return throwFriendly(error, "No pude cargar perfiles.");
  state.perfiles = data || [];
}

function renderDashboard() {
  const totalProductos = state.productos.length;
  const stockTotal = state.productos.reduce((acc, p) => acc + Number(p.cantidad || 0), 0);
  const bajos = state.productos.filter(p => Number(p.cantidad || 0) <= Number(p.min_stock || 0)).length;
  const sin = state.productos.filter(p => Number(p.cantidad || 0) <= 0).length;

  if (els.kpiProductos) els.kpiProductos.textContent = totalProductos;
  if (els.kpiStock) els.kpiStock.textContent = formatNum(stockTotal);
  if (els.kpiBajoMinimo) els.kpiBajoMinimo.textContent = bajos;
  if (els.kpiSinStock) els.kpiSinStock.textContent = sin;

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

  if (!rows.length) return renderEmpty(els.criticalList, "No hay productos críticos.");

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

  if (!state.movimientos.length) return renderEmpty(els.recentMoves, "Todavía no hay movimientos.");

  state.movimientos.slice(0, 8).forEach(m => {
    const color = m.tipo === "salida" ? "danger" : m.tipo === "ajuste" ? "warn" : "ok";
    const div = document.createElement("div");
    div.className = "item";
    div.innerHTML = `<strong>${escapeHtml(m.productos?.descripcion || "Producto")} <span class="tag ${color}">${escapeHtml(m.tipo)}</span></strong><small>${formatNum(m.cantidad)} · ${formatDate(m.created_at)}${m.nota ? " · " + escapeHtml(m.nota) : ""}</small>`;
    els.recentMoves.appendChild(div);
  });
}

function populateCategoryFilters() {
  if (!els.categoryFilter || !els.pCategoria) return;

  const current = els.categoryFilter.value;
  els.categoryFilter.innerHTML = `<option value="">Todas las categorías</option>`;
  els.pCategoria.innerHTML = `<option value="">Sin categoría</option>`;

  state.categorias.forEach(c => {
    els.categoryFilter.insertAdjacentHTML("beforeend", `<option value="${c.id}">${escapeHtml(c.nombre)}</option>`);
    els.pCategoria.insertAdjacentHTML("beforeend", `<option value="${c.id}">${escapeHtml(c.nombre)}</option>`);
  });

  els.categoryFilter.value = current;
}

function populateProductSelects() {
  if (!els.movementProduct) return;

  const current = els.movementProduct.value;
  els.movementProduct.innerHTML = `<option value="">Selecciona un producto</option>`;

  state.productos.forEach(p => {
    els.movementProduct.insertAdjacentHTML("beforeend", `<option value="${p.id}">${escapeHtml(p.descripcion)} · ${formatNum(p.cantidad)}</option>`);
  });

  if (current) els.movementProduct.value = current;
}

function getFilteredProducts() {
  const q = els.searchInput?.value.trim().toLowerCase() || "";
  const cat = els.categoryFilter?.value || "";
  const stockMode = els.stockFilter?.value || "";

  return state.productos.filter(p => {
    const matchText = !q || [p.stock_code, p.descripcion, p.presentacion].some(v => (v || "").toLowerCase().includes(q));
    const matchCat = !cat || p.categoria_id === cat;
    const qty = Number(p.cantidad || 0);
    const min = Number(p.min_stock || 0);
    const matchStock =
      !stockMode ||
      (stockMode === "low" && qty <= min) ||
      (stockMode === "out" && qty <= 0) ||
      (stockMode === "ok" && qty > min);

    return matchText && matchCat && matchStock;
  });
}

function renderProducts() {
  if (!els.productsTable) return;

  const rows = getFilteredProducts();
  els.productsTable.innerHTML = "";

  if (!rows.length) {
    els.productsTable.innerHTML = `<tr><td colspan="8"><div class="empty-state">No hay productos para ese filtro.</div></td></tr>`;
    return;
  }

  rows.forEach(p => {
    const qty = Number(p.cantidad || 0);
    const min = Number(p.min_stock || 0);
    const statusClass = qty <= 0 ? "danger" : qty <= min ? "warn" : "ok";
    const canWrite = canEdit() && isActiveUser();

    const tr = document.createElement("tr");
    tr.innerHTML = `
      <td>${escapeHtml(p.stock_code || "")}</td>
      <td><strong>${escapeHtml(p.descripcion)}</strong><br><small class="muted">${escapeHtml(p.presentacion || "")}</small></td>
      <td>${escapeHtml(p.categorias?.nombre || "Sin categoría")}</td>
      <td>${escapeHtml(p.unit || "")}</td>
      <td><span class="tag ${statusClass}">${formatNum(qty)}</span></td>
      <td>${formatNum(min)}</td>
      <td>${p.pagina ?? ""}</td>
      <td>
        <div class="actions">
          <button class="btn-mini" data-action="edit" data-id="${p.id}" ${canWrite ? "" : "disabled"}>Editar</button>
          <button class="btn-mini danger" data-action="delete" data-id="${p.id}" ${isAdmin() && isActiveUser() ? "" : "disabled"}>Borrar</button>
        </div>
      </td>`;

    els.productsTable.appendChild(tr);
  });

  els.productsTable.querySelectorAll("[data-action='edit']").forEach(btn => {
    btn.addEventListener("click", () => openEditProductDialog(btn.dataset.id));
  });

  els.productsTable.querySelectorAll("[data-action='delete']").forEach(btn => {
    btn.addEventListener("click", () => deleteProduct(btn.dataset.id));
  });
}

function renderMovementHistory() {
  if (!els.movementHistory) return;

  els.movementHistory.innerHTML = "";

  if (!state.movimientos.length) {
    return renderEmpty(els.movementHistory, "No hay movimientos registrados.");
  }

  state.movimientos.forEach(m => {
    const div = document.createElement("div");
    div.className = "item";
    div.innerHTML = `<strong>${escapeHtml(m.productos?.descripcion || "Producto")} · ${escapeHtml(m.tipo)}</strong><small>${formatNum(m.cantidad)} · stock ${formatNum(m.stock_anterior)} → ${formatNum(m.stock_nuevo)} · ${formatDate(m.created_at)}${m.nota ? " · " + escapeHtml(m.nota) : ""}</small>`;
    els.movementHistory.appendChild(div);
  });
}

function renderUsersList() {
  if (!els.usersList) return;

  els.usersList.innerHTML = "";

  if (!state.perfiles.length) return renderEmpty(els.usersList, "No hay usuarios.");

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
      <button class="btn ghost" data-save-profile="${profile.id}">Guardar</button>`;

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
  if (els.productDialogTitle) els.productDialogTitle.textContent = "Nuevo producto";
  els.productDialog?.showModal();
}

function openEditProductDialog(id) {
  const p = state.productos.find(x => x.id === id);
  if (!p) return;

  if (els.productDialogTitle) els.productDialogTitle.textContent = "Editar producto";
  if (els.productId) els.productId.value = p.id;
  if (els.pStockCode) els.pStockCode.value = p.stock_code || "";
  if (els.pDescripcion) els.pDescripcion.value = p.descripcion || "";
  if (els.pPresentacion) els.pPresentacion.value = p.presentacion || "";
  if (els.pStDate) els.pStDate.value = p.st_date || "";
  if (els.pUnit) els.pUnit.value = p.unit || "";
  if (els.pCantidad) els.pCantidad.value = p.cantidad ?? 0;
  if (els.pMinStock) els.pMinStock.value = p.min_stock ?? 0;
  if (els.pPagina) els.pPagina.value = p.pagina ?? "";
  if (els.pCategoria) els.pCategoria.value = p.categoria_id || "";
  if (els.pCantidadOriginal) els.pCantidadOriginal.value = p.cantidad_original || "";
  if (els.pDetalleCantidad) els.pDetalleCantidad.value = p.detalle_cantidad || "";

  els.productDialog?.showModal();
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
  };

  if (!payload.descripcion) {
    return flash("La descripción es obligatoria.", true);
  }

  console.log("Payload producto:", payload);

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

  const { data, error } = result;

  if (error) {
    console.error("Error guardando producto:", error);
    return flash(`No pude guardar el producto: ${error.message}`, true);
  }

  console.log("Producto guardado:", data);

  if (els.productDialog?.open) els.productDialog.close();
  flash("Producto guardado.");
  await refreshAll();
}

async function deleteProduct(id) {
  if (!isAdmin() || !isActiveUser()) return flash("Solo admin puede borrar productos.", true);
  if (!confirm("¿Seguro que quieres borrar este producto?")) return;

  const { error } = await state.client.from("productos").delete().eq("id", id);
  if (error) return throwFriendly(error, "No pude borrar el producto.");

  flash("Producto borrado.");
  await refreshAll();
}

async function onSaveMovement(e) {
  e.preventDefault();

  if (!canEdit() || !isActiveUser()) {
    return flash("Tu rol no puede registrar movimientos.", true);
  }

  const producto = state.productos.find(p => p.id === els.movementProduct?.value);
  if (!producto) return flash("Selecciona un producto.", true);

  const tipo = els.movementType?.value;
  const qty = Number(els.movementQty?.value || 0);
  const nota = els.movementNote?.value.trim() || null;
  const anterior = Number(producto.cantidad || 0);

  let nuevo = anterior;
  if (tipo === "entrada") nuevo = anterior + qty;
  if (tipo === "salida") nuevo = anterior - qty;
  if (tipo === "ajuste") nuevo = qty;

  if (nuevo < 0) return flash("El stock no puede quedar negativo.", true);

  const { error: updateError } = await state.client
    .from("productos")
    .update({ cantidad: nuevo })
    .eq("id", producto.id);

  if (updateError) return throwFriendly(updateError, "No pude actualizar el stock.");

  const { error: moveError } = await state.client
    .from("movimientos")
    .insert([{
      producto_id: producto.id,
      tipo,
      cantidad: qty,
      stock_anterior: anterior,
      stock_nuevo: nuevo,
      nota,
      created_by: state.user.id
    }]);

  if (moveError) return throwFriendly(moveError, "No pude guardar el movimiento.");

  els.movementForm?.reset();
  flash("Movimiento guardado.");
  await refreshAll();
}

async function importInitialData() {
  if (!isAdmin() || !isActiveUser()) return flash("Solo admin puede importar la carga inicial.", true);
  if (!confirm("Esto insertará o actualizará categorías y productos del Excel convertido. ¿Continuar?")) return;

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
      categoria_id: catMap[(r.categoria || "Otros").trim()] || null
    }));

    const chunkSize = 200;

    for (let i = 0; i < productos.length; i += chunkSize) {
      const chunk = productos.slice(i, i + chunkSize);
      const { error } = await state.client
        .from("productos")
        .upsert(chunk, { onConflict: "stock_code" });

      if (error) throw error;
    }

    flash("Importación inicial completada.");
    await refreshAll();
  } catch (error) {
    throwFriendly(error, "Falló la importación inicial.");
  }
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
