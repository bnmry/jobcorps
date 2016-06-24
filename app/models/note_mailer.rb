class NoteMailer < ActionMailer::Base

  def employer(note)
    @subject    = 'Application From an AU Student on JobCorps'
    @body["note"] = note
    @recipients = note.job.user.email
    @from       = "jobcorps@ausg.org"
    @headers    = {}
  end

  def student(note)
    @subject    = 'You have mail from an employer on JobCorps'
    @body["note"]       = note
    @recipients = note.student.user.email
    @from       = "jobcorps@ausg.org"
    @headers    = {}
  end
end
