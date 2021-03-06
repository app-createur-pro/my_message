
class Strings {
  //General
  static const String titleApp = "Chat App";
  static const String ok = "OK";

  static const String email = "Email";
  static const String password = "Mot de passe";
  static const String name = "Nom";
  static const String dateSelect = "Sélectionnez une date";

  //Authentication
  static const String forgetPassword = "Mot de passe oublié ?";
  static const String noAccount = "Vous n’avez pas de compte ?";
  static const String alreadyAccount = "Vous avez déjà un compte ?";
  static const String signUp = "S’inscrire";
  static const String signUpTitle = "Inscription";
  static const String signIn = "Se connecter";
  static const String acceptConditions = "J’accepte les conditions d’utilisation";
  static const String successRegister = "L'inscription est un succès";

  //Search
  static const String search = "Recherchez...";
  static const String filter = "Filtrez...";
  static const String searchContact = "Recherchez des personnes";
  static const String noContactFound = "Aucun contact trouvé";

  //Messages
  static const String tapMessage = "Tapez votre message…";
  static const String exampleDate = "13/05/21 - 18:50";
  static const String noRoomsYet = "Vous n'avez pas encore de conversation";

  //Errors
  static const String errorGenerics = "Une erreur est survenue";
  static const String errorFirebaseInit = "Erreur d'initialisation firebase";
  static const String errorAuthStream = "Erreur lors de la récupération des utilisateurs";

  //Form errors
  static const String errorEmptyField = "Le champs de formulaire ne peut pas être vide";
  static const String errorPasswordLength = "Le mot de passe doit faire au moins 8 caractères";
  static const String errorPasswordWeak = "Le mot de passe est trop faible";
  static const String errorNotEmail = "Ce n'est pas un format d'adresse email";

  //Auth firebase errors
  static const String errorAuthSignUp = "Erreur d'inscription";
  static const String errorAccountAlreadyExists = "Le compte existe déjà avec cet email";
  static const String errorNoUserForThisEmail = "Pas d'utilisateur trouvé pour cet email";
  static const String errorWrongPassword = "Le mot de passe est erroné";
  static const String errorUserDisabled = "Utilisateur supprimé par l'administrateur";
  static const String errorLogOut = "Deconnexion impossible, une erreur est survenue";
  static const String errorUserNotFound = "Utilisateur introuvable ou compte désactivé";
  static const String errorGetRoomsMessages = "Erreur lors de la récupération des conversations";
  static const String errorGetUsers = "Erreur lors de la récupération des infos utilisateur";

  //Firestore errors
  static const String getMessagesError = "Erreur de récupération des messages";
  static const String getRoomError = "Erreur d'ouverture de la conversation";
  static const String addMessageError = "Erreur lors de l'ajout d'un message";

  //Auth firebase
  static const String alertConfirmSignOut = "Voulez vous vraiment vous déconnecter ?";

  //Firebase Queries & Models
  static const String usersCollection = "users";
  static const String userModelId = "userId";
  static const String userModelName = "userName";
  static const String userModelImagePath = "imagePath";
  static const String roomsCollection = "rooms";
  static const String messagesCollection = "messages";
  static const String messageModelTextMessage = "textMessage";
  static const String messageModelTimestamp = "timestamp";
  static const String noMessage = "Vous n'avez pas encore de messages avec cette personne";
  static const String idsArrayFirestore = "userIds";
  static const String lastMessageFirestore = "lastMessage";
  static const String lastIdFirestore = "lastId";
  static const String lastDateMessageFirestore = "lastDateMessage";
  static const String roomIdFirestore = "roomId";
}

class ImagesPaths {

  static const String logoPath = "assets/images/Logo-App-Createur-Pro-sombre.png";

}

/*
GridView.count(
mainAxisSpacing: 20,
crossAxisSpacing: 20,
crossAxisCount: 1,
childAspectRatio: 7.23,
children: [
*/





