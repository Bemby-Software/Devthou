# Generate Module Structure Script
## Description
This script generates the relevant source and test projects for a complete module.

## Usage
```console
./generate_module_structure.sh <path_to_root_dir> <module_name> [module_prefix]
```

| Parameter | Optional | Description |
| --------- | -------- | ----------- |
| path_to_root_dir | No | Path to the directory in which to place the module folder. |
| module_name | No | The name to give the module. This will be the name of the module folder. |
| module_prefix | Yes | This is the prefix to go before the module name for all csproj and sln files generated. For example, if the prefix was hello and the module name was world a project called hello.world.Api.csproj would be generated.


### Example
```shell
$ ./DevThou/scripts/generate_module_structure.sh ./ AccountModule Bemby
Path: /c/Programming/Bemby
Module Name: AccountModule
Module Path: /c/Programming/Bemby/AccountModule
Module Prefix: Bemby

Creating solution file.
Created solution file /c/Programming/Bemby/AccountModule/Bemby.AccountModule.sln

Creating source projects.
Created project file /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Api/Bemby.AccountModule.Api.csproj
Created project file /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Application/Bemby.AccountModule.Application.csproj
Created project file /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Application.Interfaces/Bemby.AccountModule.Application.Interfaces.csproj
Created project file /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Domain/Bemby.AccountModule.Domain.csproj
Created project file /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Infrastructure/Bemby.AccountModule.Infrastructure.csproj
Adding project references for /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Api/Bemby.AccountModule.Api.csproj
Adding project references for /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Application/Bemby.AccountModule.Application.csproj
Adding project references for /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Application.Interfaces/Bemby.AccountModule.Application.Interfaces.csproj
Adding project references for /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Infrastructure/Bemby.AccountModule.Infrastructure.csproj

Creating test projects.
Created project file /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Api.Tests/Bemby.AccountModule.Api.Tests.csproj
Installed nuget packages Moq; Moq.AutoMock; Shouldly in /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Api.Tests/Bemby.AccountModule.Api.Tests.csproj
Created project file /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Application.Tests/Bemby.AccountModule.Application.Tests.csproj
Installed nuget packages Moq; Moq.AutoMock; Shouldly in /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Application.Tests -n Bemby.AccountModule.Application.Tests
Created project file /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Application.Interfaces.Tests/Bemby.AccountModule.Application.Interfaces.Tests.csproj
Installed nuget packages Moq; Moq.AutoMock; Shouldly in /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Application.Interfaces.Tests/Bemby.AccountModule.Application.Interfaces.Tests.csproj
Created project file /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Domain.Tests/Bemby.AccountModule.Domain.Tests.csproj
./DevThou/scripts/generate_module_structure.sh: line 120: ev/null: No such file or directory
Installed nuget packages Moq; Moq.AutoMock; Shouldly in /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Domain.Tests/Bemby.AccountModule.Domain.Tests.csproj
Created project file /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Infrastructure.Tests/Bemby.AccountModule.Infrastructure.Tests.csproj
Installed nuget packages Moq; Moq.AutoMock; Shouldly in /c/Programming/Bemby/AccountModule/tests/Bemby.AccountModule.Infrastructure.Tests/Bemby.AccountModule.Infrastructure.Tests.csproj

Adding project references for /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Api.Tests/Bemby.AccountModule.Api.Tests.csproj
Adding project references for /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Application.Tests/Bemby.AccountModule.Application.Tests.csproj
Adding project references for /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Application.Interfaces.Tests/Bemby.AccountModule.Application.Interfaces.Tests.csproj
Adding project references for /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Domain.Tests/Bemby.AccountModule.Domain.Tests.csproj
Adding project references for /c/Programming/Bemby/AccountModule/src/Bemby.AccountModule.Infrastructure.Tests/Bemby.AccountModule.Infrastructure.Tests.csproj

Adding all projects to the module solution file.
Complete. The module can be found at /c/Programming/Bemby/AccountModule.
```

Which produces the following file structure

```shell
+---AccountModule
|   |   Bemby.AccountModule.sln
|   |
|   +---src
|   |   +---Bemby.AccountModule.Api
|   |   |   |   Bemby.AccountModule.Api.csproj
|   |   |   |   Class1.cs
|   |   |   |
|   |   |
|   |   +---Bemby.AccountModule.Application
|   |   |   |   Bemby.AccountModule.Application.csproj
|   |   |   |   Class1.cs
|   |   |   |
|   |   |
|   |   +---Bemby.AccountModule.Application.Interfaces
|   |   |   |   Bemby.AccountModule.Application.Interfaces.csproj
|   |   |   |   Class1.cs
|   |   |   |
|   |   |
|   |   +---Bemby.AccountModule.Domain
|   |   |   |   Bemby.AccountModule.Domain.csproj
|   |   |   |   Class1.cs
|   |   |   |
|   |   |
|   |   \---Bemby.AccountModule.Infrastructure
|   |       |   Bemby.AccountModule.Infrastructure.csproj
|   |       |   Class1.cs
|   |       |
|   |
|   \---tests
|       +---Bemby.AccountModule.Api.Tests
|       |   |   Bemby.AccountModule.Api.Tests.csproj
|       |   |   UnitTest1.cs
|       |   |
|       |
|       +---Bemby.AccountModule.Application.Interfaces.Tests
|       |   |   Bemby.AccountModule.Application.Interfaces.Tests.csproj
|       |   |   UnitTest1.cs
|       |   |
|       |
|       +---Bemby.AccountModule.Application.Tests
|       |   |   Bemby.AccountModule.Application.Tests.csproj
|       |   |   UnitTest1.cs
|       |   |
|       |
|       +---Bemby.AccountModule.Domain.Tests
|       |   |   Bemby.AccountModule.Domain.Tests.csproj
|       |   |   UnitTest1.cs
|       |   |
|       |
|       \---Bemby.AccountModule.Infrastructure.Tests
|           |   Bemby.AccountModule.Infrastructure.Tests.csproj
|           |   UnitTest1.cs

```