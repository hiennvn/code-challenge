//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CodeChallenges.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Challenge
    {
        public Challenge()
        {
            this.Problems = new HashSet<Problem>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
        public System.DateTime CreateDate { get; set; }
        public Nullable<System.DateTime> StartTime { get; set; }
        public Nullable<System.DateTime> EndTime { get; set; }
        public string Description { get; set; }
    
        public virtual ICollection<Problem> Problems { get; set; }
    }
}