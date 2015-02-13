using DataModel;
using System.Linq;
using System.Web.Services;
using System.Xml;
using System.Xml.Linq;

namespace Level2Service
{
    /// <summary>
    /// Summary description for SittersService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class SittersService : WebService
    {

        private readonly DataModelContainer _context;

        public SittersService()
        {
            _context = new DataModelContainer();
        }

        [WebMethod]
        public XmlDocument Sitters()
        {
            var query = _context.Sitters.AsEnumerable();

            // Map DB Sitters to XML
            XDocument doc = new XDocument(
                new XDeclaration("1.0", "utf-8", "yes"),
                new XElement("Sitters",
                  // LINQ query to build the child element.
                  from c in query
                  select new XElement("Sitter",
                    new XAttribute("firstname", c.FirstName),
                    new XAttribute("lastname", c.LastName)
                  )
                )
            );

            return ToXmlDocument(doc);
        }

        // Convert XDocument to XMLDocument
        // http://www.aspnetify.com/2014/04/convert-between-xdocument-and.html
        public static XmlDocument ToXmlDocument(XDocument xdoc)
        {
            var xmlDocument = new XmlDocument();
            using (var reader = xdoc.CreateReader())
            {
                xmlDocument.Load(reader);
            }

            return xmlDocument;
        }
    }
}
