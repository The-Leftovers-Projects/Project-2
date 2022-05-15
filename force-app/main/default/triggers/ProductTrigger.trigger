trigger ProductTrigger on Product2 (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    // ProductHelper.RequireDescription(trigger.new);
    // }
    
    switch on trigger.operationType {
        when BEFORE_INSERT {
            ProductHelper.RequireDescription(trigger.new);
        }
        when BEFORE_UPDATE {
            ProductHelper.RequireDescription(trigger.new);
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            ProductHelper.NewInspectionOrder(trigger.new);
        }
        when AFTER_UPDATE {
            
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
    }
}