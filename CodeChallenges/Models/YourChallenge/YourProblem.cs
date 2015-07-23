using CodeChallenges.Utils;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CodeChallenges.Models
{
    public class YourProblem
    {
        public Problem Problem { get; private set; }

        public SolvingStatus Status { get; private set; }

        public IEnumerable<Submission> Submissions { get; private set; }

        public DateTime? FirstAttempt { get; private set; }

        public DateTime? LastAttempt { get; private set; }

        public DateTime? FirstResolved { get; private set; }

        public bool CanOpen { get; private set; }

        public bool CanSubmit { get; private set; }

        public YourProblem( Problem problem, int userId )
        {
            Entities db = new Entities();

            Problem = problem;

            CanOpen = Security.CanOpen( problem.Id, userId );
            CanSubmit = Security.CanSubmit( problem.Id, userId );

            Solving solving = db.Solvings.SingleOrDefault( s => s.ProblemId == problem.Id && s.UserId == userId );

            if ( solving == null )
            {
                Status = SolvingStatus.NOT_OPEN;
                return;
            }

            FirstAttempt = solving.FirstOpenTime;
            LastAttempt = solving.LastOpenTime;

            Submissions = db.Submissions.Where( s => s.SolvingId == solving.Id ).OrderByDescending( s => s.Time );

            if ( Submissions == null || Submissions.Count() == 0 )
            {
                Status = SolvingStatus.NOT_SUBMIT;
                return;
            }

            Submission firstResolved = Submissions.FirstOrDefault( s => s.Result != null && s.Result != 0 );

            if ( firstResolved == null )
                Status = SolvingStatus.NOT_RESOLVED;
            else
            {
                Status = SolvingStatus.RESOLVED;
                FirstResolved = firstResolved.Time;
            }
        }
    }
}