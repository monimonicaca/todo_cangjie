package list_api.commands

import list_domain.aggregate_models.*
import list_api.queries.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivevalidation
import naivevalidation.*
import naivevalidation.macros.*

@NIService
public class UpdateItemContentCommandValidator <: AbstractValidator<UpdateItemContentCommand> {
    public UpdateItemContentCommandValidator(itemQueryService: IItemQueryService) {
        @NVRuleFor({p => p.id}).must {id => itemQueryService.get(id).status == Success}.withMessage("no such item")
    }
}
