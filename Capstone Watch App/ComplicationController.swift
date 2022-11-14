//
//  ComplicationController.swift
//  Capstone Watch App
//
//  Created by 송재훈 on 2022/11/14.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {

        var descriptors: [CLKComplicationDescriptor] = []

        for data in UserData.shared.Datalist {
            var dataDict = Dictionary<AnyHashable, Any>()
            dataDict = ["id": data.id]

            let userActivity = NSUserActivity(activityType: "org.codechimp.multicomp")
            userActivity.userInfo = dataDict

            descriptors.append(CLKComplicationDescriptor(identifier: "\(data.id)", displayName: "\(data.PetNumber)", supportedFamilies: CLKComplicationFamily.allCases, userActivity: userActivity)
            )
        }
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        handler(createTimelineEntry(for: complication, date: Date()))
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after the given date
        handler(nil)
    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached

        switch (complication.family) {
        case (.graphicRectangular):
            //handler(CLKComplicationTemplateGraphicRectangularStandardBody(headerTextProvider: simpleTextProvider1, body1TextProvider: simpleTextProvider2))
            handler(CLKComplicationTemplateGraphicRectangularFullImage(imageProvider: CLKFullColorImageProvider(fullColorImage: UIImage(systemName:"heart")!.withTintColor(.yellow))))

        case (_):
            handler(nil)
        }
    }

    func createTimelineEntry(for complication: CLKComplication, date: Date) -> CLKComplicationTimelineEntry? {
        guard let template = createTemplate(for: complication, date: date) else {
            return nil
        }

        return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    }

    func createTemplate(for complication: CLKComplication, date: Date) -> CLKComplicationTemplate? {
        if let data = UserData.shared.Datalist.first(where: {$0.id == Int(complication.identifier)}) {
            //let simpleTextProvider1 = CLKSimpleTextProvider(text: data.PetNumber)
            //let simpleTextProvider2 = CLKSimpleTextProvider(text: data.PetImage)
            
            let PetNumber = "\(data.PetImage)\(data.PetNumber)"
            
            switch (complication.family) {
            case (.graphicRectangular):
                //return CLKComplicationTemplateGraphicRectangularStandardBody(headerTextProvider: simpleTextProvider1, body1TextProvider: simpleTextProvider2)
                return CLKComplicationTemplateGraphicRectangularFullImage(imageProvider: CLKFullColorImageProvider(fullColorImage: UIImage(named:PetNumber)!))
            case (_):
                return nil
            }
        }
        else {
            return nil
        }
    }
}
