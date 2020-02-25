using System.Xml;
using WorkflowForms;
using WorkflowForms.Conditions;

namespace WorkflowForms.Conditions
{
    public class EmptyFolderCondition : AbstractMultiCondition
    {
        public EmptyFolderCondition(IWorkflowForm form, XmlNode node)
            : base(form, node)
        {
        }

        public override void InternalInit(XmlNode node, IWorkflowForm form)
        {
            base.InternalInit(node, form);
            this.CheckCondition();
        }

        protected override bool CheckValue(object[] values)
        {
            //return values.Length > 0 && !Directory.EnumerateFileSystemEntries(values[0].ToString()).Any(); //since .NET 4.0

            if (values.Length > 0 && values[0] != null)
            {
                string[] dirs = System.IO.Directory.GetDirectories(values[0].ToString());
                string[] files = System.IO.Directory.GetFiles(values[0].ToString());

                return dirs.Length == 0 && files.Length == 0;
            }

            return false;
        }
    }
}
