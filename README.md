# Projeto Pomodoro em Flutter: Documento Completo

Parte do princípio que o ambiente (Flutter, Dart, VS Code, emulador) já está instalado e configurado.

---

## 0. Nome do projeto

| | |
|---|---|
| **Nome do projeto (pasta)** | `pomodoro` |
| **Nome da app** | Pomodoro |
| **Identificador (org)** | `com.teunome` (troca por o teu nome) |

---

## 1. Criar o projeto

```bash
flutter create --org com.teunome --platforms=android,web pomodoro
cd pomodoro
code .
flutter run -d chrome
```

```bash
git init
git add .
git commit -m "chore: projeto flutter inicial"
```

---

## 2. Design de referência

Ecrã único, minimalista, tema verde-menta (Material 3). A imagem é só **referência visual**; construímos tudo de raiz, com o nosso código.

```
┌──────────────────────────────┐
│                              │
│            Focus             │  ← título do modo atual
│                              │
│         ╭──────────╮         │
│        │            │        │
│        │   25:00    │        │  ← anel de progresso + tempo
│        │            │        │
│         ╰──────────╯         │
│                              │
│   [  ▶  ]   ( ↻ )   [ ⏭ ]    │  ← play/pause, reset, skip
│                              │
│          Up next             │
│          05:00               │  ← próxima sessão
│         Short break          │
│                              │
│   [ Focus | Short | Long ]   │  ← seletor de modos (em baixo)
└──────────────────────────────┘
```

---

## 3. Cores

Valores aproximados, tirados da imagem de referência. Podem ser afinados depois, mas **só se muda neste sítio** (`app_colors.dart`).

### Paleta

| Nome no código | Hex | Onde se usa |
|---|---|---|
| `background` | `#F5FAF6` | Fundo do ecrã |
| `primary` | `#1F6F5C` | Título "Focus", anel preenchido (progresso), ícones ativos |
| `textPrimary` | `#2A3A35` | Tempo `25:00`, textos principais |
| `textSecondary` | `#3A6573` | Valor do "Up next" (`05:00`) |
| `mint` | `#CDE9DD` | Fundo do anel (trilho), botões Reset e Skip |
| `mintStrong` | `#B5F0DD` | Opção ativa do seletor de modos |
| `onMintStrong` | `#0F3D31` | Texto sobre a opção ativa do seletor |
| `neutralButton` | `#E8EEEA` | Botão Play/Pause (estado neutro) |

### Pré-visualização rápida

```
background      ████  #F5FAF6
primary         ████  #1F6F5C
textPrimary     ████  #2A3A35
textSecondary   ████  #3A6573
mint            ████  #CDE9DD
mintStrong      ████  #B5F0DD
onMintStrong    ████  #0F3D31
neutralButton   ████  #E8EEEA
```

### Código

**`lib/core/theme/app_colors.dart`**
```dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const background    = Color(0xFFF5FAF6);
  static const primary       = Color(0xFF1F6F5C);
  static const textPrimary   = Color(0xFF2A3A35);
  static const textSecondary = Color(0xFF3A6573);
  static const mint          = Color(0xFFCDE9DD);
  static const mintStrong    = Color(0xFFB5F0DD);
  static const onMintStrong  = Color(0xFF0F3D31);
  static const neutralButton = Color(0xFFE8EEEA);
}
```

**`lib/core/theme/app_theme.dart`**
```dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
    primary: AppColors.primary,
    surface: AppColors.background,
    onSurface: AppColors.textPrimary,
    secondaryContainer: AppColors.mintStrong,
    onSecondaryContainer: AppColors.onMintStrong,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
  );
}
```

**Usar o tema em `lib/app.dart`**
```dart
theme: buildAppTheme(),
```

### Regra

Nunca escrever cores diretamente nos widgets (`Color(0xFF...)`). Usar sempre `AppColors.xxx` ou `Theme.of(context).colorScheme`.

---

## 4. Estrutura do projeto

```
pomodoro/
├── lib/
│   ├── main.dart                         # Ponto de entrada (só chama runApp)
│   ├── app.dart                          # MaterialApp + tema
│   │
│   ├── core/
│   │   └── theme/
│   │       ├── app_colors.dart           # Paleta de cores
│   │       └── app_theme.dart            # ThemeData / ColorScheme
│   │
│   └── features/
│       └── pomodoro/
│           ├── models/
│           │   └── pomodoro_mode.dart    # enum dos modos (V2)
│           ├── widgets/
│           │   ├── timer_display.dart    # Anel + tempo
│           │   ├── control_buttons.dart  # Play/Pause, Reset, Skip
│           │   ├── up_next_info.dart     # "Up next 05:00 Short break"
│           │   └── mode_selector.dart    # Seletor em baixo (V2)
│           └── pomodoro_page.dart        # Ecrã principal
│
├── test/
├── pubspec.yaml
└── README.md
```

### Regras para manter a estrutura limpa

1. `main.dart` fica minúsculo: só arranca a app.
2. Cada ecrã vive numa **feature** (`features/pomodoro`). Se um dia houver Definições, será `features/settings`.
3. Um widget por ficheiro quando começar a ficar grande.
4. Lógica (timer, estado) separada da interface sempre que possível. Isso vem na fase de arquitetura.
5. Nomes de ficheiros em `snake_case`, classes em `PascalCase`.

### Esqueleto inicial (V1)

**`lib/main.dart`**
```dart
import 'package:flutter/material.dart';
import 'app.dart';

void main() => runApp(const PomodoroApp());
```

**`lib/app.dart`**
```dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/pomodoro/pomodoro_page.dart';

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const PomodoroPage(),
    );
  }
}
```

**`lib/features/pomodoro/pomodoro_page.dart`**
```dart
import 'package:flutter/material.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('25:00', style: TextStyle(fontSize: 64))),
    );
  }
}
```

Isto já corre e mostra o `25:00`. A partir daqui é a Versão 1.

---

## 5. Mapa: elemento → widget → conceito

| Elemento | Widget Flutter | Conceito aprendido |
|---|---|---|
| Estrutura do ecrã | `Scaffold`, `SafeArea`, `Column` | Layout, árvore de widgets |
| Título "Focus" | `Text` + `TextStyle` | Estilos de texto, `Theme.of(context)` |
| Tempo `25:00` | `Text` | Formatar `Duration` em `mm:ss` |
| Anel de progresso | `Stack` + `CircularProgressIndicator` | Sobreposição, `SizedBox`, valor 0.0 a 1.0 |
| Play / Pause | `FilledButton` / `IconButton` | Callbacks `onPressed`, estado do botão |
| Reset e Skip | `FilledButton.tonal` / `IconButton` | Reutilizar componentes |
| Up next | `Text` em `Column` | Estado derivado |
| Seletor de modos | `SegmentedButton` | `enum`, seleção, passar dados para cima |
| Cores e fontes | `ThemeData`, `ColorScheme`, `AppColors` | Temas Material 3 |

---

## 6. Conceitos por versão

### Versão 1: O contador a funcionar
**Objetivo:** ecrã com `25:00` e botões Play/Pause e Reset a funcionar.

- `StatelessWidget` vs `StatefulWidget`
- `setState`: como a interface se atualiza
- `Timer.periodic`: executar código a cada segundo
- `Duration`: representar e subtrair tempo
- **Lifecycle:** `initState` e `dispose` (cancelar o timer para não haver fugas)
- Formatar tempo: `padLeft(2, '0')` para mostrar `05:00`
- `ThemeData` e `ColorScheme` com as cores da secção 3

### Versão 2: Modos e fluxo
**Objetivo:** Focus / Short break / Long break, botão Skip e "Up next".

- `enum` com valores e propriedades (cada modo com a sua duração)
- `switch` expressions
- Estado derivado: "Up next" calcula-se a partir do modo atual
- Extrair widgets próprios (`ControlButtons`, `ModeSelector`)
- Passar dados e callbacks entre widgets (pai → filho, filho → pai)
- `SegmentedButton`
- Introdução a `async` / `Future`

### Versão 3: O anel de progresso
**Objetivo:** o círculo à volta do tempo preenche-se com o progresso.

- `Stack` e `Center`
- `CircularProgressIndicator` (valor determinado)
- Calcular progresso: `tempo decorrido / tempo total`
- `ValueNotifier` e `ValueListenableBuilder`
- Opcional: `CustomPaint` para desenhar o anel à mão

### Versão 4: Animações *(depois)*
- Animações implícitas: `AnimatedSwitcher` (play ↔ pause), `AnimatedContainer`
- `TweenAnimationBuilder` para o anel avançar suavemente
- `AnimationController` (animações explícitas)
- Gestos: `GestureDetector`, `InkWell`
- Botões que mudam de forma (pílula ↔ círculo)

### Versão 5: Persistência *(depois)*
- `shared_preferences`
- `async` / `await` na prática
- Ecrã de definições e navegação entre ecrãs
- Ler e guardar dados ao arrancar a app

### Depois: Arquitetura *(depois)*
- Separar lógica (timer) da interface
- Gestão de estado (Provider ou Riverpod)
- Testes unitários da lógica do timer

---

## 7. Checklist do projeto

- [ ] Projeto `pomodoro` criado com `flutter create`
- [ ] Pastas e ficheiros da estrutura criados
- [ ] `app_colors.dart` e `app_theme.dart` com as cores
- [ ] Primeiro `flutter run` a funcionar
- [ ] Primeiro commit feito

---

## 8. Regras de estudo

1. Uma versão de cada vez. Só avançar com a anterior a funcionar e com commit.
2. Em cada versão, perceber **porquê** do código, não só copiar.
3. Animações só na V4. Antes disso, tudo estático e funcional.
4. No fim de cada versão, escrever 3 linhas: o que aprendi, o que me confundiu, o que quero rever.

Quando a checklist estiver completa, o próximo passo é a **Versão 1**.