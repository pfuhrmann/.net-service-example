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
        public XmlDocument Sitters(string type, string limit, string page)
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

                if (!String.IsNullOrEmpty(limit))
                {
                    int limitInt = Int32.Parse(limit);

                    int pageInt = 1;
                    if (!String.IsNullOrEmpty(page))
                    {
                        pageInt = Int32.Parse(page);
                    }

                    services = services.Skip((pageInt - 1) * limitInt).Take(limitInt).AsEnumerable();
                }

                doc = new XDocument(
                    CreateDeclaration(),
                    new XElement("sitters",
                      from service in services select 
                        new XElement("sitter",
                            new XAttribute("id", service.Id),
                            new XAttribute("service", "lewisham"),
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
                var sitter = _context.Services.Find(Convert.ToInt32(id));

                doc = new XDocument(
                    CreateDeclaration(),
                    new XElement("sitter_detail",
                        new XAttribute("id", id),
                        new XElement("name",
                            new XElement("firstname", sitter.Sitter.FirstName),
                            new XElement("lastname", sitter.Sitter.LastName)
                        ),
                        new XElement("email", sitter.Sitter.Email),
                        new XElement("phone", sitter.Sitter.Phone),
                        new XElement("service",
                            new XElement("type", sitter.Type),
                            new XElement("location", sitter.Location),
                            new XElement("availability", sitter.Availability),
                            new XElement("description", sitter.Description),
                            new XElement("charges", sitter.Charges),
                            new XElement("images",
                            from image in sitter.Images
                            select
                                new XElement("image",
                                    new XElement("image_url", image.code)
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
