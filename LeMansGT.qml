//Switch to 2.3 for Dash use... 6.2 is for preview in designer.
import QtQuick 2.3

//import Qt3D 1.0

//import QtGraphicalEffects 1.0
//import FileIO 1.0
//Window {
//   width: 800
//  height: 480
Item {


    /*#########################################################################
      #############################################################################
      Imported Values From GAWR inits
      #############################################################################
      #############################################################################
     */
    id: root
    property int myyposition: 0
    property int udp_message: rpmtest.udp_packetdata

    // onUdp_messageChanged: console.log(" UDP is "+udp_message)
    property bool udp_up: udp_message & 0x01
    property bool udp_down: udp_message & 0x02
    property bool udp_left: udp_message & 0x04
    property bool udp_right: udp_message & 0x08

    property int membank2_byte7: rpmtest.can203data[10]
    property int inputs: rpmtest.inputsdata

    //Inputs//31 max!!
    property bool ignition: inputs & 0x01
    property bool battery: inputs & 0x02
    property bool lapmarker: inputs & 0x04
    property bool rearfog: inputs & 0x08
    property bool mainbeam: inputs & 0x10
    property bool up_joystick: inputs & 0x20 || root.udp_up
    property bool leftindicator: inputs & 0x40
    property bool rightindicator: inputs & 0x80
    property bool brake: inputs & 0x100
    property bool oil: inputs & 0x200
    property bool seatbelt: inputs & 0x400
    property bool sidelight: inputs & 0x800
    property bool tripresetswitch: inputs & 0x1000
    property bool down_joystick: inputs & 0x2000 || root.udp_down
    property bool doorswitch: inputs & 0x4000
    property bool airbag: inputs & 0x8000
    property bool tc: inputs & 0x10000
    property bool abs: inputs & 0x20000
    property bool mil: inputs & 0x40000
    property bool shift1_id: inputs & 0x80000
    property bool shift2_id: inputs & 0x100000
    property bool shift3_id: inputs & 0x200000
    property bool service_id: inputs & 0x400000
    property bool race_id: inputs & 0x800000
    property bool sport_id: inputs & 0x1000000
    property bool cruise_id: inputs & 0x2000000
    property bool reverse: inputs & 0x4000000
    property bool handbrake: inputs & 0x8000000
    property bool tc_off: inputs & 0x10000000
    property bool left_joystick: inputs & 0x20000000 || root.udp_left
    property bool right_joystick: inputs & 0x40000000 || root.udp_right

    property int odometer: 0
    property int tripmeter: 0
    property real value: 0
    property real shiftvalue: 0

    property real rpm: 800
    property real rpmlimit: 8000 //Originally was 7k, switched to 8000 -t
    property real rpmdamping: 5
    //property real rpmscaling:0
    property real speed: 0
    property int speedunits: 2

    property real watertemp: 50
    property real waterhigh: 0
    property real waterlow: 0
    property real waterunits: 1

    property real fuel: 50
    property real fuelhigh: 0
    property real fuellow: 0
    property real fuelunits
    property real fueldamping

    property real o2: 0
    property real map: 0
    property real maf: 0

    property real oilpressure: 5
    property real oilpressurehigh: 0
    property real oilpressurelow: 0
    property real oilpressureunits: 0

    property real oiltemp: 100
    property real oiltemphigh: 90
    property real oiltemplow: 90
    property real oiltempunits: 1

    property real batteryvoltage: 0

    property int mph: (speed * 0.62)

    property int gearpos: rpmtest.geardata

    property real masterbrightness: 1
    property real colourbrightness: 0.5

    property string colorscheme: "green"
    property int red: 0
    property int green: 0
    property int blue: 0
    property string red_value: if (red < 16)
                                   "0" + red.toString(16)
                               else
                                   red.toString(16)
    property string green_value: if (green < 16)
                                     "0" + green.toString(16)
                                 else
                                     green.toString(16)
    property string blue_value: if (blue < 16)
                                    "0" + blue.toString(16)
                                else
                                    blue.toString(16)

    //  onColorschemeChanged: console.log("color scheme is "+colorscheme)
    //property real masterbrightness:fuel/100

    //  onRed_valueChanged: console.log("red_value hex "+red_value)
    // onGreen_valueChanged: console.log("green_value hex "+green_value)
    // onBlue_valueChanged: console.log("blue_value hex "+blue_value)
    width: 800
    height: 480
    clip: true
    z: 0

    property real speed_spring: 1
    property real speed_damping: 1

    property real rpm_needle_spring: 3.0 //if(rpm<1000)0.6 ;else 3.0
    property real rpm_needle_damping: 0.2 //if(rpm<1000).15; else 0.2

    property bool changing_page: rpmtest.changing_pagedata
    onChanging_pageChanged: if (changing_page) {
                                temp_slider_colour_overlay.visible = false
                                gauge_back4.visible = false
                                oilp_slider_colour_overlay.visible = false
                                gauge_back3.visible = false
                                fuel_slider_colour_overlay.visible = false
                                gauge_back.visible = false
                                oilt_slider_colour_overlay.visible = false
                                gauge_back2.visible = false
                            }

    Component.onCompleted: delay_on_timer.start()
    Timer {
        id: delay_on_timer //this delay on timer is to delay the visibility of certain items , this gives a nice effect and stops opacity fade in of the screen looking crap
        interval: 500
        onTriggered: {
            temp_slider_colour_overlay.visible = true
            gauge_back4.visible = true
            oilp_slider_colour_overlay.visible = true
            gauge_back3.visible = true
            fuel_slider_colour_overlay.visible = true
            gauge_back.visible = true
            oilt_slider_colour_overlay.visible = true
            gauge_back2.visible = true
        }
    }

    //Tristan Generated Code Here:
    property string white_color: "#FFFFFF"
    property string primary_color: "#FFFFFF" //#FFBF00 is amber
    property string sweetspot_color: "#FFA500" //#00F500 for amber main screens IMO
    property string warning_red: "#FF0000"
    property string engine_warmup_color: "#eb7500"
    x: 0
    y: 0

    FontLoader {
        id: helvetica_black_oblique
        source: "./HelveticaBlackOB.ttf"
    }

    /* ########################################################################## */
    Rectangle {
        id: black_background_rect
        y: 0
        width: 800
        height: 480
        color: "#000000"
        border.width: 0
        z: 0
    }
    Rectangle {
        id: rev_splitter
        y: 256
        x: 0
        z: 2
        width: 800
        height: 2
        color: root.primary_color
    }

    Text {
        id: rpm_display_val
        text: root.rpm + " rpm"
        font.pixelSize: 32
        horizontalAlignment: Text.AlignRight
        font.pointSize: 32
        font.family: helvetica_black_oblique.name
        x: 618
        y: 203
        z: 2
        width: 164
        color: if (root.rpm < 8000)
                   root.primary_color
               else
                   root.warning_red

        //Not working? Help?


        /*Behavior on color {
                SequentialAnimation {
                    ColorAnimation {
                        loops: Animation.Infinite
                        running: true
                        from: root.warning_red
                        to: "black"
                        duration: 10
                    }
                }
            }*/
    }

    Text {
        id: watertemp_display_val
        text: root.watertemp.toFixed(
                  0) + "°" // Alec added toFixed(0) to have no decimal places
        font.pixelSize: 32
        font.pointSize: 32
        font.family: helvetica_black_oblique.name
        width: 128
        height: 32
        x: 16
        y: 396
        z: 2
        color: if (root.watertemp < 95)
                   root.primary_color
               else
                   root.warning_red
    }

    Text {
        id: oiltemp_display_val
        font.pixelSize: 32
        font.pointSize: 32
        font.family: helvetica_black_oblique.name
        width: 128
        height: 32
        x: 16
        y: 338
        z: 2
        color: if (root.oiltemp < 110)
                   root.primary_color
               else
                   root.warning_red
        text: root.oiltemp.toFixed(0) // "100°"
    }

    Text {
        id: oilpressure_display_val
        text: root.oilpressure.toFixed(0) //Alec added toFixed(0)
        font.pixelSize: 32
        font.pointSize: 32
        font.family: helvetica_black_oblique.name
        width: 128
        height: 32
        x: 16
        y: 284
        z: 2
        color: root.primary_color
    }
    Rectangle {
        id: oilpressure_line
        x: 16
        y: 327
        width: 256
        height: 2
        color: root.primary_color
    }

    Text {
        id: speed_display_val
        font.pixelSize: 72
        horizontalAlignment: Text.AlignRight
        font.family: helvetica_black_oblique.name
        font.pointSize: 72
        x: 553
        y: 358
        width: 148
        color: root.primary_color
        text: root.mph.toFixed(0) //"0"   // Alec added speed
        z: 2
    }

    Rectangle {
        id: oiltemp_line
        x: 16
        y: 385
        width: 256
        height: 2
        color: root.primary_color
    }

    Text {
        id: odometer_display_val
        text: root.odometer + " mi"
        font.pixelSize: 24
        horizontalAlignment: Text.AlignRight
        font.pointSize: 16
        font.family: helvetica_black_oblique.name
        x: 618
        y: 440 //480 - 16 - 12
        z: 2
        width: 164
        color: root.primary_color
        //            Text {
        //                id: odometer_capt
        //                x: 130
        //                y: 0
        //                text: "MI"
        //                font.pixelSize: 16
        //                horizontalAlignment: Text.AlignRight
        //                font.pointSize: 16
        //                font.family: ra_mono.name
        //                color: "#FFFFFF"
        //                z: 2
        //            }
    }

    Text {
        id: speed_label
        x: 707
        y: 396
        color: root.primary_color
        text: "mi/h"
        font.pixelSize: 32
        horizontalAlignment: Text.AlignRight
        z: 2
        font.family: helvetica_black_oblique.name
        font.pointSize: 32
    }

    // RPM Marks
    Row {
        id: rpmLights
        x: 43
        y: 16
        width: 700
        height: 128
        layoutDirection: Qt.LeftToRight
        layer.enabled: true
        smooth: false
        clip: false
        z: 2
        Repeater {
            property int index
            z: 2
            model: 100
            Row {
                Rectangle {
                    height: 128

                    //Control for how the bar is lit
                    opacity: if (Math.ceil(root.rpm / 100) > index + 1)
                                 .7
                             else if (Math.ceil(root.rpm / 100) == index + 1)
                                 1
                             else
                                 .15

                    width: 3

                    //Settings for how our RPM colors are set
                    color: if (index < 60)
                               root.primary_color
                    //Cam Changeover
                           else if (index >= 60 && index < 80)
                               root.sweetspot_color
                    //Redline
                           else
                               root.warning_red
                    radius: 1.5
                }
                Rectangle {
                    id: rpm_marker_spacer
                    height: 128
                    opacity: 1
                    width: 4
                    color: "#000000"
                    radius: 1
                    border.width: 0
                }
            }
        }
    }

    //Actual RPM marks
    Item {
        id: rev_system
        x: 25

        //Tic Marks
        Rectangle {
            id: ticmark_line
            width: 700
            height: 2
            x: 16
            y: 160
            z: 1
            color: root.primary_color
        }
        Rectangle {
            id: tickmark_redline
            x: 577
            width: 140
            height: 2
            color: root.warning_red
            y: 160
            z: 2
        }

        Row {
            id: mainTicks
            x: 14
            y: 160
            width: 710
            height: 16
            antialiasing: true
            z: 2
            Repeater {
                model: 11
                property int index
                Row {
                    id: indie_tickrow
                    width: 70
                    Rectangle {
                        width: 6
                        height: 18
                        x: 0
                        y: -2
                        color: if (root.watertemp < 80) {
                                   if (index <= 4)
                                       root.engine_warmup_color
                                   else
                                       root.primary_color
                               } else
                                   root.primary_color
                        //                            color: if (index < 8)
                        //                                       root.primary_color
                        //                                   else
                        //                                       root.warning_red
                        border.color: "#000000"
                        border.width: 2
                    }
                }
            }
        }
        Row {
            id: subTicks
            x: 49
            y: 160
            width: 710
            height: 16
            antialiasing: true
            z: 2
            Repeater {
                model: 8
                property int index
                Row {
                    id: subTickRow
                    width: 70
                    Rectangle {
                        width: 6
                        height: 13
                        x: 0
                        y: -2
                        color: if (root.watertemp < 80) {
                                   if (index <= 3)
                                       root.engine_warmup_color
                                   else
                                       root.primary_color
                               } else
                                   root.primary_color
                        //                                   else
                        //                                       root.warning_red
                        border.color: "#000000"
                        border.width: 2
                    }
                }
            }
        }
        Rectangle {
            id: engine_warmup_line
            x: 18
            y: 160
            width: 280
            height: 2
            z: 4
            color: root.engine_warmup_color
            visible: root.watertemp < 80
        }

        //RPM Numbers
        Row {
            id: tickNumbers
            x: 14
            y: 180
            z: 2
            width: 700
            height: 16
            Repeater {
                model: 10
                property int index
                Text {
                    text: index
                    //                        color: if (index < 8)
                    //                                   root.primary_color
                    //                               else
                    //                                   root.warning_red
                    color: if (root.watertemp < 80) {
                               if (index <= 4)
                                   root.engine_warmup_color
                               else
                                   root.primary_color
                           } else
                               root.primary_color
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    //  rightPadding: 57
                    font.pointSize: 18
                    font.family: helvetica_black_oblique.name
                }
                Rectangle {
                    width: 57
                    height: 17
                    color: "#000000"
                }
            }
        }

        Text {
            id: numba_ten
            x: 705
            y: 180
            color: root.primary_color
            text: "10"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            font.family: helvetica_black_oblique.name
        }

        Text {
            id: watertemp_label
            x: 123
            y: 410
            color: if (root.watertemp < 95)
                       root.primary_color
                   else
                       root.warning_red
            text: "Water Temp °C"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            font.family: helvetica_black_oblique.name
        }

        Text {
            id: oiltemp_label
            x: 123
            y: 353
            color: if (root.watertemp < 110)
                       //110 is a good oil temp limit IMO
                       root.primary_color
                   else
                       root.warning_red
            text: "Oil Temp °C"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            font.family: helvetica_black_oblique.name
        }

        Text {
            id: oilpressure_label
            x: 123
            y: 298
            color: root.primary_color
            text: "Oil Pressure"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            font.family: helvetica_black_oblique.name
        }

        Text {
            id: fuel_label
            x: 304
            y: 440
            width: 128
            color: if (root.fuel > 30)
                       root.primary_color
                   else
                       root.warning_red
            text: if (root.fuel > 30)
                      root.fuel + " %"
                  else
                      "LOW FUEL!!"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            font.family: helvetica_black_oblique.name
        }
    }

    Item {
        id: fueling_system
        x: 336
        y: 402
        width: 128
        height: 32
        Row {
            id: gasgauge
            x: -8
            y: 0
            width: 128
            height: 32
            antialiasing: true
            z: 3
            Repeater {
                model: 10
                //  required
                property int index
                Row {
                    Rectangle {
                        width: 11
                        height: 32
                        color: if (Math.floor(root.fuel / 10) > index) {
                                   if (root.fuel > 30)
                                       root.primary_color
                                   else
                                       root.warning_red
                               } else
                                   "#0A0A0A"
                        radius: 2
                        border.width: if (Math.ceil(root.fuel / 10) >= index) {
                                          0
                                      } else
                                          1
                        border.color: root.primary_color
                        z: 1
                    }
                    Rectangle {
                        width: 2
                        height: 32
                        color: "#000000"
                        z: 1
                    }
                }
            }
        }
    }
    Item {
        id: icons
        Image {
            id: brights
            x: 371
            y: 293
            height: 32
            width: 50
            source: "./img/brights.png"
            visible: root.mainbeam
        }
        Image {
            id: left_blinker
            x: 338
            y: 295
            source: "./img/left_blinker.png"
            visible: root.leftindicator
        }
        Image {
            id: right_blinker
            x: 427
            y: 295
            source: "./img/right_blinker.png"
            visible: root.rightindicator
        }
        Image {
            id: battery_image
            x: 731
            y: 293
            width: 47
            height: 32
            source: "./img/battery.png"
            //autoTransform: false
            visible: root.battery
        }
        Image {
            id: cel_image
            x: 671
            y: 293
            width: 52
            source: "./img/cel.png"
            antialiasing: true
            height: 32
            visible: root.mil
        }

        Image {
            id: ebrake_image
            x: 569
            y: 295
            width: 96
            height: 32
            source: "./img/e-brake.png"
            visible: root.handbrake
        }
        Image {
            id: tcs_image
            x: 531
            y: 295
            width: 43
            height: 32
            source: "./img/tcs.png"
            visible: root.tc
        }
        Image {
            id: oil_pressure_lamp
            x: 467
            source: "./img/oil_light.png"
            y: 298
            width: 61
            height: 23
            visible: root.oil
        }

        Image {
            id: abs_image
            x: 326
            y: 347
            source: "./img/abs.png"
            visible: root.abs
        }
        Image {
            x: 384
            y: 349
            source: "./img/seatbelt.png"
            visible: root.seatbelt
        }
        Image {
            x: 424
            y: 349
            source: "./img/doorajar.png"
            visible: root.doorswitch
        }
        Image {
            x: 464
            y: 401
            source: "./img/fuel_icon_white.png"
        }
    }
} //End Init Item//} //End Window
