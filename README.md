# Bygge

Bygge is a lightweight "drop in" build solution for .NET projects, using MSBuild.

## Features

##### Built-In Support
- xUnit (Unit Testing)
- NuGet (Packaging)
- AppVeyor (CI)
- MyGet (CI)
- GitVersion (SemVer versioning)

## Rationale

The .NET ecosystem seems to lack a unified build solution which solves unit testing, NuGet package creation, CI build support, and versioning in a dead simple, "drop in", way.

It may be reasonable to put time into creating and maintaining custom build scripts and such for larger projects. But lots of free/libre open-source .NET projects are really small, they are often libraries solving a specific task. Maintaining CI builds, NuGet-packaging, unit testing is a heavy burden. All these things tend to eventually make breaking changes.

The point of Bygge is to be a single place to implement the build process, easy to install into projects, and equally easy to update. The only burden left on the project using Bygge is to run the update script every now and then.

## Project State

While aspiring to eventually become a somewhat universal solution, Bygge is currently in early development and focused on supporting itself and other .NET based Nerven projects. In the future, the aim is to make Bygge extendable with modules, and move built-in features to modules. That is a long-term goal though, and will not be implemented in the near future.
