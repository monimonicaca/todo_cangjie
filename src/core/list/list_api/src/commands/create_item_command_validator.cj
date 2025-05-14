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
public class CreateItemCommandValidator <: AbstractValidator<CreateItemCommand> {
    public CreateItemCommandValidator(listQueryService: IListQueryService) {
        @NVRuleFor({p => p.listId})
            .must {listId => listQueryService.get(listId).status == Success}
            .withMessage("invalid listId")
    }
}
