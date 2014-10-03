package ;

class CarParts {

	static public var guns:Array<Dynamic> = [
    ['chaingun', 52, 13, -11, 0, 12,[0,1],'gunshot1',5,5],
    ['machine_cannon', 46, 11, -8, 0, 12,[0,1,2,2,2],'explosion1',12 * 2,80],
    ['super_bowgun', 61, 26, -15, 0, 12,[0,1,2,2,2,2,2],'bigshot1',12 * 3,80]
    ];
    //['gun name', width, height, x-offset, y-offset, fps, shootAnimationArray, 'bullet name', rate-of-fire, damage]


    static public var bullets:Array<Dynamic> = [
    ['gunshot1', 21, 21, [0,1,2,3],15,20],
    ['explosion1', 34, 28, [0,1,2,3],10,0],
    ['bigshot1', 51, 51, [0,1,2,3],15,1]
    ];
    //['shot name', width, height, animation_array, fps, random_placement_range]




    static public function getGun(GunId:String):Array<Dynamic> {
        for (i in 0...guns.length) {
            if (guns[i][0] == GunId)
                return guns[i];
        }
        return [];
    }

    static public function getBullet(BulletId:String):Array<Dynamic> {
        for (i in 0...bullets.length) {
            if (bullets[i][0] == BulletId)
                return bullets[i];
        }
        return [];
    }
}
