Bei lokalem Build:

1. PAT in Azure DevOps erstellen
2. Umgebungsvariable setzen: export NUGET_AUTH_TOKEN=PASTE_YOUR_PAT_TOKEN_HERE
3. dotnet restore TestApp/TestApp.csproj


Cache Leeren:
dotnet nuget locals all --clear
dotnet restore TestApp/TestApp.csproj
