# Linux User Manager

[![Tests](https://github.com/cchacon-dev/linux-user-manager/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/cchacon-dev/linux-user-manager/actions/workflows/tests.yml)
[![ShellCheck](https://img.shields.io/badge/lint-ShellCheck-blue)](https://www.shellcheck.net/)
[![License](https://img.shields.io/github/license/cchacon-dev/linux-user-manager.svg)](LICENSE)

🚀 **Linux User Manager** is my first **Bash project**, focused on writing **clean shell scripts** and learning **industry practices** like unit testing with [Bats](https://github.com/bats-core/bats-core), linting with [ShellCheck](https://www.shellcheck.net/), and formatting with [shfmt](https://github.com/mvdan/sh).

The goal is to provide a simple but extensible **user management tool** for Linux systems.

---

## ✨ Features (Work in Progress)

Implemented:
- ✅ Create user (`create_user.sh`)
- ✅ Delete user (`delete_user.sh`)

Planned:
- 🔒 Lock user
- 🔓 Unlock user
- 🔑 Update password
- 👥 Assign user to groups

---

## 📂 Project Structure

```
linux-user-manager/
├── scripts/
│   ├── create_user.sh
│   └── delete_user.sh
├── utils.sh
├── tests/
│   ├── test_create_user.bats
│   └── test_delete_user.bats
├── Makefile
└── README.md
```

---

## ⚙️ Requirements

- Linux (Ubuntu/Debian/Arch/Fedora)  
- `bash` ≥ 5.x  
- [`bats`](https://github.com/bats-core/bats-core) ≥ 1.9 (unit tests)  
- [`shellcheck`](https://www.shellcheck.net/) (linting)  
- [`shfmt`](https://github.com/mvdan/sh) (formatting)

---

## 🚀 Installation

Clone the repository:

```bash
git clone https://github.com/cchacon-dev/linux-user-manager.git
cd linux-user-manager
```

Make scripts executable:

```bash
chmod +x scripts/*.sh
```

---

## 🛠 Usage

Create a new user:

```bash
sudo ./scripts/create_user.sh username password
```

Delete a user:

```bash
sudo ./scripts/delete_user.sh username
```

👉 If no parameters are provided, the script will ask for `username` and `password` interactively.

---

## 🧪 Development & Testing

Run all tests:

```bash
make test
```

Run a specific test (e.g. `tests/test_create_user.bats`):

```bash
make test-test_create_user
```

Format scripts:

```bash
make fmt       # apply shfmt with 2-space indentation
make fmt-check # verify formatting (fails if differences found)
```

Lint with ShellCheck:

```bash
make lint
```

---

## 📈 Roadmap

- [ ] Add lock/unlock functionality  
- [ ] Add password update command  
- [ ] Add group assignment support  
- [ ] Improve logging and error handling  
- [ ] Expand test coverage  

---

## 🤝 Contributing

This project started as a **learning exercise in Bash scripting**, but contributions, suggestions, and pull requests are welcome.  
The focus is on **clean Bash code**, **testing**, and **best practices**.

---

## 📜 License

This project is licensed under the terms of the [MIT License](LICENSE).
