using DataModel;
using System.Linq;
using System.Web.Services;
using System.Xml;
using System.Xml.Linq;

namespace Level2Service
{
    /// <summary>
    /// Service providing Sitters data parsed from DB
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
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

            XDocument doc = new XDocument(
                new XDeclaration("1.0", "utf-8", "yes"),
                new XElement("sitters",
                  from sitter in query select 
                    new XElement("sitter",
                        new XElement("name",
                            new XElement("firstname", sitter.FirstName),
                            new XElement("lastname", sitter.LastName)
                        ),
                        new XElement("sitter_id", sitter.Id),
                        new XElement("email", sitter.Email),
                        new XElement("phone", sitter.Phone)
                    )
                )
            );

            return ToXmlDocument(doc);
        }

        [WebMethod]
        public XmlDocument SitterDetails(int id)
        {
            var sitter = _context.Sitters.Find(id);

            XDocument doc = new XDocument(
                new XDeclaration("1.0", "utf-8", "yes"),
                new XElement("sitter_detail",
                    new XElement("name",
                        new XElement("firstname", sitter.FirstName),
                        new XElement("lastname", sitter.LastName)
                    ),
                    new XElement("sitter_id", sitter.Id),
                    new XElement("email", sitter.Email),
                    new XElement("phone", sitter.Phone),
                    new XElement("services",
                        from service in sitter.Services select
                          new XElement("service",
                              new XElement("type", service.Type),
                              new XElement("location", service.Location),
                              new XElement("availability", service.Availability),
                              new XElement("description", service.Description),
                              new XElement("charges", service.Charges),
                              new XElement("images",
                                  from image in service.Images select
                                    new XElement("image",
                                        new XElement("image_url", image.code)
                                    )
                              )
                          )
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
