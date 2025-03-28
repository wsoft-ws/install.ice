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
public string GetRepositoryTag(string address)
{
    number ind = address.LastIndexOf("@");
    if(ind == -1)
    {
        return "";
    }
    return address.Substring(ind + 1);
}

array args = env_commandLineArgs();
if(args.Length < 1)
{
    //showError("Source directory not specified.");
}

string address = "https://github.com/wsoft-ws/icebuild"; // args[0];
string repoName = GetRepositoryName(address);
string tag = GetRepositoryTag(address);
string tmpDir = "/tmp/000000";

const ALICE_DIR = "/Users/taiseiue/tmp";
//const ALICE_DIR = $"{env_impl_location()}/../.alice";

string git_args = $"clone {address} {tmpDir} --depth 1";

if(tag != "")
{
    git_args += $" --branch {tag}";
}

exec("git", git_args);

BuildPkg($"{tmpDir}/{repoName}", $"{ALICE_DIR}/{repoName}.ice");

// file_move($"{tmpDir}/{repoName}.ice", $"{ALICE_DIR}/{repoName}.ice", true);

// Clean up
directory_delete(tmpDir, true);
