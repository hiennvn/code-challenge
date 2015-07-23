using CodeChallenges.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CodeChallenges.Utils
{
    public class Security
    {
        private static Entities db = new Entities();

        public static bool CanOpen( int problemId, int userId )
        {
            Problem problem = db.Problems.SingleOrDefault( p => p.Id == problemId );

            if ( problem == null )
                return false;

            Solving solving = db.Solvings.SingleOrDefault( s => s.ProblemId == problemId && s.UserId == userId );

            if ( solving != null )
                return true;

            Challenge challenge = db.Challenges.SingleOrDefault( c => c.Id == problem.ChallengeId );

            if ( challenge == null )
                return false;

            if ( challenge.StartTime < DateTime.UtcNow && DateTime.UtcNow < challenge.EndTime )
            {
                if ( problem.Order == 1 )
                    return true;

                IEnumerable<int> problemIds = db.Problems.Where( p => p.ChallengeId == problem.ChallengeId ).Select( p => p.Id );
                var solvings = db.Solvings.Where( s => problemIds.Contains( s.ProblemId.Value ) && s.Result != null && s.Result != 0 && s.UserId == userId );

                if ( solvings != null && solvings.Count() == problem.Order - 1 )
                    return true;

                return false;
            }

            return false;
        }

        public static bool CanSubmit( int problemId, int userId )
        {
            Problem problem = db.Problems.SingleOrDefault( p => p.Id == problemId );

            if ( problem == null )
                return false;

            Solving solving = db.Solvings.SingleOrDefault( s => s.ProblemId == problemId && s.UserId == userId );

            if ( solving == null )
                return false;

            Challenge challenge = db.Challenges.SingleOrDefault( c => c.Id == problem.ChallengeId && c.StartTime < DateTime.UtcNow && DateTime.UtcNow < c.EndTime );

            return ( challenge != null );
        }
    }
}