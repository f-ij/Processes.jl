Branch constraints for immutable_fix_manual

- Ignore ContextInjector and interactive widget tooling for now.
- Ignore Package/SubPackage execution for now. Package support will be fixed later.
- Do not extend or revive the old generated step path. That path is dead for this branch.
- RuntimeGeneratedFunctions.jl is the mechanism for the new resolve-time step factories.
- Step factories run during Plan resolve. Every resolved child gets its own generated step from the small type-based factory decision.
- CompositeAlgorithm and Routine hold typed tuples of child steps. The LoopAlgorithm wrapper owns only the top-level/root step.
- Execution should call the owned root step only at the top level. Child boundaries call their child step from the resolved child step tuple.
- OnDemandContext lives under src/Context/OnDemandContext and replaces the old view for this branch's child step path.
- Widening during stepping is disallowed now.
- Repeat(0) should not exist.
