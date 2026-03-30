using { SpacefarerService } from '../../srv/spacefarer.service';

annotate SpacefarerService.Spacefarers with @(
    UI.LineItem: [
        { Value: name, Label: 'Name' },
        { Value: originPlanet, Label: 'Planet' },
        { Value: stardustCollection, Label: 'Stardust' },
        { Value: spacesuitColor, Label: 'Suit Color' }
    ],
    UI.SelectionFields: [
        name,
        originPlanet,
        spacesuitColor
    ],
    UI.HeaderInfo: {
        TypeName: 'Spacefarer',
        TypeNamePlural: 'Spacefarers',
        Title: { Value: name },
        Description: { Value: originPlanet }
    }
)
