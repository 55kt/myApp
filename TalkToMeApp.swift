import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      setUpPushNotifications(for: application)

    return true
  }
    
    private func setUpPushNotifications(for application: UIApplication) {
        let notificationCenter = UNUserNotificationCenter.current()
        Messaging.messaging().delegate = self
        notificationCenter.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) { granted, error in
            
            if let error = error {
                print("APNS Failed to request authorization: \(error.localizedDescription)")
                return
            }
            if granted {
                print("APNS Authorization granted")
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            } else {
                print("APNS Authorization was denied")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print(("APNS device Token is: \(fcmToken)"))
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("APNS successfully registed for push notification: \(deviceToken)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .banner, .badge]
    }
}

@main
struct TalkToMeApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      RootScreen()
    }
  }
}
