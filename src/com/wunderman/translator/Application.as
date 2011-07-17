package com.wunderman.translator {
	import flash.events.FocusEvent;
	import com.wunderman.translator.controls.GenericButton;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;

	/**
	 * @author StocktonK
	 */
	public class Application extends MovieClip {
		
		private var myXML:XML;
		private var myLoader:URLLoader = new URLLoader();
		private var contentArray : Array;
		
		private var englishInput : TextField;
		private var cockneyInput : TextField;
		private var cockneyFormat : TextFormat;
		
		private var submitButton : GenericButton;
		private var cockneyRandomiserButton : GenericButton;
		
		private var cockneyFont : Font;
		
		private var errorMessage : MovieClip;
		
		private const englishStarterText : String = "Just type your English word in the first box and hit submit to get the Cockney Rhyming Slang translation opposite.";
		private const cockneyStarterText : String = "Alternatively if you want the English translation of some Cockney Rhyming Slang do the opposite.";
		
		private const shortWarning : String = "You are going to need to give me more than that to go on than that me old China.";
		
		public function Application()
		{
			init();
		}
		
		
		private function init():void
		{
			myLoader.load(new URLRequest("Translator.xml"));
			myLoader.addEventListener(Event.COMPLETE, processXML);
			// add an event listener for the return key which 
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			cockneyFont = new CockneyFont();
			var cls : Class;
			errorMessage = new MovieClip();
			cls = getDefinitionByName("errorMessage") as Class;
			errorMessage = new cls() as MovieClip;
			errorMessage.x = 950/2 - (errorMessage.width/2)+10;
			errorMessage.y = 245;
			errorMessage.closeBtn.addEventListener(MouseEvent.CLICK, closeError);
			errorMessage.visible = false;
			this.addChild(errorMessage);	

			addButtonListeners();
		}
		
		private function processXML(e:Event):void {
			myXML = new XML(e.target.data);
			contentArray = new Array();
		//	var langObj:Object = new Object();
		
			for each(var entry:XML in myXML.children())
			{	
				var langObj:Object = new Object();
				langObj.english = entry.english.toString();
				langObj.cockney = entry.cockney.toString();
			//	trace("langObj :: "+langObj.english);
			//	trace(langObj.cockney);
				contentArray.push(langObj);
			}			
			createInputFields();
		}
		
		private function addButtonListeners():void
		{
			submitButton = this.submitBtn;
			cockneyRandomiserButton = this.randomBtn;
			submitButton.addEventListener(MouseEvent.CLICK, translateText);
			cockneyRandomiserButton.addEventListener(MouseEvent.CLICK, randomiseCockney);
		}
		
		function keyDownHandler(e : KeyboardEvent) : void
		{
		    if (e.keyCode == Keyboard.ENTER)
		    {
		        translateText(e);
		    }
		}
		
		private function createInputFields() : void
		{  
            cockneyFormat = new TextFormat();
			cockneyFormat.size = 20;
			cockneyFormat.color = "#441503";
            cockneyFormat.font = cockneyFont.fontName;
			
			englishInput = createTextField(30, 40, 185, 350, this.englishBubble);
            englishInput.text = englishStarterText;
            englishInput.wordWrap = true;
            englishInput.type = TextFieldType.INPUT;
            englishInput.embedFonts = true;
    		englishInput.defaultTextFormat = cockneyFormat;
			englishInput.setTextFormat(cockneyFormat);
            englishInput.addEventListener(MouseEvent.CLICK, captureText);
             

            cockneyInput = createTextField(80, 40, 178, 350, this.cockneyBubble);
            cockneyInput.text = cockneyStarterText;
            cockneyInput.wordWrap = true;
            cockneyInput.type = TextFieldType.INPUT;
            cockneyInput.embedFonts = true;
            cockneyInput.defaultTextFormat = cockneyFormat;
            cockneyInput.setTextFormat(cockneyFormat);
            
            cockneyInput.addEventListener(MouseEvent.CLICK, captureText);
            
            englishInput.addEventListener(FocusEvent.FOCUS_IN,	captureText);
            cockneyInput.addEventListener(FocusEvent.FOCUS_IN,	captureText);
		}
		
		private function captureText(e:Event):void
		{
			// remove all content - you ain't going to need that where you are going.
			englishInput.text = "";
			cockneyInput.text = "";
		}

        private function createTextField(x:Number, y:Number, width:Number, height:Number, p: MovieClip):TextField {
            var result:TextField = new TextField();
            result.x = x; result.y = y;
            result.width = width; result.height = height;
            
           	p.addChild(result);
            return result;
        }
						
		private function translateText(e:Event):void
		{
			var matchingText : Boolean = false;
			var checkArray : Array = new Array();
			var lengthCheck : String 
			if (englishInput.text != "")
			{
				lengthCheck  = englishInput.text.toLocaleLowerCase();
				// translating english to cockney
				if(lengthCheck == "of" || lengthCheck == "and" || lengthCheck == "or" || lengthCheck == "the" || lengthCheck == "if" )
				{
					cockneyInput.text = cockneyStarterText;
					englishInput.text = shortWarning;
					stage.focus = null;
					return;			
				}
				for (var i:int = 0; i<contentArray.length; i++)
				{
					var checkEnglish : String =(contentArray[i].english).toLowerCase();	
					// at the moment this is only searching exact phrase - will need to put a break down on thsi to parial phrase
					if (checkEnglish == englishInput.text.toLowerCase())
					{
						matchingText = true;
						displayResult(i);
						return;
					}
					// now split that value so can iterate through its parts
					else
					{
						checkArray = checkEnglish.split(" ");
						if (checkArray.length>1)
						{
							for (var ii :int = 0; ii<checkArray.length; ii++)
							{
								if (checkArray[ii] == englishInput.text.toLowerCase())
								{
									matchingText = true;
									displayResult(i);
									return;
								}
							}
						}
					}
				}
			}
			else 
			{
				lengthCheck  = cockneyInput.text.toLocaleLowerCase();
				// translating english to cockney
				if(lengthCheck == "of" || lengthCheck == "and" || lengthCheck == "or" || lengthCheck == "the" || lengthCheck == "if" )
				{
					englishInput.text = englishStarterText;
					cockneyInput.text = shortWarning;
					stage.focus = null;
					return;			
				}
				for (var j:int = 0; j<contentArray.length; j++)
				{
					var checkCockney : String =(contentArray[j].cockney).toLowerCase(); 
					// at the moment this is only searching exact phrase - will need to put a break down on thsi to parial phrase
					if (checkCockney == cockneyInput.text.toLowerCase())
					{
						matchingText = true;
						displayResult(j);
						return;
					}
					else
					{
						checkArray = checkCockney.split(" ");
						if (checkArray.length>1)
						{
							for (var jj :int = 0; jj<checkArray.length; jj++)
							{
								if (checkArray[jj] == cockneyInput.text.toLowerCase())
								{
									matchingText = true;
									displayResult(j);
									return;
								}
							}
						}
					}	
				}
			}
			if (!matchingText)
			{
				this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				captureText(new Event(MouseEvent.CLICK));
				errorMessage.visible = true;
				stage.focus = null;		
			}
		}
		
		private function displayResult(num:int):void
		{
			englishInput.text = contentArray[num].english;
			cockneyInput.text = contentArray[num].cockney;
			stage.focus = null;
		
		}
		
		private function closeError(e:MouseEvent):void
		{
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			errorMessage.visible = false;
			englishInput.text = englishStarterText;
			
			cockneyInput.text = cockneyStarterText;	
			
			stage.focus = null;
				
		}

		private function randomiseCockney(e:MouseEvent):void
		{
			var randomNumber : int = Math.floor(Math.random()*contentArray.length);
			englishInput.text = contentArray[randomNumber].english;
			cockneyInput.text = contentArray[randomNumber].cockney;
		}
		
	}
}
