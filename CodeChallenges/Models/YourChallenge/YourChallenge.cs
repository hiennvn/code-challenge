using System;
using System.Collections.Generic;
using System.Linq;
using model = CodeChallenges.Models;

namespace CodeChallenges.Models
{
    public class YourChallenge
    {
        public Challenge Challenge { get; private set; }

        public IEnumerable<YourProblem> Problems { get; private set; }

        public int NumberOfProblem { get; private set; }

        public int NumberOfSolvedProblem { get; private set; }

        public DateTime? StartTime { get; private set; }

        public DateTime? CorrectTime { get; private set; }

        public TimeSpan? Duration
        {
            get
            {
                if ( StartTime != null && CorrectTime != null )
                    return CorrectTime - StartTime;
                return null;
            }
        }

        public YourChallenge( int challengeId, int userId )
        {
            Entities db = new Entities();
            Challenge = db.Challenges.SingleOrDefault( c => c.Id == challengeId );

            List<YourProblem> yourProblems = new List<YourProblem>();

            IEnumerable<model.Problem> problems = db.Problems.Where( p => p.ChallengeId == challengeId ).OrderBy( p => p.Order );

            foreach ( model.Problem p in problems )
            {
                YourProblem problem = new YourProblem( p, userId );
                yourProblems.Add( problem );
            }

            Problems = yourProblems;

            NumberOfProblem = yourProblems.Count();

            // Count number of solved problem
            NumberOfSolvedProblem = 0;
            foreach ( YourProblem problem in yourProblems )
            {
                if ( problem.Status == SolvingStatus.RESOLVED )
                    NumberOfSolvedProblem++;
            }

            // Get start time
            YourProblem firstProblem = yourProblems[ 0 ];
            Solving firstSolving = db.Solvings.SingleOrDefault( s => s.ProblemId == firstProblem.Problem.Id && s.UserId == userId );
            if ( firstSolving != null )
                StartTime = firstSolving.FirstOpenTime;

            // Get end time
            int lastSolvedProblemIndex = NumberOfProblem - 1;
            while ( yourProblems[ lastSolvedProblemIndex ].Status != SolvingStatus.RESOLVED && lastSolvedProblemIndex > 0 )
                lastSolvedProblemIndex--;

            // First correct submission
            int lastSolvedProblemId = yourProblems[ lastSolvedProblemIndex ].Problem.Id;
            Solving lastCorrectSolving = db.Solvings.SingleOrDefault( s => s.ProblemId == lastSolvedProblemId && s.UserId == userId );
            if ( lastCorrectSolving != null )
            {
                IList<Submission> submissions = lastCorrectSolving.Submissions.OrderByDescending( s => s.Result ).ThenBy( s => s.Time ).ToList();
                if ( submissions != null && submissions.Count > 0 )
                {
                    CorrectTime = submissions.ToList()[ 0 ].Time;
                }
            }
        }
    }
}