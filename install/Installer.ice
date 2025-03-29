using Alice.IO;
using Alice.Shell;
using Alice.Random;
using Alice.Diagnostics;
using Alice.Environment;

namespace WSOFT.AliceScript.Installer;

private string GetRepositoryName(string address)
{
    // Split the address by '/' and return the last part
    var parts = address.Split('/');
    return parts[parts.Length - 1];
}
private string GetRepositoryTag(string address)
{
    number ind = address.LastIndexOf("@");
    if(ind == -1)
    {
        return "";
    }
    return address.Substring(ind + 1);
}

private array SplitRemoteAndTag(string address)
{
    number ind = address.LastIndexOf("@");
    if(ind == -1)
    {
        return [address, null];
    }
    return [address.Substring(0, ind), address.Substring(ind + 1)];
}

private string GetTemporaryDirectory()
{
    // Get the temporary directory path
    string tempDir = path_join(path_get_tempPath(), guid_new_text());
    return tempDir;
}

const ALICE_DIR = "/Users/taiseiue/tmp";

public void Install(string address)
{
    array remoteAndTag = SplitRemoteAndTag(address);

    string remote = remoteAndTag[0];
    string? tag = remoteAndTag[1];
    string tmpDir = GetTemporaryDirectory();
    string repoName = GetRepositoryName(remote);

    string git_args = $"clone {remote} {tmpDir} --depth 1";
    if(tag != null)
    {
        git_args += $" --branch {tag}";
    }
    exec("git", git_args);
    BuildPkg(path_join(tmpDir, repoName), path_join(ALICE_DIR, repoName));
    directory_delete(tmpDir, true);
}
