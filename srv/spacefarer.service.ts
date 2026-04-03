import cds from "@sap/cds";
import nodemailer from "nodemailer";

interface SpacefarerData {
  ID?: string;
  name?: string;
  originPlanet?: string;
  stardustCollection?: number;
  wormholeSkill?: number;
  spacesuitColor?: string;
}

async function sendCosmicNotification(sf: SpacefarerData): Promise<void> {
  const testAccount = await nodemailer.createTestAccount();

  const transporter = nodemailer.createTransport({
    host: "smtp.ethereal.email",
    port: 587,
    auth: {
      user: testAccount.user,
      pass: testAccount.pass,
    },
  });

  const info = await transporter.sendMail({
    from: '"Galactic Control Center" <control-center@galactic.sap>',
    to: `${sf.name ?? "spacefarer"}@galaxy.sap`,
    subject: "🚀 Welcome Aboard the Galactic Adventure!",
    text: `
Dear ${sf.name ?? "Spacefarer"},

Congratulations! You have been enrolled in the Galactic Spacefarer Adventure
from ${sf.originPlanet ?? "parts unknown"}.

  ✦ Stardust Collected  : ${sf.stardustCollection} units
  ✦ Wormhole Skill      : ${sf.wormholeSkill}/10
  ✦ Spacesuit Colour    : ${sf.spacesuitColor}

May your journey through the SAP-verse be stellar!
— The Galactic Control Center
    `.trim(),
  });

  console.log(`[cosmic-mail] Message sent: ${info.messageId}`);
  console.log(
    `[cosmic-mail] Preview URL : ${nodemailer.getTestMessageUrl(info)}`,
  );
}

export default class SpacefarerService extends cds.ApplicationService {
  async init(): Promise<void> {
    this.before("CREATE", "Spacefarers", (req: cds.Request) => {
      const data = req.data as SpacefarerData;

      if (data.stardustCollection == null) {
        data.stardustCollection = 100;
      } else if (data.stardustCollection < 0) {
        req.error(
          400,
          "Stardust collection cannot be negative, space traveller!",
        );
        return;
      }

      if (data.wormholeSkill == null) {
        data.wormholeSkill = 5;
      } else if (data.wormholeSkill < 1 || data.wormholeSkill > 10) {
        req.error(400, "Wormhole navigation skill must be between 1 and 10!");
        return;
      }
    });

    this.after(
      "CREATE",
      "Spacefarers",
      async (result: SpacefarerData | SpacefarerData[]) => {
        const sf = Array.isArray(result) ? result[0] : result;
        await sendCosmicNotification(sf);
      },
    );

    return super.init();
  }
}
