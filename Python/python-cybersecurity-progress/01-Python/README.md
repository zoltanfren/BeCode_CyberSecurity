# 🐍 Python for Cybersecurity — Training Curriculum

> A hands-on, project-driven Python curriculum designed to take complete beginners to job-ready junior cybersecurity professionals.

---

## 📋 Table of Contents

- [Who This Is For](#who-this-is-for)
- [How the Curriculum Is Structured](#how-the-curriculum-is-structured)
- [Curriculum Overview](#curriculum-overview)
- [Setup Guide](#setup-guide)
  - [1. Install Python](#1-install-python)
  - [2. Install Git](#2-install-git)
  - [3. Install VS Code](#3-install-vs-code)
  - [4. Install VS Code Extensions](#4-install-vs-code-extensions)
  - [5. Install Jupyter](#5-install-jupyter)
  - [6. Set Up Your Two Repositories](#6-set-up-your-two-repositories)
  - [7. Your Daily Workflow](#7-your-daily-workflow)
  - [8. Open and Run a Notebook](#8-open-and-run-a-notebook)
- [How to Use the Notebooks](#how-to-use-the-notebooks)
- [Solutions and Spoilers](#solutions-and-spoilers)
- [Good Habits to Build From Day One](#good-habits-to-build-from-day-one)

---

## Who This Is For

This curriculum is designed for **complete beginners** with little to no programming experience who. No prior Python knowledge is required. You will progressively build real, practical skills used daily by security analysts and penetration testers.

By the end of this training you will be able to:

- Write clean, professional Python scripts
- Automate repetitive security tasks
- Parse and analyze logs, files, and network data
- Scrape and extract threat intelligence from the web
- Build your own security tools from scratch

---

## How the Curriculum Is Structured

Each topic in the curriculum follows the same three-step pattern:

```
00_Topic.ipynb          →   Core lesson with explanations and guided practice
01_Advanced_Topic.ipynb →   Deeper concepts, edge cases, and professional patterns (Sometimes is combined into one file)
XX_Drills_Topic.ipynb   →   Pure practice exercises with hidden solutions
```

This structure ensures you always learn a concept, see it applied, and then practice it independently — the same way skills are built in real professional environments.

---

## Curriculum Overview

The curriculum is organized into **18 modules**, progressing from the absolute basics to advanced cybersecurity-relevant Python techniques.

### 🟢 Foundation — Python Basics

| # | Module | What You Learn |
|---|--------|----------------|
| 00 | **Introduction to Python** | What Python is, why it matters in security, environment setup |
| 01 | **Python Syntax** | Indentation, comments, how Python reads code |
| 02 | **Variables & Data Types** | Storing data: strings, integers, floats, booleans |
| 03 | **Operators & Conditions** | Making decisions: `if`, `elif`, `else`, comparisons, logic |
| 04 | **Built-in Functions** | `print()`, `len()`, `range()`, `type()`, `input()` and more |
| 05 | **Imports** | Using Python's standard library and third-party packages |
| 06 | **Loops** | Automating repetition: `for`, `while`, `break`, `continue` |
| 07 | **Collections** | Lists, tuples, dictionaries, sets — storing groups of data |
| 08 | **Functions** | Writing reusable, clean code blocks |

### ⚙️ Transition — Professional Tooling

| # | Module | What You Learn |
|---|--------|----------------|
| 09 | **Virtual Environments** | Isolating projects, managing dependencies like a professional |

### 🔵 Intermediate — Python in Practice

| # | Module | What You Learn |
|---|--------|----------------|
| 10 | **Object-Oriented Programming** | Classes, objects, attributes, methods, inheritance |
| 11 | **Exception Handling** | Writing resilient scripts that don't crash unexpectedly |
| 12 | **File Handling** | Reading and writing files: logs, CSVs, JSON, text |
| 13 | **Threading** | Running tasks in parallel — port scanners, concurrent checks |
| 14 | **Decorators** | Wrapping functions with reusable logic |
| 15 | **Typing** | Type hints and annotations for professional, readable code |

### 🔴 Advanced — Cybersecurity-Focused Tools

| # | Module | What You Learn |
|---|--------|----------------|
| 16 | **Regular Expressions** | Pattern matching in logs, traffic, and security data |
| 17 | **Data Structures** | Modelling real security data: alerts, incidents, network graphs |
| 18 | **Web Scraping** | Collecting threat intelligence and data from the web automatically |

---

## Setup Guide

Follow these steps **before your first session**. Do not skip any step.

### 1. Install Python

Download and install **Python 3.11 or higher** from the official website:

👉 [https://www.python.org/downloads/](https://www.python.org/downloads/)

> ⚠️ **Windows users:** During installation, make sure to check the box **"Add Python to PATH"** before clicking Install.

Verify your installation by opening a terminal and running:

```bash
python --version
# or on Linux/macOS:
python3 --version
```

You should see something like `Python 3.11.x`.

---

### 2. Install Git

Git is how you will receive new notebooks and updates throughout the course.

👉 [https://git-scm.com/downloads](https://git-scm.com/downloads)

Verify your installation:

```bash
git --version
```

---

### 3. Install VS Code

Download and install **Visual Studio Code**:

👉 [https://code.visualstudio.com/](https://code.visualstudio.com/)

VS Code is the industry-standard editor used across development, security operations, and data engineering teams. You will use it for every notebook in this curriculum.

---

### 4. Install VS Code Extensions

Once VS Code is open, install these two extensions:

1. Press `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (macOS) to open the Extensions panel
2. Search for and install **`Python`** — published by Microsoft
3. Search for and install **`Jupyter`** — published by Microsoft

> The Jupyter extension gives you full notebook support directly inside VS Code — no browser tab needed. The Python extension adds syntax highlighting, autocompletion, and error detection.

---

### 5. Install Jupyter

Open a terminal and run:

```bash
pip install jupyter ipykernel
```

> Don't worry about what this means yet — you will learn all about package installation in the **Virtual Environments** module. For now, just run the command.

---

### 6. Set Up Your Two Repositories

You will work with **two separate folders** throughout this course:

| Folder | Purpose |
|--------|---------|
| `curriculum/` | The official course notebooks — read-only, always up to date |
| `my-progress/` | Your personal copy — where you write your answers and save your work |

This separation is important: when new notebooks are released, you pull them into `curriculum/` without touching your saved work in `my-progress/`.

**Step 1 — Clone the official curriculum repository:**

```bash
git clone <curriculum-repo-url> curriculum
```

**Step 2 — Create your personal progress repository:**

Go to your GitHub account, create a new **private** repository called `python-cybersecurity-progress`, then clone it locally:

```bash
git clone https://github.com/your-username/python-cybersecurity-progress my-progress
```

---

### 7. Your Daily Workflow

Every session follows the same three steps:

**① Pull the latest notebooks from the curriculum:**

```bash
cd curriculum
git pull
```

**② Copy the new notebooks into your personal repository:**

```bash
# macOS / Linux
cp curriculum/*.ipynb my-progress/

# Windows (PowerShell)
Copy-Item curriculum\*.ipynb my-progress\
```

**③ Open your personal folder in VS Code, do your work, then save your progress:**

```bash
cd my-progress
git add .
git commit -m "completed module 03 - operators and conditions"
git push
```

> ✅ This way you always have the latest course content **and** a full history of your own work. Your instructor can also review your progress directly on GitHub.

---

### 8. Open and Run a Notebook

1. In VS Code: `File → Open Folder` → select your `my-progress/` folder
2. In the Explorer panel, click on `00_Intro_to_Python.ipynb`
3. The notebook will open in the Jupyter editor
4. In the **top-right corner**, click **"Select Kernel"** → choose **`Python 3`**
5. You are ready — start with the first cell and work your way down

---

## How to Use the Notebooks

Each notebook is a self-contained lesson. Here is how to navigate them effectively:

### Understanding Cell Types

Notebooks contain two types of cells:

| Cell Type | What It Is | What You Do |
|-----------|------------|-------------|
| **Markdown** | Text, explanations, instructions | Read it carefully — these cells teach the concept |
| **Code** | Runnable Python | Read it, understand it, then run it with `Shift+Enter` |

### Running Cells

| Action | Shortcut |
|--------|----------|
| Run current cell and move to next | `Shift + Enter` |
| Run current cell and stay | `Ctrl + Enter` / `Cmd + Enter` |
| Run all cells from top | Click **"Run All"** in the toolbar |

> 💡 **Always run cells in order, top to bottom.** Cells often depend on variables or imports defined in earlier cells. Skipping ahead will cause errors.

### Practice Cells

Throughout each notebook you will encounter **Practice** sections. These look like:

```
### Practice — Section X
Write a function that...
```

Followed by an **empty code cell** for you to write your answer. This is where the learning actually happens — do not skip these. Try to solve them on your own before checking the solution.

### Checking Your Work

Each practice cell is followed by a **verification cell** that tests your answer automatically. Run it after completing the exercise to confirm your solution is correct.

---

## Solutions and Spoilers

Every solution in this curriculum is **hidden by default** to give you the chance to think before looking.

Solutions are revealed by clicking the collapsed section:

> <details>
> <summary><strong>💡 SOLUTION</strong> — click to reveal</summary>
>
> ```python
> # The solution code appears here
> ```
>
> </details>

**The rule:** Always attempt the exercise first. Spend at least 10–15 minutes trying before opening a solution. Struggling with a problem is not failure — it is how learning actually happens.

---

## Good Habits to Build From Day One

These are not suggestions. These are the habits that separate a junior who gets hired from one who doesn't.

- ✅ **Run cells in order.** Never jump ahead and skip cells.
- ✅ **Read error messages fully.** The last line of a Python error tells you exactly what went wrong. Read it before asking for help.
- ✅ **Write comments in your code.** If you can't explain what a line does in plain English, you don't understand it yet.
- ✅ **Don't copy-paste solutions.** Type them. Your fingers need to learn this too.
- ✅ **Commit your work regularly.** Get into the habit of using Git — employers look at your activity.

---

> Built for the Python for Cybersecurity training program.  
> Questions? Raise them in class. Bugs? Report them to your instructor.
