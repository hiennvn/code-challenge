using CodeChallenges.Utils;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CodeChallenges.Models
{
    public class RankingItem
    {
        public int UserId { get; private set; }

        public UserProfile UserProfile { get; private set; }

        public Challenge Challenge { get; private set; }

        public DateTime? FirstAttempt { get; private set; }

        public DateTime? CorrectTime { get; private set; }

        public TimeSpan? Duration
        {
            get
            {
                if ( CorrectTime != null )
                    return CorrectTime - FirstAttempt;
                else
                    return Challenge.EndTime - FirstAttempt;
            }
        }

        public int NumberOfSolvedProblem { get; private set; }

        public int NumberOfSubmission { get; private set; }

        public RankingItem( Challenge challenge, int userId )
        {
            Entities db = new Entities();
            Challenge = challenge;
            UserId = userId;
            UserProfile = db.UserProfiles.SingleOrDefault( u => u.UserId == userId );

            YourChallenge yourChallenge = new YourChallenge( Challenge.Id, userId );

            FirstAttempt = yourChallenge.StartTime;
            CorrectTime = yourChallenge.CorrectTime;

            NumberOfSolvedProblem = yourChallenge.NumberOfSolvedProblem;

            NumberOfSubmission = 0;

            foreach ( YourProblem problem in yourChallenge.Problems )
                if ( problem.Submissions != null )
                    NumberOfSubmission += problem.Submissions.Count();
        }
    }

    public class RankingTable
    {
        public IList<RankingItem> Items { get; private set; }

        private Entities db = new Entities();

        public RankingTable( int challengeId )
            : this( new Entities().Challenges.SingleOrDefault( c => c.Id == challengeId ) )
        {
        }

        public RankingTable( Challenge challenge )
        {
            List<int> problemIds = challenge.Problems.Select( p => p.Id ).ToList();
            var userIds = db.Solvings.Where( s => problemIds.Contains( s.ProblemId.Value ) ).Select( s => s.UserId ).Distinct();

            Items = new List<RankingItem>();

            foreach ( int userId in userIds )
            {
                RankingItem item = new RankingItem( challenge, userId );
                item = (RankingItem)TimeZoneUtil.FromUTC( item );
                Items.Add( item );
            }

            Items = Items.OrderByDescending( i => i.NumberOfSolvedProblem ).ThenBy( i => i.Duration ).ThenBy( i => i.NumberOfSubmission ).ToList();
        }
    }
}