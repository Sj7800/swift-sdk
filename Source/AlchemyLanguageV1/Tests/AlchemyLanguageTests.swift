/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import XCTest
import AlchemyLanguageV1

class AlchemyLanguageTests: XCTestCase {
    
    private var alchemyLanguage: AlchemyLanguage!
    private let timeout: TimeInterval = 5.0
    private let testUrl = "http://arstechnica.com/gadgets/2016/05/android-instant-apps-will-blur-the-lines-between-apps-and-mobile-sites/"
    
    override func setUp() {
        super.setUp()
        alchemyLanguage = AlchemyLanguage(apiKey: Credentials.AlchemyAPIKey)
    }
    
    static var allTests : [(String, (AlchemyLanguageTests) -> throws Void)] {
        return [
            ("testGetAuthorsURL", testGetAuthorsURL),
            ("testGetAuthorsHtml", testGetAuthorsHtml),
            ("testGetRankedConceptsURL", testGetRankedConceptsURL),
            ("testGetRankedConceptsHtml", testGetRankedConceptsHtml),
            ("testGetRankedConceptsHtmlWithEnum0", testGetRankedConceptsHtmlWithEnum0),
            ("testGetRankedConceptsHtmlWithEnum1", testGetRankedConceptsHtmlWithEnum1),
            ("testGetRankedConceptsText", testGetRankedConceptsText),
            ("testGetRankedNamedEntitiesURL", testGetRankedNamedEntitiesURL),
            ("testGetRankedNamedEntitiesHtml", testGetRankedNamedEntitiesHtml),
            ("testGetRankedNamedEntitiesText", testGetRankedNamedEntitiesText),
            ("testGetRankedKeywordsURL", testGetRankedKeywordsURL),
            ("testGetRankedKeywordsHtml", testGetRankedKeywordsHtml),
            ("testGetRankedKeywordsText", testGetRankedKeywordsText),
            ("testGetLanguageURL", testGetLanguageURL),
            ("testGetLanguageText", testGetLanguageText),
            ("testGetMicroformatsURL", testGetMicroformatsURL),
            ("testGetMicroformatsHtml", testGetMicroformatsHtml),
            ("testGetPubDateURL", testGetPubDateURL),
            ("testGetPubDateHtml", testGetPubDateHtml),
            ("testGetRelationsURL", testGetRelationsURL),
            ("testGetRelationsHtml", testGetRelationsHtml),
            ("testGetRelationsText", testGetRelationsText),
            ("testGetTextSentimentURL", testGetTextSentimentURL),
            ("testGetTextSentimentHtml", testGetTextSentimentHtml),
            ("testGetTextSentimentText", testGetTextSentimentText),
            ("testGetTargetedSentimentURL", testGetTargetedSentimentURL),
            ("testGetTargetedSentimentHtml", testGetTargetedSentimentHtml),
            ("testGetTargetedSentimentText", testGetTargetedSentimentText),
            ("testGetRankedTaxonomyURL", testGetRankedTaxonomyURL),
            ("testGetRankedTaxonomyHtml", testGetRankedTaxonomyHtml),
            ("testGetRankedTaxonomyText", testGetRankedTaxonomyText),
            ("testGetRawTextURL", testGetRawTextURL),
            ("testGetRawTextHtml", testGetRawTextHtml),
            ("testGetTextURL", testGetTextURL),
            ("testGetTextHtml", testGetTextHtml),
            ("testGetTitleURL", testGetTitleURL),
            ("testGetTitleHtml", testGetTitleHtml),
            ("testDetectFeedsURL", testDetectFeedsURL),
            ("testDetectFeedsHtml", testDetectFeedsHtml),
            ("testGetEmotionURL", testGetEmotionURL),
            ("testGetEmotionHtml", testGetEmotionHtml),
            ("testGetEmotionText", testGetEmotionText),
            ("testGetEmotionText", testGetEmotionText)
        ]
    }
    
    /** Fail false negatives. */
    func failWithError(error: Error) {
        XCTFail("Positive test failed with error: \(error)")
    }
    
    /** Fail false positives. */
    func failWithResult<T>(result: T) {
        XCTFail("Negative test returned a result.")
    }
    
    /** Wait for expectations. */
    func waitForExpectations() {
        waitForExpectations(timeout: timeout) { error in
            XCTAssertNil(error, "Timeout")
        }
    }
    
    func stringFromURLString(url: String) -> String? {
        let myURL = URL(string: testUrl)
        do {
            let myHtml = try String(contentsOf: myURL!)
            return myHtml
        } catch {
            return nil
        }
    }
    
    // Positive Unit Tests
    
    func testGetAuthorsURL() {
        let description = "Get the author of an Ars article"
        let expectation = self.expectation(description: description)

        alchemyLanguage.getAuthors(fromContentAtURL: testUrl, failure: failWithError) { authors in
            XCTAssertNotNil(authors, "Response should not be nil")
            XCTAssertNotNil(authors.authors, "Authors should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetAuthorsHtml() {
        let description = "Get the author of an article, given the html"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getAuthors(fromHTMLFile: url!, failure: failWithError) { authors in
            XCTAssertNotNil(authors, "Response should not be nil")
            XCTAssertNotNil(authors.authors, "Authors should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
        
    }
    
    func testGetRankedConceptsURL() {
        let description = "Get the ranked concepts of an Ars article"
        let expectation = self.expectation(description: description)
        
        alchemyLanguage.getRankedConcepts(fromContentAtURL: testUrl, failure: failWithError) { concepts in
            XCTAssertNotNil(concepts, "Reponse should not be nil")
            XCTAssertNotNil(concepts.concepts, "Concepts should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRankedConceptsHtml() {
        let description = "Get the ranked concepts of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getRankedConcepts(fromHTMLFile: url!, failure: failWithError) { concepts in
            XCTAssertNotNil(concepts, "Response should not be nil")
            XCTAssertNotNil(concepts.concepts, "Concepts should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetRankedConceptsHtmlWithEnum0() {
        let description = "Get the ranked concepts of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getRankedConcepts(fromHTMLFile: url!, knowledgeGraph: QueryParam.excluded, failure: failWithError) { concepts in
            XCTAssertNotNil(concepts, "Response should not be nil")
            XCTAssertNotNil(concepts.concepts, "Concepts should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetRankedConceptsHtmlWithEnum1() {
        let description = "Get the ranked concepts of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getRankedConcepts(fromHTMLFile: url!, knowledgeGraph: QueryParam.included, failure: failWithError) { concepts in
            XCTAssertNotNil(concepts, "Response should not be nil")
            XCTAssertNotNil(concepts.concepts, "Concepts should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetRankedConceptsText() {
        let description = "Get the ranked concepts of some text"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testText", withExtension: "txt")
        
        alchemyLanguage.getRankedConcepts(fromTextFile: url!, failure: failWithError) { concepts in
            XCTAssertNotNil(concepts, "Response should not be nil")
            XCTAssertNotNil(concepts.concepts, "Concepts should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetRankedNamedEntitiesURL() {
        let description = "Get the entities of an Ars article"
        let expectation = self.expectation(description: description)
        
        alchemyLanguage.getRankedNamedEntities(fromContentAtURL: testUrl, failure: failWithError) { entities in
            XCTAssertNotNil(entities, "Response should not be nil")
            XCTAssertNotNil(entities.entitites, "Entities should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRankedNamedEntitiesHtml() {
        let description = "Get the ranked concepts of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getRankedNamedEntities(fromHTMLFile: url!, withURL: nil, failure: failWithError) { entities in
            XCTAssertNotNil(entities, "Response should not be nil")
            XCTAssertNotNil(entities.entitites, "Entities should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetRankedNamedEntitiesText() {
        let description = "Get the ranked concepts of some text"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testText", withExtension: "txt")
        
        alchemyLanguage.getRankedNamedEntities(fromTextFile: url!, failure: failWithError) { entities in
            XCTAssertNotNil(entities, "Response should not be nil")
            XCTAssertNotNil(entities.entitites, "Entities should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetRankedKeywordsURL() {
        let description = "Get the keywords of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getRankedKeywords(fromContentAtURL: testUrl, failure: failWithError) { keywords in
            XCTAssertNotNil(keywords, "Response should not be nil")
            XCTAssertNotNil(keywords.keywords, "Keywords should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRankedKeywordsHtml() {
        let description = "Get the keywords of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")

        alchemyLanguage.getRankedKeywords(fromHTMLFile: url!, failure: failWithError) { keywords in
            XCTAssertNotNil(keywords, "Response should not be nil")
            XCTAssertNotNil(keywords.keywords, "Keywords should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRankedKeywordsText() {
        let description = "Get the keywords of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testText", withExtension: "txt")
        
        alchemyLanguage.getRankedKeywords(fromTextFile: url!, failure: failWithError) { keywords in
            XCTAssertNotNil(keywords, "Response should not be nil")
            XCTAssertNotNil(keywords.keywords, "Keywords should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetLanguageURL() {
        let description = "Get the language of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getLanguage(fromContentAtURL: testUrl, failure: failWithError) { language in
            XCTAssertNotNil(language, "Response should not be nil")
            XCTAssertNotNil(language.language, "Language should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetLanguageText() {
        let description = "Get the language of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testText", withExtension: "txt")
        
        alchemyLanguage.getLanguage(fromTextFile: url!, failure: failWithError) { language in
            XCTAssertNotNil(language, "Response should not be nil")
            XCTAssertNotNil(language.language, "Language should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetMicroformatsURL() {
        let description = "Get the microformats of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getMicroformatData(fromContentAtURL: testUrl, failure: failWithError) { microformats in
            XCTAssertNotNil(microformats, "Response should not be nil")
            XCTAssertNotNil(microformats.microformats, "Microformats should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetMicroformatsHtml() {
        let description = "Get the microformats of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getMicroformatData(fromHTMLFile: url!, failure: failWithError) { microformats in
            XCTAssertNotNil(microformats, "Response should not be nil")
            XCTAssertNotNil(microformats.microformats, "Microformats should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetPubDateURL() {
        let description = "Get the publication date of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getPubDate(fromContentAtURL: testUrl, failure: failWithError) { pubDate in
            XCTAssertNotNil(pubDate, "Response should not be nil")
            XCTAssertNotNil(pubDate.publicationDate, "Publication date should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetPubDateHtml() {
        let description = "Get the publication date of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getPubDate(fromHTMLFile: url!, failure: failWithError) { pubDate in
            XCTAssertNotNil(pubDate, "Response should not be nil")
            XCTAssertNotNil(pubDate.publicationDate, "Publication date should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRelationsURL() {
        let description = "Get the Subject-Action-Object relations of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getRelations(fromContentAtURL: testUrl, failure: failWithError) { relations in
            XCTAssertNotNil(relations, "Response should not be nil")
            XCTAssertNotNil(relations.relations, "Relations should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRelationsHtml() {
        let description = "Get the Subject-Action-Object relations of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getRelations(fromHTMLFile: url!, failure: failWithError) { relations in
            XCTAssertNotNil(relations, "Response should not be nil")
            XCTAssertNotNil(relations.relations, "Relations should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRelationsText() {
        let description = "Get the Subject-Action-Object relations of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testText", withExtension: "txt")
        
        alchemyLanguage.getRelations(fromTextFile: url!, failure: failWithError) { relations in
            XCTAssertNotNil(relations, "Response should not be nil")
            XCTAssertNotNil(relations.relations, "Relations should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetTextSentimentURL() {
        let description = "Get the sentiment of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getTextSentiment(fromContentAtURL: testUrl, failure: failWithError) { sentiment in
            XCTAssertNotNil(sentiment, "Response should not be nil")
            XCTAssertNotNil(sentiment.docSentiment, "Sentiment should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetTextSentimentHtml() {
        let description = "Get the sentiment of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getTextSentiment(fromHTMLFile: url!, failure: failWithError) { sentiment in
            XCTAssertNotNil(sentiment, "Response should not be nil")
            XCTAssertNotNil(sentiment.docSentiment, "Entities should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetTextSentimentText() {
        let description = "Get the sentiment of some text"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testText", withExtension: "txt")
        
        alchemyLanguage.getTextSentiment(fromTextFile: url!, failure: failWithError) { sentiment in
            XCTAssertNotNil(sentiment, "Response should not be nil")
            XCTAssertNotNil(sentiment.docSentiment, "Entities should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetTargetedSentimentURL() {
        let description = "Get the sentiment of a phrase in an Ars article"
        let expectation = self.expectation(description: description)
        let phrase = "Developers who want to offer Instant Apps will have to modularize their apps"
        alchemyLanguage.getTargetedSentiment(fromContentAtURL: testUrl, withTargets: phrase, failure: failWithError) { sentiment in
            XCTAssertNotNil(sentiment, "Response should not be nil")
            XCTAssertNotNil(sentiment.docSentiment, "Sentiment should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetTargetedSentimentHtml() {
        let description = "Get the sentiment of a phrase in an Ars article"
        let expectation = self.expectation(description: description)
        
        let phrase = "the Yangshao people brewed a mixed beer with specialized tools and knowledge of temperature control"
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getTargetedSentiment(fromTextFile: url!, withTargets: phrase, failure: failWithError) { sentiment in
            XCTAssertNotNil(sentiment, "Response should not be nil")
            XCTAssertNotNil(sentiment.docSentiment, "Entities should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetTargetedSentimentText() {
        let description = "Get the sentiment of a phrase in some text"
        let expectation = self.expectation(description: description)
        
        let phrase = "Square Enix announced that the Romancing SaGa 2 remake was heading stateside in April"
        let url = Bundle(for: type(of: self)).url(forResource: "testText", withExtension: "txt")
        
        alchemyLanguage.getTargetedSentiment(fromTextFile: url!, withTargets: phrase, failure: failWithError) { sentiment in
            XCTAssertNotNil(sentiment, "Response should not be nil")
            XCTAssertNotNil(sentiment.docSentiment, "Entities should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetRankedTaxonomyURL() {
        let description = "Get the taxonomies of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getRankedTaxonomy(fromContentAtURL: testUrl, failure: failWithError) { taxonomies in
            XCTAssertNotNil(taxonomies, "Response should not be nil")
            XCTAssertNotNil(taxonomies.taxonomy, "Taxonomies should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRankedTaxonomyHtml() {
        let description = "Get the taxonomy of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getRankedTaxonomy(fromHTMLFile: url!, failure: failWithError) { taxonomies in
            XCTAssertNotNil(taxonomies, "Response should not be nil")
            XCTAssertNotNil(taxonomies.taxonomy, "Taxonomies should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetRankedTaxonomyText() {
        let description = "Get the taxonomy of some text"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testText", withExtension: "txt")
        
        alchemyLanguage.getRankedTaxonomy(fromTextFile: url!, failure: failWithError) { taxonomies in
            XCTAssertNotNil(taxonomies, "Response should not be nil")
            XCTAssertNotNil(taxonomies.taxonomy, "Taxonomies should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetRawTextURL() {
        let description = "Get the raw text of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getRawText(fromContentAtURL: testUrl, failure: failWithError) { rawText in
            XCTAssertNotNil(rawText, "Response should not be nil")
            XCTAssertNotNil(rawText.text, "Response should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRawTextHtml() {
        let description = "Get the raw text of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getRawText(fromHTMLFile: url!, failure: failWithError) { text in
            XCTAssertNotNil(text, "Response should not be nil")
            XCTAssertNotNil(text.text, "Text should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetTextURL() {
        let description = "Get the text of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getText(fromContentAtURL: testUrl, failure: failWithError) { text in
            XCTAssertNotNil(text, "Response should not be nil")
            XCTAssertNotNil(text.text, "Text should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetTextHtml() {
        let description = "Get the raw text of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getText(fromHTMLFile: url!, failure: failWithError) { text in
            XCTAssertNotNil(text, "Response should not be nil")
            XCTAssertNotNil(text.text, "Text should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testGetTitleURL() {
        let description = "Get the title of an Ars article"
        let expectation = self.expectation(description: description)
        alchemyLanguage.getTitle(fromContentAtURL: testUrl, failure: failWithError) { title in
            XCTAssertNotNil(title, "Response should not be nil")
            XCTAssertNotNil(title.title, "Title should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetTitleHtml() {
        let description = "Get the title of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getTitle(fromHTMLFile: url!, failure: failWithError) { title in
            XCTAssertNotNil(title, "Response should not be nil")
            XCTAssertNotNil(title.title, "Title should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
    }
    
    func testDetectFeedsURL() {
        let description = "Get the feeds of an Ars article"
        let expectation = self.expectation(description: description)
        
        alchemyLanguage.getFeedLinks(fromContentAtURL: testUrl, failure: failWithError) { feeds in
            XCTAssertNotNil(feeds, "Response should not be nil")
            XCTAssertNotNil(feeds.feeds, "Feeds should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testDetectFeedsHtml() {
        let description = "Get the feeds of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getFeedLinks(fromHTMLFile: url!, failure: failWithError) { feeds in
            XCTAssertNotNil(feeds, "Response should not be nil")
            XCTAssertNotNil(feeds.feeds, "Feeds should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetEmotionURL() {
        let description = "Get the emotion of an Ars article"
        let expectation = self.expectation(description: description)
    
        alchemyLanguage.getEmotion(fromContentAtURL: testUrl, failure: failWithError) { emotion in
            XCTAssertNotNil(emotion, "Response should not be nil")
            XCTAssertNotNil(emotion.docEmotions, "Feeds should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetEmotionHtml() {
        let description = "Get the feeds of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testArticle", withExtension: "html")
        
        alchemyLanguage.getEmotion(fromHTMLFile: url!, failure: failWithError) { emotion in
            XCTAssertNotNil(emotion, "Response should not be nil")
            XCTAssertNotNil(emotion.docEmotions, "Feeds should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetEmotionText() {
        let description = "Get the feeds of an Ars article"
        let expectation = self.expectation(description: description)
        
        let url = Bundle(for: type(of: self)).url(forResource: "testText", withExtension: "txt")
        
        alchemyLanguage.getEmotion(fromTextFile: url!, failure: failWithError) { emotion in
            XCTAssertNotNil(emotion, "Response should not be nil")
            XCTAssertNotNil(emotion.docEmotions, "Feeds should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    // Negative Unit Tests
    
    func testInvalidURL() {
        let description = "Use an invalid URL"
        let expectation = self.expectation(description: description)
        
        let failure = { (error: Error) in
            expectation.fulfill()
        }
        
        alchemyLanguage.getFeedLinks(fromContentAtURL: "DOGS", failure: failure, success: failWithResult)
        waitForExpectations()
    }
    
}
