require('utils/trace')

local Collision = {}

function Collision.beginContact(fixture1, fixture2, contact)
  trace.print('Begin Contact!', trace.styles.blue)
end

function Collision.endContact(fixture1, fixture2, contact)
  trace.print('End Contact!', trace.styles.blue)
end

function Collision.preSolve(fixture1, fixture2, contact)
  trace.print('Presolve!', trace.styles.blue)
end

function Collision.postSolve(fixture1, fixture2, contact)
  trace.print('Postsolve!', trace.styles.blue)
end

return Collision