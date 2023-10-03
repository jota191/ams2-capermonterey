<?xml version="1.0" encoding="utf-8"?>
<CAR Name="Stockcar_90_cockpit" ExporterVersion="Blimey Tools v1.219">
    <NODE type="HIERARCHY" Name="Root" MatrixNumber="0" matrices="23" subobjects="22">
        <SPHERE Centre="0.040102 0.368832 -0.152451 1.000000" Radius="2.967690" />
        <MATRIX id="0" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" />
        <MATRIX id="1" Offset="0.439256 0.791678 -0.076336" Orientation="-0.190809 0.000000 0.000000 0.981627" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_STEERINGWHEEL_CPIT" MatrixNumber="1" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_STEERINGWHEEL_CPIT.meb" />
            <SPHERE Centre="0.000000 0.000212 -0.048873 1.000000" Radius="0.217457" />
        </NODE>
        <MATRIX id="2" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_INTERIOR_CPIT" MatrixNumber="2" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_INTERIOR_CPIT.meb" />
            <SPHERE Centre="0.039765 0.725206 0.127421 1.000000" Radius="1.325227" />
        </NODE>
        <MATRIX id="3" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_GAUGE_GLASS_CPIT" MatrixNumber="3" instances="1" userflags="288">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_GAUGE_GLASS_CPIT.meb" />
            <SPHERE Centre="0.337141 0.800745 -0.452541 1.000000" Radius="0.255610" />
        </NODE>
        <MATRIX id="4" Offset="0.437691 0.798448 -0.459411" Orientation="-0.150198 0.062214 0.377592 0.911589" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_NEEDLE_TACH_CPIT" MatrixNumber="4" instances="1" userflags="288">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_NEEDLE_TACH_CPIT.meb" />
            <SPHERE Centre="0.000001 -0.019850 -0.001482 1.000000" Radius="0.033030" />
        </NODE>
        <MATRIX id="5" Offset="0.072507 0.356715 -0.287647" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_GEARSHIFT_CPIT" MatrixNumber="5" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_GEARSHIFT_CPIT.meb" />
            <SPHERE Centre="0.020262 0.219961 0.109818 1.000000" Radius="0.162580" />
        </NODE>
        <MATRIX id="6" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_SHIFTGAITER_CPIT" MatrixNumber="6" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_SHIFTGAITER_CPIT.meb" />
            <SPHERE Centre="0.075482 0.401773 -0.270083 1.000000" Radius="0.113572" />
        </NODE>
        <MATRIX id="7" Offset="0.559390 0.798621 -0.459521" Orientation="-0.144854 0.073807 0.447951 0.879153" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_NEEDLE_WATER_CPIT" MatrixNumber="7" instances="1" userflags="288">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_NEEDLE_WATER_CPIT.meb" />
            <SPHERE Centre="-0.000056 -0.008980 -0.001663 1.000000" Radius="0.018829" />
        </NODE>
        <MATRIX id="8" Offset="0.315390 0.798621 -0.459521" Orientation="-0.144854 0.073807 0.447951 0.879153" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_NEEDLE_OILT_CPIT" MatrixNumber="8" instances="1" userflags="288">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_NEEDLE_OILT_CPIT.meb" />
            <SPHERE Centre="-0.000056 -0.008980 -0.001663 1.000000" Radius="0.018829" />
        </NODE>
        <MATRIX id="9" Offset="0.115000 0.798621 -0.459521" Orientation="-0.150198 0.062214 0.377592 0.911589" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_NEEDLE_OILP_CPIT" MatrixNumber="9" instances="1" userflags="288">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_NEEDLE_OILP_CPIT.meb" />
            <SPHERE Centre="-0.000056 -0.008980 -0.001663 1.000000" Radius="0.018829" />
        </NODE>
        <MATRIX id="10" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="DAMAGE" Name="STOCK90_ROLLCAGE_CPIT" MatrixNumber="10" subobjects="2">
            <SPHERE Centre="0.000000 0.745218 0.238885 1.000000" Radius="2.173444" />
            <NODE type="OBJECT" Name="STOCK90_ROLLCAGE_CPIT" MatrixNumber="10" instances="1" userflags="304">
                <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_ROLLCAGE_CPIT.meb" />
                <SPHERE Centre="0.000000 0.745218 0.238885 1.000000" Radius="2.173444" />
            </NODE>
            <NODE type="OBJECT" Name="STOCK90_ROLLCAGE_CPIT_dmg" MatrixNumber="10" instances="1" userflags="304">
                <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_ROLLCAGE_CPIT_dmg.meb" />
                <SPHERE Centre="0.000000 0.745218 0.238885 1.000000" Radius="2.173444" />
            </NODE>
        </NODE>
        <MATRIX id="11" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_INTERIOR_2_CPIT" MatrixNumber="11" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_INTERIOR_2_CPIT.meb" />
            <SPHERE Centre="0.066976 0.698353 -0.128210 1.000000" Radius="1.033539" />
        </NODE>
        <MATRIX id="12" Offset="-0.802000 0.355000 -1.397000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_TIRE_RF_CPIT" MatrixNumber="12" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_TIRE_RF_CPIT.meb" />
            <SPHERE Centre="0.001000 0.172078 0.001456 1.000000" Radius="0.403433" />
        </NODE>
        <MATRIX id="13" Offset="0.802000 0.355000 -1.397000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_TIRE_LF_CPIT" MatrixNumber="13" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_TIRE_LF_CPIT.meb" />
            <SPHERE Centre="0.001000 0.172078 0.001456 1.000000" Radius="0.403433" />
        </NODE>
        <MATRIX id="14" Offset="0.802000 0.355000 -1.397000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_WHEEL_LF_CPIT" MatrixNumber="14" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_WHEEL_LF_CPIT.meb" />
            <SPHERE Centre="0.001050 0.000000 0.000000 1.000000" Radius="0.247344" />
        </NODE>
        <MATRIX id="15" Offset="-0.802000 0.355000 -1.397000" Orientation="0.000000 1.000000 0.000000 -0.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_WHEEL_RF_CPIT" MatrixNumber="15" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_WHEEL_RF_CPIT.meb" />
            <SPHERE Centre="0.001050 0.000000 0.000000 1.000000" Radius="0.247344" />
        </NODE>
        <MATRIX id="16" Offset="0.802000 0.355000 -1.397001" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_DISC_LF_CPIT" MatrixNumber="16" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_DISC_LF_CPIT.meb" />
            <SPHERE Centre="-0.077478 0.000000 0.000000 1.000000" Radius="0.155179" />
        </NODE>
        <MATRIX id="17" Offset="-0.802000 0.355000 -1.397001" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_DISC_RF_CPIT" MatrixNumber="17" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_DISC_RF_CPIT.meb" />
            <SPHERE Centre="0.077478 0.000000 0.000000 1.000000" Radius="0.155179" />
        </NODE>
        <MATRIX id="18" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_WINDOWS_CPIT" MatrixNumber="18" instances="1" userflags="288">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_WINDOWS_CPIT.meb" />
            <SPHERE Centre="0.000000 1.053090 -0.581344 1.000000" Radius="0.765726" />
        </NODE>
        <MATRIX id="19" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="DAMAGE" Name="STOCK90_BODY_CPIT" MatrixNumber="19" subobjects="2">
            <SPHERE Centre="0.000000 0.705433 0.106900 1.000000" Radius="2.540875" />
            <NODE type="OBJECT" Name="STOCK90_BODY_CPIT" MatrixNumber="19" instances="1" userflags="304">
                <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_BODY_CPIT.meb" />
                <SPHERE Centre="0.000000 0.705433 0.106900 1.000000" Radius="2.540875" />
            </NODE>
            <NODE type="OBJECT" Name="STOCK90_BODY_CPIT_dmg" MatrixNumber="19" instances="1" userflags="304">
                <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_BODY_CPIT_dmg.meb" />
                <SPHERE Centre="0.000000 0.705433 0.106900 1.000000" Radius="2.540875" />
            </NODE>
        </NODE>
        <MATRIX id="20" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="DAMAGE" Name="STOCK90_CHASSIS_CPIT" MatrixNumber="20" subobjects="2">
            <SPHERE Centre="0.000000 0.726293 -1.159686 1.000000" Radius="1.282237" />
            <NODE type="OBJECT" Name="STOCK90_CHASSIS_CPIT" MatrixNumber="20" instances="1" userflags="304">
                <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_CHASSIS_CPIT.meb" />
                <SPHERE Centre="0.000000 0.726293 -1.159686 1.000000" Radius="1.282237" />
            </NODE>
            <NODE type="OBJECT" Name="STOCK90_CHASSIS_CPIT_dmg" MatrixNumber="20" instances="1" userflags="304">
                <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_CHASSIS_CPIT_dmg.meb" />
                <SPHERE Centre="0.000000 0.726293 -1.159686 1.000000" Radius="1.282237" />
            </NODE>
        </NODE>
        <MATRIX id="21" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="DAMAGE" Name="STOCK90_BONNET_CPIT" MatrixNumber="21" subobjects="2">
            <SPHERE Centre="0.000000 0.757877 -1.520597 1.000000" Radius="1.076061" />
            <NODE type="OBJECT" Name="STOCK90_BONNET_CPIT" MatrixNumber="21" instances="1" userflags="304">
                <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_BONNET_CPIT.meb" />
                <SPHERE Centre="0.000000 0.757877 -1.520597 1.000000" Radius="1.076061" />
            </NODE>
            <NODE type="OBJECT" Name="STOCK90_BONNET_CPIT_dmg" MatrixNumber="21" instances="1" userflags="304">
                <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_BONNET_CPIT_dmg.meb" />
                <SPHERE Centre="0.000000 0.757877 -1.520597 1.000000" Radius="1.076061" />
            </NODE>
        </NODE>
        <MATRIX id="22" Offset="0.000000 0.000000 0.000000" Orientation="0.000000 0.000000 0.000000 1.000000" Scale="1.000000" parent="0" />
        <NODE type="OBJECT" Name="STOCK90_INTANIM_CPIT" MatrixNumber="22" instances="1" userflags="304">
            <RESOURCE Filename="vehicles\Stockcar_90\STOCK90_INTANIM_CPIT.meb" />
            <SPHERE Centre="0.338680 0.982776 0.227954 1.000000" Radius="0.610512" />
        </NODE>
    </NODE>
</CAR>
