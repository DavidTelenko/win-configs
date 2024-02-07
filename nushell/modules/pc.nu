export def hibernate [] {
  rundll32.exe powrprof.dll,SetSuspendState Hibernate
}

export def sleep [] {
  rundll32.exe powrprof.dll,SetSuspendState Sleep
}

export def restart [] {
  shutdown.exe -r -t 00
}

export def shutdown [] {
  shutdown.exe -s -t 00
}
