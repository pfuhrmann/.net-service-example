//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataModel
{
    using System;
    using System.Collections.Generic;
    
    public partial class Service
    {
        public Service()
        {
            this.Images = new HashSet<Image>();
        }
    
        public int Id { get; set; }
        public string Postcode { get; set; }
        public string Type { get; set; }
        public string Location { get; set; }
        public string Availability { get; set; }
        public string Description { get; set; }
        public string Charges { get; set; }
    
        public virtual Sitter Sitter { get; set; }
        public virtual ICollection<Image> Images { get; set; }
    }
}