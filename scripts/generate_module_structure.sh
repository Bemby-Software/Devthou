#!/bin/bash
path=$1
module_name=$2
module_prefix=$3

if [ $# -lt 2 ]
    then
        echo "This script requires two parameters."
        echo "#1 - The path to the directory you want the module creating."
        echo "#2 - The name of the module (no spaces)."
        echo "#3 (opt) - The prefix for the module namespace (no spaces)."
fi

abspath=$(readlink -e $path)

if [ -z "$abspath" ] || [ "$abspath" == "/" ] 
    then
        echo "$path doesn't exist. It must exist."
        exit 1
fi

module_path="$abspath/$module_name"
module_src_path="$abspath/$module_name/src"
module_tests_path="$abspath/$module_name/tests"

echo "Path: $abspath"
echo "Module Name: $module_name"
echo "Module Path: $module_path"
echo "Module Prefix: $module_prefix"
echo ""

mkdir -p "$module_path"

if [ -n "$module_prefix" ]
    then
        module_prefix="$module_prefix."
fi 

# Create solution
echo "Creating solution file."
dotnet new sln -o "$module_path" -n "$module_prefix$module_name" > /dev/null
echo "Created solution file $module_path/$module_prefix$module_name.sln"

echo ""

# Create source projects
echo "Creating source projects."
dotnet new classlib -f net5.0 --langVersion 9.0 -o "$module_src_path/$module_prefix$module_name.Api" -n "$module_prefix$module_name.Api" > /dev/null
echo "Created project file $module_src_path/$module_prefix$module_name.Api/$module_prefix$module_name.Api.csproj"

dotnet new classlib -f net5.0 --langVersion 9.0 -o "$module_src_path/$module_prefix$module_name.Application" -n "$module_prefix$module_name.Application" > /dev/null
echo "Created project file $module_src_path/$module_prefix$module_name.Application/$module_prefix$module_name.Application.csproj"

dotnet new classlib -f net5.0 --langVersion 9.0 -o "$module_src_path/$module_prefix$module_name.Application.Interfaces" -n "$module_prefix$module_name.Application.Interfaces" > /dev/null
echo "Created project file $module_src_path/$module_prefix$module_name.Application.Interfaces/$module_prefix$module_name.Application.Interfaces.csproj"

dotnet new classlib -f net5.0 --langVersion 9.0 -o "$module_src_path/$module_prefix$module_name.Domain" -n "$module_prefix$module_name.Domain" > /dev/null
echo "Created project file $module_src_path/$module_prefix$module_name.Domain/$module_prefix$module_name.Domain.csproj"

dotnet new classlib -f net5.0 --langVersion 9.0 -o "$module_src_path/$module_prefix$module_name.Infrastructure" -n "$module_prefix$module_name.Infrastructure" > /dev/null
echo "Created project file $module_src_path/$module_prefix$module_name.Infrastructure/$module_prefix$module_name.Infrastructure.csproj"


# Add project references for source projects
# API References
echo "Adding project references for $module_src_path/$module_prefix$module_name.Api/$module_prefix$module_name.Api.csproj"
dotnet add "$module_src_path/$module_prefix$module_name.Api" reference "$module_src_path/$module_prefix$module_name.Application" > /dev/null
dotnet add "$module_src_path/$module_prefix$module_name.Api" reference "$module_src_path/$module_prefix$module_name.Application.Interfaces" > /dev/null
dotnet add "$module_src_path/$module_prefix$module_name.Api" reference "$module_src_path/$module_prefix$module_name.Infrastructure" > /dev/null

# Application References
echo "Adding project references for $module_src_path/$module_prefix$module_name.Application/$module_prefix$module_name.Application.csproj"
dotnet add "$module_src_path/$module_prefix$module_name.Application" reference "$module_src_path/$module_prefix$module_name.Application.Interfaces" > /dev/null

# Application.Interfaces References
echo "Adding project references for $module_src_path/$module_prefix$module_name.Application.Interfaces/$module_prefix$module_name.Application.Interfaces.csproj"
dotnet add "$module_src_path/$module_prefix$module_name.Application.Interfaces" reference "$module_src_path/$module_prefix$module_name.Domain" > /dev/null

# Domain References 
# N/a

# Infrastructure References
echo "Adding project references for $module_src_path/$module_prefix$module_name.Infrastructure/$module_prefix$module_name.Infrastructure.csproj"
dotnet add "$module_src_path/$module_prefix$module_name.Infrastructure" reference "$module_src_path/$module_prefix$module_name.Application.Interfaces" > /dev/null
dotnet add "$module_src_path/$module_prefix$module_name.Infrastructure" reference "$module_src_path/$module_prefix$module_name.Domain" > /dev/null

echo ""

# Create test projects
echo "Creating test projects."
dotnet new nunit -f net5.0 -o "$module_tests_path/$module_prefix$module_name.Api.Tests" -n "$module_prefix$module_name.Api.Tests" > /dev/null
echo "Created project file $module_tests_path/$module_prefix$module_name.Api.Tests/$module_prefix$module_name.Api.Tests.csproj"

dotnet add "$module_tests_path/$module_prefix$module_name.Api.Tests/$module_prefix$module_name.Api.Tests.csproj" package Moq > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Api.Tests/$module_prefix$module_name.Api.Tests.csproj" package Moq.AutoMock > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Api.Tests/$module_prefix$module_name.Api.Tests.csproj" package Shouldly > /dev/null
echo "Installed nuget packages Moq; Moq.AutoMock; Shouldly in $module_tests_path/$module_prefix$module_name.Api.Tests/$module_prefix$module_name.Api.Tests.csproj"

dotnet new nunit -f net5.0 -o "$module_tests_path/$module_prefix$module_name.Application.Tests" -n "$module_prefix$module_name.Application.Tests" > /dev/null
echo "Created project file $module_tests_path/$module_prefix$module_name.Application.Tests/$module_prefix$module_name.Application.Tests.csproj"

dotnet add "$module_tests_path/$module_prefix$module_name.Application.Tests/$module_prefix$module_name.Application.Tests.csproj" package Moq > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Application.Tests/$module_prefix$module_name.Application.Tests.csproj" package Moq.AutoMock > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Application.Tests/$module_prefix$module_name.Application.Tests.csproj" package Shouldly > /dev/null
echo "Installed nuget packages Moq; Moq.AutoMock; Shouldly in $module_tests_path/$module_prefix$module_name.Application.Tests" -n "$module_prefix$module_name.Application.Tests" 

dotnet new nunit -f net5.0 -o "$module_tests_path/$module_prefix$module_name.Application.Interfaces.Tests" -n "$module_prefix$module_name.Application.Interfaces.Tests" > /dev/null
echo "Created project file $module_tests_path/$module_prefix$module_name.Application.Interfaces.Tests/$module_prefix$module_name.Application.Interfaces.Tests.csproj"

dotnet add "$module_tests_path/$module_prefix$module_name.Application.Interfaces.Tests/$module_prefix$module_name.Application.Interfaces.Tests.csproj" package Moq > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Application.Interfaces.Tests/$module_prefix$module_name.Application.Interfaces.Tests.csproj" package Moq.AutoMock > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Application.Interfaces.Tests/$module_prefix$module_name.Application.Interfaces.Tests.csproj" package Shouldly > /dev/null
echo "Installed nuget packages Moq; Moq.AutoMock; Shouldly in $module_tests_path/$module_prefix$module_name.Application.Interfaces.Tests/$module_prefix$module_name.Application.Interfaces.Tests.csproj"

dotnet new nunit -f net5.0 -o "$module_tests_path/$module_prefix$module_name.Domain.Tests" -n "$module_prefix$module_name.Domain.Tests" > /dev/null
echo "Created project file $module_tests_path/$module_prefix$module_name.Domain.Tests/$module_prefix$module_name.Domain.Tests.csproj"

dotnet add "$module_tests_path/$module_prefix$module_name.Domain.Tests/$module_prefix$module_name.Domain.Tests.csproj" package Moq > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Domain.Tests/$module_prefix$module_name.Domain.Tests.csproj" package Moq.AutoMock > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Domain.Tests/$module_prefix$module_name.Domain.Tests.csproj" package Shouldly > /dev/null
echo "Installed nuget packages Moq; Moq.AutoMock; Shouldly in $module_tests_path/$module_prefix$module_name.Domain.Tests/$module_prefix$module_name.Domain.Tests.csproj"

dotnet new nunit -f net5.0 -o "$module_tests_path/$module_prefix$module_name.Infrastructure.Tests" -n "$module_prefix$module_name.Infrastructure.Tests" > /dev/null
echo "Created project file $module_tests_path/$module_prefix$module_name.Infrastructure.Tests/$module_prefix$module_name.Infrastructure.Tests.csproj"

dotnet add "$module_tests_path/$module_prefix$module_name.Infrastructure.Tests/$module_prefix$module_name.Infrastructure.Tests.csproj" package Moq > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Infrastructure.Tests/$module_prefix$module_name.Infrastructure.Tests.csproj" package Moq.AutoMock > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Infrastructure.Tests/$module_prefix$module_name.Infrastructure.Tests.csproj" package Shouldly > /dev/null
echo "Installed nuget packages Moq; Moq.AutoMock; Shouldly in $module_tests_path/$module_prefix$module_name.Infrastructure.Tests/$module_prefix$module_name.Infrastructure.Tests.csproj"

echo ""

# Add project references for test projects
# API tests References
echo "Adding project references for $module_src_path/$module_prefix$module_name.Api.Tests/$module_prefix$module_name.Api.Tests.csproj"
dotnet add "$module_tests_path/$module_prefix$module_name.Api.Tests" reference "$module_src_path/$module_prefix$module_name.Api" > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Api.Tests" reference "$module_src_path/$module_prefix$module_name.Application" > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Api.Tests" reference "$module_src_path/$module_prefix$module_name.Application.Interfaces" > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Api.Tests" reference "$module_src_path/$module_prefix$module_name.Infrastructure" > /dev/null

# Application tests References
echo "Adding project references for $module_src_path/$module_prefix$module_name.Application.Tests/$module_prefix$module_name.Application.Tests.csproj"
dotnet add "$module_tests_path/$module_prefix$module_name.Application.Tests" reference "$module_src_path/$module_prefix$module_name.Application" > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Application.Tests" reference "$module_src_path/$module_prefix$module_name.Application.Interfaces" > /dev/null

# Application.Interfaces tests References
echo "Adding project references for $module_src_path/$module_prefix$module_name.Application.Interfaces.Tests/$module_prefix$module_name.Application.Interfaces.Tests.csproj"
dotnet add "$module_tests_path/$module_prefix$module_name.Application.Interfaces.Tests" reference "$module_src_path/$module_prefix$module_name.Application.Interfaces" > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Application.Interfaces.Tests" reference "$module_src_path/$module_prefix$module_name.Domain" > /dev/null

# Domain tests References 
echo "Adding project references for $module_src_path/$module_prefix$module_name.Domain.Tests/$module_prefix$module_name.Domain.Tests.csproj"
dotnet add "$module_tests_path/$module_prefix$module_name.Domain.Tests" reference "$module_src_path/$module_prefix$module_name.Domain" > /dev/null

# Infrastructure tests References
echo "Adding project references for $module_src_path/$module_prefix$module_name.Infrastructure.Tests/$module_prefix$module_name.Infrastructure.Tests.csproj"
dotnet add "$module_tests_path/$module_prefix$module_name.Infrastructure.Tests" reference "$module_src_path/$module_prefix$module_name.Infrastructure" > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Infrastructure.Tests" reference "$module_src_path/$module_prefix$module_name.Application.Interfaces" > /dev/null
dotnet add "$module_tests_path/$module_prefix$module_name.Infrastructure.Tests" reference "$module_src_path/$module_prefix$module_name.Domain" > /dev/null

echo ""

# Add projects to solution
echo "Adding all projects to the module solution file."
dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_src_path/$module_prefix$module_name.Api/$module_prefix$module_name.Api.csproj" > /dev/null
dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_src_path/$module_prefix$module_name.Application/$module_prefix$module_name.Application.csproj" > /dev/null
dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_src_path/$module_prefix$module_name.Application.Interfaces/$module_prefix$module_name.Application.Interfaces.csproj" > /dev/null
dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_src_path/$module_prefix$module_name.Domain/$module_prefix$module_name.Domain.csproj" > /dev/null
dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_src_path/$module_prefix$module_name.Infrastructure/$module_prefix$module_name.Infrastructure.csproj" > /dev/null

dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_tests_path/$module_prefix$module_name.Api.Tests/$module_prefix$module_name.Api.Tests.csproj" > /dev/null
dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_tests_path/$module_prefix$module_name.Application.Tests/$module_prefix$module_name.Application.Tests.csproj" > /dev/null
dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_tests_path/$module_prefix$module_name.Application.Interfaces.Tests/$module_prefix$module_name.Application.Interfaces.Tests.csproj" > /dev/null
dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_tests_path/$module_prefix$module_name.Domain.Tests/$module_prefix$module_name.Domain.Tests.csproj" > /dev/null
dotnet sln "$module_path/$module_prefix$module_name.sln" add "$module_tests_path/$module_prefix$module_name.Infrastructure.Tests/$module_prefix$module_name.Infrastructure.Tests.csproj" > /dev/null
echo "Complete. The module can be found at $module_path."