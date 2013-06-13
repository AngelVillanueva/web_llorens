class Ability
  include CanCan::Ability

  def initialize(usuario)
    # panel de administración
    if usuario.role? "admin"
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
    end
    # área de clientes
    if usuario
        can :manage, Expediente, organizacion_id: usuario.organizacion_id
        can :manage, Justificante, organizacion_id: usuario.organizacion_id
        can :manage, Informe, organizacion_id: usuario.organizacion_id
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
