class Ability
  include CanCan::Ability

  def initialize(usuario)
    # Admin users
    if usuario.role? "admin"
        can :access, :rails_admin # panel de administracion
        can :dashboard # panel de administracion
        can :manage, :all
        cannot :manage, [ Aviso, Notificacion ]
    elsif usuario.role? "employee"
        can :manage, Expediente
        can :manage, Justificante
        can :manage, Informe
    elsif usuario
        can :manage, Expediente, cliente_id: usuario.cliente_ids
        can :manage, Justificante, cliente_id: usuario.cliente_ids
        can :manage, Informe, cliente_id: usuario.cliente_ids 
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
