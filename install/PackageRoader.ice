using Alice.IO;
using Alice.Environment;
using Alice.Diagnostics;
using Alice.Interpreter;

namespace WSOFT.AliceScript.Installer.PackageRoader;
{
    public array ReadPackage(string package)
    {
        string rawScript = file_read_text(path_join(package, "package.ice"));

        private void require_runtime_version(string name, string version)
        {
            assert(name == env_impl_name(), "Runtime name mismatch");
            assert(env_impl_version().startsWith(version), "Runtime version mismatch");
        }

        (GetScript().GetTempScript(rawScript)).Process();
    }
}
