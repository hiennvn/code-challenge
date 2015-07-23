using CodeChallenges.Models;
using System;
using System.Linq;
using System.Reflection;

namespace CodeChallenges.Utils
{
    public class TimeZoneUtil
    {
        private static Entities dbContext;
        private static string timeZoneId;

        static TimeZoneUtil()
        {
            dbContext = new Entities();
            Setting settings = dbContext.Settings.SingleOrDefault( s => s.Key.ToLower().Equals( "timezone" ) );
            timeZoneId = settings.Value;
        }

        public static DateTime? ConvertDateTimeToUTC( DateTime? date )
        {
            if ( date == null )
                return null;

            TimeZoneInfo tzInfo = TimeZoneInfo.FindSystemTimeZoneById( timeZoneId );
            return TimeZoneInfo.ConvertTimeToUtc( date.Value, tzInfo );
        }

        public static DateTime? ConvertDateTimeFromUTC( DateTime? date )
        {
            if ( date == null )
                return null;

            TimeZoneInfo tzInfo = TimeZoneInfo.FindSystemTimeZoneById( timeZoneId );
            return TimeZoneInfo.ConvertTimeFromUtc( date.Value, tzInfo );
        }

        public static object FromUTC( object obj )
        {
            Type type = obj.GetType();
            PropertyInfo[] propInfos = type.GetProperties();
            foreach ( PropertyInfo propInfo in propInfos )
            {
                string propName = propInfo.PropertyType.Name.ToLower();
                if ( propName.Equals( "datetime" ) || propName.Equals( "datetime2" ) )
                {
                    propInfo.SetValue( obj, ConvertDateTimeFromUTC( (DateTime?)propInfo.GetValue( obj ) ) );
                }
            }

            return obj;
        }

        public static object ToUTC( object obj )
        {
            Type type = obj.GetType();
            PropertyInfo[] propInfos = type.GetProperties();
            foreach ( PropertyInfo propInfo in propInfos )
            {
                string propName = propInfo.PropertyType.Name.ToLower();
                if ( propName.Equals( "datetime" ) || propName.Equals( "datetime2" ) )
                {
                    propInfo.SetValue( obj, ConvertDateTimeToUTC( (DateTime?)propInfo.GetValue( obj ) ) );
                }
            }

            return obj;
        }
    }
}