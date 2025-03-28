using Alice.IO;
using Alice.Shell;
using Alice.Diagnostics;
using Alice.Environment;

namespace WSOFT.Installer;

public string GetRepositoryName(string address)
{
    // Split the address by '/' and return the last part
    var parts = address.Split('/');
    return parts[parts.Length - 1];
}

string address = "https://github.com/wsoft-ws/icebuild";
string repoName = GetRepositoryName(address);
string tmpDir = "/tmp/000000";

const ALICE_DIR = "/Users/taiseiue/tmp";
//const ALICE_DIR = $"{env_impl_location()}/../.alice";
exec("git", $"clone {address} {tmpDir}");

BuildPkg($"{tmpDir}/{repoName}", $"{ALICE_DIR}/{repoName}.ice");

// file_move($"{tmpDir}/{repoName}.ice", $"{ALICE_DIR}/{repoName}.ice", true);

// Clean up
directory_delete(tmpDir, true);
