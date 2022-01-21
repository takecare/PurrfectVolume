class Volimiter {
  constructor(appName, onlyOnHeadphones) {
    this.app = Application.currentApplication();
    this.app.includeStandardAdditions = true;
    this.appName = appName;
    this.maxVolume = 50;
    this.onlyOnHeadphones = onlyOnHeadphones;
    this.headPhonesConnected = !this.onSpeaker();
    this.previousVolume = null;
  }

  get currentVolume() {
    const { outputVolume } = this.app.getVolumeSettings();
    return outputVolume;
  }

  get outputTypeText() {
    return this.onlyOnHeadphones ? "🎧 headphones" : "🔊 global";
  }

  get volumeLimitText() {
    return `Limiting your ${this.outputTypeText} to ${this.maxVolume}% to protect your ears`;
  }

  get shouldLimitVolume() {
    return (
      this.onlyOnHeadphones &&
      this.headPhonesConnected &&
      this.currentVolume > this.maxVolume
    );
  }

  onSpeaker() {
    const audio = this.app.doShellScript("system_profiler SPAudioDataType");
    return /Default Output Device: Yes(?:(?!Output Source: )[\s\S])*Output Source: Internal Speakers(?:.*)$/gm.test(
      audio
    );
  }

  checkHeadPhones() {
  	if (!this.onlyOnHeadphones) {
			return;
		}

  	const areHeadphonesConnected = !this.onSpeaker();
    const wereHeadphonesConnected = this.headPhonesConnected;

    if (areHeadphonesConnected === wereHeadphonesConnected) {
			return;
		}

		if (areHeadphonesConnected) {
      this.headPhonesConnected = true;
      this.limitVolume();
      this.app.displayNotification("", {
        withTitle: "🎧 Headphones connected",
        subtitle: this.volumeLimitText,
      });
		} else {
      this.headPhonesConnected = false;
      this.app.displayNotification("", {
        withTitle: "🔇 Headphones disconnected",
        subtitle: "Stopping volume limit, be careful",
			});
    }
  }

  limitVolume() {
    if (this.shouldLimitVolume) {
      this.app.beep();
      this.app.setVolume(null, { outputVolume: this.maxVolume });
    }
  }

  startNotification() {
    this.app.displayNotification("", {
      withTitle: this.appName,
      subtitle: this.volumeLimitText,
			soundName: "Sonar"
    });
  }

	start() {
		var response = this.app.displayDialog("What's the maximum volume level (0-100)?", {
  	  defaultAnswer: "50",
    	buttons: ["OK"],
	    defaultButton: "OK"
		})
		this.maxVolume = response.textReturned
		this.startNotification()
	}
}

const PurrfectVolume = new Volimiter("Purrfect volume 😸", true);
PurrfectVolume.start();

function idle() {
  PurrfectVolume.checkHeadPhones();
  PurrfectVolume.limitVolume();
  return 0.05;
}
