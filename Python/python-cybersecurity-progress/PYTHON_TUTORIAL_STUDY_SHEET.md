# Python Tutorial Study Sheet

## 1) Environment and Setup Commands

| Command | What it does | When to use it | Common mistake |
|---|---|---|---|
| `python --version` | Prints the Python version available in your terminal. | First check on a machine/project. | Python may exist but not be the one you expect in PATH. |
| `python -m venv .venv` | Creates an isolated Python environment in `.venv`. | Start of each project. | Creating a venv does not activate it. |
| `.venv\\Scripts\\Activate.ps1` | Activates venv in Windows PowerShell. | Every new PowerShell session. | Installing packages before activation sends them to global Python. |
| `source .venv/bin/activate` | Activates venv on Linux/macOS shells. | Every new Unix shell session. | Same as above. |
| `deactivate` | Exits the active venv. | When leaving project context. | You must reactivate in a new terminal. |
| `pip install <package>` | Installs package into active environment. | Add dependency. | Wrong environment means wrong install target. |
| `pip install pkg==x.y.z` | Installs exact package version. | Reproducibility and compatibility. | Version pin can conflict with other dependencies. |
| `pip freeze > requirements.txt` | Exports installed package versions to file. | Before sharing/deploying. | Includes all currently installed packages, even unused. |
| `pip install -r requirements.txt` | Installs all dependencies listed in requirements file. | Rebuild environment on new machine. | Fails if versions are unavailable/incompatible. |
| `pip install ipykernel` | Installs Jupyter kernel package in venv. | Notebook workflows. | Notebook may still use another kernel if not selected. |
| `jupyter kernelspec list` | Lists all Jupyter kernels available. | Debug interpreter mismatch in notebooks. | Seeing kernel in list does not auto-select it. |

Notes:
- Keep `.venv/` out of git.
- Commit `requirements.txt` so environment is reproducible.
- Confirm active venv before every install.

---

## 2) Python Core Commands and Constructs

### `print(...)`
- What it does: Displays values in terminal/notebook output.
- Use it for quick debugging and visibility of variable state.

### `input(...)`
- What it does: Reads user input as a string.
- Important: input is always `str`, even if user types numbers.

### `type(x)`
- What it does: Returns runtime type (`str`, `int`, `float`, etc.).
- Use it when debugging conversion problems.

### Type conversion: `int()`, `float()`, `str()`, `bool()`
- What they do: Convert values explicitly.
- Common pattern: convert input before numeric comparisons.

Example:
```python
raw_port = input("Port: ")   # str
port = int(raw_port)          # int
if port > 1024:
    print("High port")
```

### Conditions: `if / elif / else`
- What they do: Branch code paths based on boolean expressions.
- Frequent bug: using `=` instead of `==` in comparisons.

### Loops: `for`, `while`, `range()`
- `for`: iterate over collections or numeric ranges.
- `while`: repeat while condition remains true.
- `range(start, stop, step)`: stop is exclusive.

### Logical and membership operators
- `and`, `or`, `not`: combine boolean conditions.
- `in`, `not in`: membership checks for strings/collections.

---

## 3) Collections and Why to Use Each

### List `[]`
- Ordered, mutable sequence.
- Best for data you add/remove/reorder.

### Tuple `()`
- Ordered, immutable sequence.
- Best for fixed records that should not change.

### Dict `{key: value}`
- Key-value mapping.
- Best for structured parsed data (log fields, alert objects).

### Set `{...}`
- Unique values, fast membership checks.
- Best for deduplication and blocklist lookups.

Example:
```python
blocked_ips = {"10.0.0.5", "10.0.0.7"}
if ip in blocked_ips:
    print("Blocked")
```

Useful collection operations from the tutorials:
- Slicing: `items[a:b:c]`
- Negative indexing: `items[-1]`
- Set math: union/intersection/difference

---

## 4) Functions (Beginner and Advanced)

### `def` and `return`
- `def` defines reusable logic.
- `return` sends result back to caller.
- Prefer `return` in utilities; keep `print` for UI/debug output.

### Parameters and defaults
- Required inputs + optional defaults (`timeout=2`).
- Makes function reusable with sensible fallback behavior.

### `*args` and `**kwargs`
- `*args`: variable positional arguments.
- `**kwargs`: variable keyword arguments.
- Useful for wrappers/decorators and flexible APIs.

### `lambda`, `sorted(..., key=...)`, `filter(...)`
- Small inline behavior and data transformation.

Example:
```python
vulns = [{"id": "CVE-1", "cvss": 9.8}, {"id": "CVE-2", "cvss": 5.4}]
sorted_vulns = sorted(vulns, key=lambda v: v["cvss"], reverse=True)
```

---

## 5) OOP Essentials

### Class and object basics
- `class` defines blueprint.
- `__init__` initializes object state.
- Instance attributes store per-object data.
- Methods define behavior.

### Encapsulation and properties
- Use private attributes for sensitive internals.
- Use `@property` and setters for controlled access/validation.

### Inheritance and `super()`
- Child classes reuse and extend parent behavior.
- `super()` avoids hardcoding parent class names.

### `@staticmethod` and `@classmethod`
- `@staticmethod`: utility logic tied to class domain, no instance/class state required.
- `@classmethod`: alternative constructors/factory patterns using `cls`.

---

## 6) Exception Handling

### `try / except / else / finally`
- `try`: risky operations.
- `except`: expected failures.
- `else`: runs only if no exception happened.
- `finally`: always runs (cleanup, delay, release logic).

Best practice from tutorials:
- Catch specific exception types.
- Avoid bare `except:`.
- Preserve useful error messages (`except X as e:`).

---

## 7) File Handling

### `with open(...) as f`
- Opens file and closes automatically.
- Preferred over manual `open()/close()`.

### Read/write modes
- `'r'`: read
- `'w'`: overwrite file
- `'a'`: append to file

### Structured files
- CSV: `csv.reader`, `csv.DictReader`, `csv.DictWriter`
- JSON: `json.load`, `json.dump`

### Paths and encoding
- Use `pathlib.Path` or `os.path.join` for cross-platform paths.
- Specify encoding (`encoding="utf-8"`) to avoid platform-specific decode issues.

---

## 8) Threading and Concurrency

### Basic threading
- `Thread(target=...)`, `.start()`, `.join()`.
- Use join to ensure all worker threads finish before reading final results.

### Shared state protection
- `Lock`/`RLock` prevent race conditions around shared data.

### Higher-level API
- `ThreadPoolExecutor(max_workers=n)` simplifies managing many tasks.
- `executor.map(fn, items)` applies function concurrently over iterable.

### Thread-safe communication
- `queue.Queue` for producer-consumer pipelines.

---

## 9) Decorators

### What decorators do
- Wrap function behavior without changing core function code.
- Common uses: logging, timing, validation, exception reporting.

### Key points
- Wrapper should usually accept `*args, **kwargs`.
- Use `functools.wraps` to preserve original function metadata.
- Decorator stacking order affects execution order.

---

## 10) Typing

### Type hints
- Add clarity to variables and function signatures.
- Improve maintainability and editor/static analysis support.

### Common hints used
- `List`, `Dict`, `Tuple`, `Set`, `Optional`, `Union`.

Important:
- Hints are not runtime enforcement by default.
- Use static tools (`mypy`) for stricter checks.

---

## 11) Regex

### Core functions
- `re.search`: find first match anywhere.
- `re.match`: match only at string start.
- `re.findall`: return all matches.
- `re.sub`: replace matches.
- `re.compile`: precompile reusable pattern.

### Practical rules
- Use raw strings (`r"..."`) for patterns.
- Validate assumptions about boundaries and quantifiers.
- Watch greedy vs lazy matching behavior.

---

## 12) Data Modelling Choices

### Dict vs class vs dataclass vs NamedTuple
- `dict`: fastest to start, weakest structure/safety.
- class: full control, more boilerplate.
- `@dataclass`: concise structured objects with defaults.
- `NamedTuple`: lightweight immutable records.

Important pitfall:
- Mutable defaults in dataclasses/classes should use factory patterns.

---

## 13) Web Scraping

### Fetching and parsing
- Use `requests.get(url, timeout=10)` to avoid hanging forever.
- Check `status_code` and call `raise_for_status()` for HTTP failures.
- Parse HTML with `BeautifulSoup(text, "html.parser")`.

### Extraction APIs
- `find`, `find_all`, `select`, `select_one`.
- Extract text with `.get_text(strip=True)` and attrs with `.get(...)`.

### Robust scraping behavior
- Use `requests.Session()` for headers/cookies/connection reuse.
- Add polite delays (`time.sleep(...)`).
- Handle pagination intentionally.
- Respect legal/ethical boundaries and `robots.txt`.

---

## 14) High-Value Mistake Checklist

- Forgetting to activate venv before `pip install`.
- Comparing raw `input()` directly to numbers.
- Using `'w'` mode and unintentionally destroying data.
- Making network calls without timeout.
- Using bare `except:` and hiding real bugs.
- Updating shared thread data without lock/queue.
- Using `eval()` with untrusted input.
- Assuming type hints enforce runtime behavior.

---

## 15) Minimal Practical Workflow

1. Create and activate venv.
2. Install only required packages.
3. Build small, testable functions with clear returns.
4. Use structured types (dict/dataclass/class) for security data.
5. Add explicit exception handling and file/network safety.
6. Export dependencies to `requirements.txt`.

