# GitHub Explorer

A SwiftUI iOS application for searching GitHub users, built with modern Swift concurrency and MVVM architecture.

## 🚨 IMPORTANT: Bad Code Practices Branch

**Current Branch: `bad-code-practices`**

This branch contains **INTENTIONALLY BAD CODE** for educational purposes and junior developer training. The code demonstrates common anti-patterns and problematic practices that should be avoided in production.

**Note**: All obvious "BAD" comments have been removed to simulate realistic junior developer code that needs to be reviewed.

### 🔴 Bad Practices Implemented (FOR TRAINING ONLY):

#### 1. **Missing `weak self` - Retain Cycles**
- Timer callbacks without `[weak self]` capture lists
- Async closures capturing `self` strongly
- **Impact**: Memory leaks, objects never deallocated

#### 2. **Force Unwrapping**
- URL creation: `URL(string: u.avatarURL)!`
- Multiple force unwraps: `text!.first!`
- Network parsing: `try! JSONSerialization.jsonObject(with: data!)`
- **Impact**: App crashes when nil values encountered

#### 3. **Poor Variable Naming**
- Single letter variables: `t`, `u`, `l`, `e`, `gs`, `st`
- Unclear abbreviations and poor naming conventions
- Global variables: `g`, `isAppRunning`, `π`
- **Impact**: Code becomes unreadable and unmaintainable

#### 4. **Memory Leaks**
- Timers never invalidated (commented out cleanup)
- Strong reference cycles in closures
- **Impact**: Memory usage grows until app crash

#### 5. **Magic Numbers**
- Hard-coded values: `42`, `3.14159`, `1000`, `100`
- No constants or meaningful names
- **Impact**: Hard to maintain and understand

#### 6. **Global State & Singletons**
- Mutable global variables throughout
- Overuse of singletons with public mutable state
- **Impact**: Unpredictable behavior, hard to test

#### 7. **Boolean Traps**
- Functions with multiple boolean parameters
- `doSomething(_ flag: Bool, _ other: Bool, _ third: Bool)`
- **Impact**: Confusing API, easy to make mistakes

#### 8. **Functions Doing Too Much**
- Single functions handling multiple responsibilities
- Mixed concerns (network, file, UI, math operations)
- **Impact**: Hard to test, debug, and maintain

#### 9. **Poor Error Handling**
- Using `try!` instead of proper error handling
- Force casting: `response as! HTTPURLResponse`
- **Impact**: App crashes instead of graceful error handling

#### 10. **Side Effects in Wrong Places**
- Heavy work in initializers
- Side effects in computed properties
- Modifying global state unexpectedly
- **Impact**: Unpredictable performance and behavior

### 🎯 Training Exercise Ideas:

1. **Code Review Session**: Have junior developers identify all the problems
2. **Refactoring Challenge**: Fix one category of issues at a time
3. **Memory Profiling**: Use Instruments to see the memory leaks in action
4. **Crash Testing**: Run the app and trigger crashes with bad data
5. **Performance Analysis**: Measure the impact of bad practices

### 🔧 How to Test Bad Practices:

1. Tap "Timer" button multiple times → Creates memory leaks
2. Tap "Callback" button → Triggers retain cycles
3. Search for users → Force unwrapping may crash with bad data
4. Leave app running → Memory usage will grow from leaks

### ✅ Clean Version:

Switch to `main` branch to see the properly implemented version with:
- Proper memory management with `[weak self]`
- Safe optional handling instead of force unwrapping
- Clear, descriptive variable names
- Proper error handling
- Clean architecture
- Modern Swift patterns

## Project Structure

```
GitHubExplorer/
├── Models/
│   └── GitHubUser.swift
├── Services/
│   ├── Protocols/
│   │   └── GitHubServiceProtocol.swift
│   └── GitHubService.swift
├── ViewModels/
│   └── UserSearchViewModel.swift (⚠️ PROBLEMATIC CODE)
├── Utils/
│   └── BadUtilities.swift (⚠️ VERY PROBLEMATIC CODE)
└── ContentView.swift (⚠️ PROBLEMATIC CODE)
```

## Technical Stack

- **Language**: Swift 5.9+
- **Framework**: SwiftUI
- **Architecture**: MVVM (poorly implemented)
- **Concurrency**: async/await (with memory issues)
- **Dependency Management**: SPM

---

**⚠️ WARNING**: This code is for educational purposes only. The issues are subtle and realistic - exactly what you'd see in real junior developer code!