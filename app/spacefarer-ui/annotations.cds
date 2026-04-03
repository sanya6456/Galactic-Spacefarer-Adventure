using { SpacefarerService } from '../../srv/spacefarer.service';

annotate SpacefarerService.Spacefarers with {
    name               @title: 'Name';
    originPlanet       @title: 'Origin Planet';
    stardustCollection @title: 'Stardust Collection';
    wormholeSkill      @title: 'Wormhole Skill (1–10)';
    spacesuitColor     @title: 'Spacesuit Colour';
    department         @title: 'Department'
                       @Common.Text: department.name
                       @Common.TextArrangement: #TextOnly
                       @Common.ValueList: {
                           $Type         : 'Common.ValueListType',
                           CollectionPath: 'Departments',
                           SearchSupported: false,
                           Parameters: [
                               { $Type: 'Common.ValueListParameterOut',         LocalDataProperty: department_ID, ValueListProperty: 'ID' },
                               { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' }
                           ]
                       };
    position           @title: 'Position'
                       @Common.Text: position.title
                       @Common.TextArrangement: #TextOnly
                       @Common.ValueList: {
                           $Type         : 'Common.ValueListType',
                           CollectionPath: 'Positions',
                           SearchSupported: false,
                           Parameters: [
                               { $Type: 'Common.ValueListParameterOut',         LocalDataProperty: position_ID, ValueListProperty: 'ID' },
                               { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'title' }
                           ]
                       };
}

annotate SpacefarerService.Spacefarers with @(
    Capabilities.InsertRestrictions: { Insertable: true },
    Capabilities.UpdateRestrictions: { Updatable: true },
    Capabilities.DeleteRestrictions: { Deletable: true },

    UI.HeaderInfo: {
        TypeName      : 'Spacefarer',
        TypeNamePlural: 'Spacefarers',
        Title         : { Value: name },
        Description   : { Value: originPlanet }
    },

    UI.SelectionFields: [ name, originPlanet, spacesuitColor ],

    UI.LineItem: [
        { $Type: 'UI.DataField', Value: name },
        { $Type: 'UI.DataField', Value: originPlanet },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#Stardust',
            Label : 'Stardust'
        },
        { $Type: 'UI.DataField', Value: wormholeSkill },
        { $Type: 'UI.DataField', Value: spacesuitColor }
    ],

    UI.DataPoint #Stardust: {
        Value        : stardustCollection,
        Title        : 'Stardust Collection',
        Visualization: #Progress,
        TargetValue  : 1000
    },

    UI.DataPoint #WormholeSkill: {
        Value        : wormholeSkill,
        Title        : 'Wormhole Navigation Skill',
        Visualization: #Rating,
        TargetValue  : 10
    },

    UI.HeaderFacets: [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.DataPoint#Stardust',
            Label : 'Stardust Collection'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.DataPoint#WormholeSkill',
            Label : 'Wormhole Skill'
        }
    ],

    UI.Facets: [
        {
            $Type : 'UI.CollectionFacet',
            ID    : 'CosmicProfile',
            Label : 'Cosmic Profile',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#CosmicDetails',
                Label : 'Cosmic Details'
            }]
        },
        {
            $Type : 'UI.CollectionFacet',
            ID    : 'GalacticAssignment',
            Label : 'Galactic Assignment',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#Assignment',
                Label : 'Department & Position'
            }]
        }
    ],

    UI.FieldGroup #CosmicDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            { $Type: 'UI.DataField', Value: name },
            { $Type: 'UI.DataField', Value: originPlanet },
            { $Type: 'UI.DataField', Value: stardustCollection },
            { $Type: 'UI.DataField', Value: wormholeSkill },
            { $Type: 'UI.DataField', Value: spacesuitColor }
        ]
    },

    UI.FieldGroup #Assignment: {
        $Type: 'UI.FieldGroupType',
        Data : [
            { $Type: 'UI.DataField', Value: department_ID, Label: 'Department' },
            { $Type: 'UI.DataField', Value: position_ID,   Label: 'Position'   }
        ]
    }
);
