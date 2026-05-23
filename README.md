# 🚗 Auto Money CRM

Sistema de gestão interno da Auto Money — loja de veículos.

## Stack
- **Frontend:** HTML + CSS + JavaScript puro
- **Banco de dados:** Supabase (PostgreSQL)
- **Hospedagem:** Netlify

---

## ⚙️ Como configurar (passo a passo)

### 1. Criar conta no Supabase
1. Acesse https://supabase.com e clique em **Start for free**
2. Crie uma conta com GitHub (mais fácil)
3. Clique em **New Project**
4. Dê o nome: `automoney-crm`
5. Crie uma senha forte para o banco (guarde ela)
6. Região: **South America (São Paulo)**
7. Clique em **Create new project** e aguarde ~2 minutos

### 2. Criar as tabelas no Supabase
1. No painel do Supabase, clique em **SQL Editor** (ícone de código)
2. Clique em **New query**
3. Cole TODO o conteúdo do arquivo `supabase/schema.sql`
4. Clique em **Run** (ou Ctrl+Enter)
5. Deve aparecer "Success" para cada tabela

### 3. Pegar as credenciais do Supabase
1. No painel, vá em **Settings → API**
2. Copie:
   - **Project URL** (ex: https://xyzabc.supabase.co)
   - **anon public key** (chave longa)
3. Abra o arquivo `index.html`
4. Encontre as linhas no topo do JavaScript:
   ```
   var SUPA_URL = 'COLE_SUA_URL_AQUI';
   var SUPA_KEY = 'COLE_SUA_KEY_AQUI';
   ```
5. Substitua pelos seus valores

### 4. Subir para o GitHub
```bash
git init
git add .
git commit -m "Auto Money CRM - primeiro deploy"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/automoney-crm.git
git push -u origin main
```

### 5. Publicar no Netlify
1. Acesse https://netlify.com
2. Clique em **Add new site → Import an existing project**
3. Conecte com seu GitHub
4. Selecione o repositório `automoney-crm`
5. Clique em **Deploy site**
6. Em 1 minuto seu site estará em: `https://automoney-crm.netlify.app`

---

## 👥 Usuários do sistema

| Usuário  | Perfil       |
|----------|-------------|
| ANDERSON | Gestor      |
| ANA      | Gestora     |
| CAMILA   | Consignadora|
| HELOISE  | Consignadora|
| NATAN    | Vendedor    |
| OZIEL    | Vendedor    |
| WILLIAM  | Preparador  |

---

## 📁 Estrutura do projeto

```
automoney-crm/
├── index.html          ← sistema completo
├── README.md           ← este arquivo
└── supabase/
    └── schema.sql      ← cria todas as tabelas no banco
```
