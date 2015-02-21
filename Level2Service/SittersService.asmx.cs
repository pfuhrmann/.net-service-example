using System;
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
    [WebService(Namespace = "http://stuiis.cms.gre.ac.uk/fp202/")]
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
        public XmlDocument Sitters(string type, string sort, string limit, string page)
        {
            XDocument doc;

            try
            {
                var services = _context.Services.AsEnumerable();

                // Type filtering
                if (!String.IsNullOrEmpty(type))
                {
                    services = services.Where(
                        s => s.Type.Contains(type)
                    ).AsEnumerable();
                }

                // Sort filtering
                switch (sort)
                {
                    case "priceasc":
                        services = services.OrderBy(s => s.Charges);
                        break;
                    case "pricedesc":
                        services = services.OrderByDescending(s => s.Charges);
                        break;
                    case "location":
                        services = services.OrderBy(s => s.Location);
                        break;
                    default:
                        services = services.OrderBy(s => s.Charges);
                        break;
                }

                // Pagination
                var pageParsed = 1;
                if (!String.IsNullOrEmpty(page))
                {
                    pageParsed = Convert.ToInt32(page);
                }

                if (!String.IsNullOrEmpty(limit))
                {
                    int limitParsed = Convert.ToInt32(limit);
                    services = services.Skip(limitParsed * (pageParsed - 1)).Take(limitParsed);
                }

                doc = new XDocument(
                    CreateDeclaration(),
                    new XElement("sitters",
                      from service in services select 
                        new XElement("sitter",
                            new XAttribute("id", service.Sitter.Id),
                            new XElement("name",
                                new XElement("firstname", service.Sitter.FirstName),
                                new XElement("lastname", service.Sitter.LastName)
                            ),
                            new XElement("service",
                                    new XElement("type", service.Type),
                                    new XElement("charges", service.Charges),
                                    new XElement("location", service.Location)
                                )
                            )
                        )
                    );
            }
            catch (Exception e)
            {
                if (e is FormatException)
                {
                    doc = CreateErrorDocument("sitter", "Limit and page parameters must be numeric");
                }
                else
                {
                    doc = CreateErrorDocument("sitter", e.Message);
                }
            }

            return ToXmlDocument(doc);
        }

        [WebMethod]
        public XmlDocument SitterDetails(string id)
        {
            XDocument doc;

            try
            {
                var sitter = _context.Sitters.Find(Convert.ToInt32(id));

                doc = new XDocument(
                    CreateDeclaration(),
                    new XElement("sitter_detail",
                        new XAttribute("id", sitter.Id),
                        new XElement("name",
                            new XElement("firstname", sitter.FirstName),
                            new XElement("lastname", sitter.LastName)
                        ),
                        new XElement("email", sitter.Email),
                        new XElement("phone", sitter.Phone),
                        new XElement("services",
                        from service in sitter.Services
                        select
                            new XElement("service",
                                new XElement("type", service.Type),
                                new XElement("location", service.Location),
                                new XElement("availability", service.Availability),
                                new XElement("description", service.Description),
                                new XElement("charges", service.Charges),
                                new XElement("images",
                                from image in service.Images
                                select
                                    new XElement("image",
                                        new XElement("image_url", image.code)
                                    )
                                )
                            )
                        )
                    )
                );
            }
            catch (Exception e)
            {
                if (e is NullReferenceException)
                {
                    doc = CreateErrorDocument("sitter_detail", "Record with provided ID does not exist");
                }
                else if (e is FormatException)
                {
                    doc = CreateErrorDocument("sitter_detail", "ID must be numeric");
                }
                else
                {
                    doc = CreateErrorDocument("sitter_detail", e.Message);
                }
            }

            return ToXmlDocument(doc);
        }

        // Convert XDocument to XMLDocument
        // http://www.aspnetify.com/2014/04/convert-between-xdocument-and.html
        private XmlDocument ToXmlDocument(XDocument xdoc)
        {
            var xmlDocument = new XmlDocument();
            using (var reader = xdoc.CreateReader())
            {
                xmlDocument.Load(reader);
            }

            return xmlDocument;
        }

        // Create new XML document declaration
        private XDeclaration CreateDeclaration()
        {
            return new XDeclaration("1.0", "utf-8", "yes");
        }

        // Crate new XML error document
        private XDocument CreateErrorDocument(string root, string message)
        {
            return new XDocument(
                CreateDeclaration(),
                new XElement(root,
                    new XElement("error_message", message)
                )
            );
        }
    }
}
