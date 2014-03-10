//
//  TSFQuestionnaireIntroViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 02-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaireIntroViewController.h"
#import "TSFCompetenceViewController.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFStartQuestionnaireSegue = @"TSFStartQuestionnaireSegue";

@interface TSFQuestionnaireIntroViewController()
@property (nonatomic, strong) NSString *subjectLabelFormat;
@end

@implementation TSFQuestionnaireIntroViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        _questionnaireService = [TSFQuestionnaireService sharedService];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *titleLabel = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerWelcome", @"Welkom,");
    self.subjectLabelFormat = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerSubject", @"De vragen in deze ronde gaan over %@.");
    NSString *introLabel = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerIntro", @"Je bent uitgenodigd om mee te doen met een 360°-feedbackronde.");
    NSString *timeLabel = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerTime", @"Het beantwoorden van de vragen duurt ongeveer 15 minuten.");
    NSString *startButton = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerStart", @"Begin met het beantwoorden");
    
    self.title = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerTitle", @"Feedback round");
    self.titleLabel.text = titleLabel;
    self.introLabel.text = introLabel;
    self.timeLabel.text = timeLabel;
    self.subjectLabel.text = [NSString stringWithFormat:self.subjectLabelFormat, @""];
    self.infoLabel.attributedText = [self createAttributedInfoString];
    [self.startButton setTitle:startButton forState:UIControlStateNormal];
    
    self.startButton.enabled = NO;
    
    [self loadQuestionnaire];
}

- (void)loadQuestionnaire {
    __block typeof(self) _self = self;
    
    [self.questionnaireService questionnairesWithSuccess: ^(NSArray *questionnaires) {
        _self.questionnaire = [questionnaires firstObject];
        [_self displaySubjectTitle];
        [_self enableStartButton];
    } failure: ^(NSError *error) {
        NSLog(@"Error loading questionnaires. Userinfo: %@. Error: %@", error.userInfo, error.localizedDescription);
    }];
}

- (void)displaySubjectTitle {
    self.subjectLabel.text = [NSString stringWithFormat:self.subjectLabelFormat, self.questionnaire.subject];
}

- (NSAttributedString *)createAttributedInfoString {
    NSString *infoLabel = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerInfo", @"Je krijgt zo een aantal uitspraken te zien. Geef voor elke uitspraak aan in hoeverre jij het er mee eens bent op een schaal van %@, waarbij %@ betekent dat je het er %@ bent en %@ betekent dat je het er %@ bent.");
    NSString *scale = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerScale", @"1 tot 5");
    NSString *scaleBottom = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerScaleBottom", @"1");
    NSString *scaleTop = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerScaleTop", @"5");
    NSString *completelyDisagree = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerCompletelyDisagree", @"totaal niet mee eens");
    NSString *completelyAgree = TSFLocalizedString(@"TSFQuestionnaireIntroViewControllerCompletelyAgree", @"volkomen mee eens");
    
    NSString *fullInfoString = [NSString stringWithFormat:infoLabel, scale, scaleBottom, completelyDisagree, scaleTop, completelyAgree];
    __block NSMutableAttributedString *attributedInfoString = [[NSMutableAttributedString alloc] initWithString:fullInfoString
                                                                                                     attributes:nil];
    
    [attributedInfoString beginEditing];
    [self boldMatchedString:scale inMutableAttributedString:attributedInfoString];
    [self boldMatchedString:scaleBottom inMutableAttributedString:attributedInfoString];
    [self boldMatchedString:completelyDisagree inMutableAttributedString:attributedInfoString];
    [self boldMatchedString:scaleTop inMutableAttributedString:attributedInfoString];
    [self boldMatchedString:completelyAgree inMutableAttributedString:attributedInfoString];
    [attributedInfoString endEditing];
    
    return attributedInfoString;
}

- (void)boldMatchedString:(NSString *)matchedString inMutableAttributedString:(NSMutableAttributedString *)attributedString {
    CGFloat fontSize = 13.0;
    NSString *fontName = @"Helvetica-Bold";
    
    NSError *error = nil;
    NSRegularExpression *scaleRegex = [NSRegularExpression regularExpressionWithPattern:matchedString
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    NSTextCheckingResult *scaleResult = [scaleRegex firstMatchInString:(NSString *)attributedString.string
                                                               options:0
                                                                 range:NSMakeRange(0, [attributedString length])];
    [attributedString addAttribute:NSFontAttributeName
                                 value:[UIFont fontWithName:fontName size:fontSize]
                                 range:NSMakeRange(scaleResult.range.location, scaleResult.range.length)];
}

- (void)enableStartButton {
    self.startButton.enabled = YES;
}

- (IBAction)startButtonPressed:(id)sender {
    [self performSegueWithIdentifier:TSFStartQuestionnaireSegue sender:self];
}

@end
