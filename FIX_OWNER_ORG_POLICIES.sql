-- Corrige políticas: proprietário pode editar/excluir a própria empresa
drop policy if exists "Platform admins update organizations" on public.organizations;
drop policy if exists "Platform admins delete organizations" on public.organizations;
drop policy if exists "Owners and admins update organizations" on public.organizations;
drop policy if exists "Owners and admins delete organizations" on public.organizations;

create policy "Owners and admins update organizations" on public.organizations
  for update to authenticated using (public.is_org_owner(id) or public.is_platform_admin())
  with check (public.is_org_owner(id) or public.is_platform_admin());

create policy "Owners and admins delete organizations" on public.organizations
  for delete to authenticated using (public.is_org_owner(id) or public.is_platform_admin());
