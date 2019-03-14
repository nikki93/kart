
function loadGrassLevel()
    PATH_POINTS = GRASS_PATH_POINTS

    heightAtPoint = function(x, y)
        return _heightAtPoint(x, y)
    end

    FontColor = {0, 0, 0, 1}
    WorldSize = 50
    RoadScale = 35
    RoadRadius = 1.7
    MaxClosestRoadDistance = RoadRadius + 1

    makeHeightMap()
    addMountainRelative(0, 0, 6, 0.1)
    addMountainRelative(0.8, 0.8, 6, 0.1)
    addMountainRelative(0, 0.8, 6, 0.1)
    addMountainRelative(0.8, 0, 6, 0.1)

    addMountainRelative(0.9, 0.3, 2, 0.07)
    addMountainRelative(0.6, 0.75, 3, 0.08)
    addMountainRelative(0.1, 0.8, 1, 0.09)
    addMountainRelative(0.76, 0.13, 2, 0.13)

    addMountainRelative(0.5, 0.30, 3, 0.07)

    updatePathPoints()
    makeJump(10)
    makeRoad(grassRoadImage)

    if CASTLE_SERVER then
        return
    end

    skybox(grassSkyboxImage)
    terrain(grassTerrainImage)
    clearItems()
    makeItems(40)
    makeItems(140)
    makeItems(230)

    FogColor = {1,1,1,1}
    FogStartDist = 5
    FogDivide = 100
end

-- generate with createpath.html
-- format is x,y,angle
GRASS_PATH_POINTS = {{0.5263157894736842, 0.5714285714285714, 0.2074962264352025},
{0.5415485015566631, 0.5747024696563342, 0.17677634324613378},
{0.5557872034336999, 0.5773672785671857, 0.15187519732137478},
{0.569110392128466, 0.5794917034639615, 0.12720327278334542},
{0.5845965228938556, 0.5814919877999265, 0.09764415862410392},
{0.5989281304107934, 0.5828894641941804, 0.07093217237758509},
{0.6122585291786382, 0.5838183226913237, 0.04886489796074778},
{0.6271492789663473, 0.5845033168465091, 0.0312968238376472},
{0.6410839884893318, 0.5849386152911518, 0.026596204445823002},
{0.6543275852024839, 0.5853560984223223, 0.037395524860638796},
{0.6692583992590342, 0.5861299982814255, 0.07102544576692926},
{0.6840298226798237, 0.5875634819867009, 0.12545499457171738},
{0.6990625504510932, 0.5900247670205337, 0.19486223222848853},
{0.7124746167742912, 0.5932316011548288, 0.2600149145272581},
{0.7266526712895642, 0.5976959621595399, 0.3249169011136315},
{0.739243978663772, 0.6025441640561919, 0.3759044106780245},
{0.752704514181066, 0.6085608665998663, 0.4225155551176287},
{0.7671875923408048, 0.6158802598351641, 0.4640653739243479},
{0.7796133129147257, 0.622763887431343, 0.4935645683113692},
{0.7894736842105263, 0.6285714285714286, 0.5070985043923368},
{0.8042329073717536, 0.6374817811324544, 0.5087506822281018},
{0.8186033903496887, 0.6461993460786843, 0.5123201290313684},
{0.832566945227699, 0.6547517968444595, 0.5180668696568713},
{0.8461053840891533, 0.663166806864121, 0.5261786337672221},
{0.8592005190174197, 0.6714720495720105, 0.5368666410077396},
{0.8718341620958654, 0.6796951984024681, 0.5503679444140614},
{0.883988125407859, 0.6878639267898352, 0.5669473541474275},
{0.8956442210367686, 0.6960059081684535, 0.5868984966887091},
{0.906784261065962, 0.7041488159726634, 0.6105433337572064},
{0.919955899761109, 0.7143709122615435, 0.6458246169716381},
{0.9322572596872903, 0.7246917455080162, 0.6881368074309705},
{0.943652817569835, 0.7351653653885294, 0.7381971708332408},
{0.9541070501340698, 0.74584582157953, 0.7966507037211088},
{0.9635844341053242, 0.756787163757466, 0.8639545482906035},
{0.9720494462089257, 0.7680434415987843, 0.9402189377553611},
{0.9808211130972082, 0.7820427920284695, 1.0429212505960153},
{0.9880224267619107, 0.7966668791884113, 1.1558058576196308},
{0.9935920029844002, 0.8120091009195107, 1.2752421606850448},
{0.9974684575460439, 0.8281628550626688, 1.3964503008139848},
{0.9993611938407324, 0.8423116193711504, 1.4951713975654195},
{1, 0.8571428571428571, 1.5707963267948966},
{0.9990078465751642, 0.8720547042312824, 1.7403528249772382},
{0.996091197029507, 0.886362303788701, 1.8848666614832177},
{0.9913397674563019, 0.9000236897153533, 2.024227478203716},
{0.984843273948823, 0.9129968959114798, 2.155344368775059},
{0.9766914326003447, 0.9252399562773221, 2.2764839631757785},
{0.9669739595041414, 0.9367109047131216, 2.387153892118015},
{0.9557805707534867, 0.947367775119118, 2.487759473941697},
{0.9432009824416542, 0.9571686013955525, 2.5792317970002205},
{0.9317238154701012, 0.9646517575583679, 2.6493194085876537},
{0.9193982317924084, 0.9714870095690166, 2.7145735985720894},
{0.9062761504440353, 0.9776500714901376, 2.775670531772657},
{0.8924094904604416, 0.9831166573843708, 2.8332378621206367},
{0.8778501708770866, 0.9878624813143555, 2.887844962716587},
{0.8626501107294302, 0.9918632573427312, 2.9400012183468505},
{0.8468612290529318, 0.995094699532137, 2.9901587261284837},
{0.8305354448830509, 0.9975325219452126, 3.0387170820383984},
{0.8171231373437395, 0.9988950534868086, 3.0766507466631996},
{0.8034270229375129, 0.9997216909717141, 3.1139484947320364},
{0.7894736842105263, 1, 3.141592653589793},
{0.7707471555250341, 1.000008016632937, 3.1406258242008396},
{0.7525856696051366, 1.0000267473897, 3.1404529570122985},
{0.7349681169768332, 1.0000482135572184, 3.1407006187396336},
{0.7178733881661221, 1.0000644364224216, 3.141407617654752},
{0.7012803736990026, 1.0000674372722382, 3.142614086051231},
{0.6851679641014735, 1.0000492373935967, 3.14436114581462},
{0.6695150498995337, 1.0000018580734271, 3.1466904833461085},
{0.6543005216191822, 0.9999173205986576, 3.149643824341282},
{0.6395032697864184, 0.9997876462562182, 3.153262300452251},
{0.6251021849272402, 0.999604856333037, 3.157585702395238},
{0.6110761575676473, 0.9993609721160429, 3.1626516178184145},
{0.5974040782336384, 0.9990480148921655, 3.168494457402401},
{0.5840648374512123, 0.998658005948334, 3.1751443793510834},
{0.564633871587414, 0.9979110671228291, 3.186684897905657},
{0.5458330516734213, 0.9969458816664025, 3.2001497525540725},
{0.5275911332344805, 0.9957355214224392, 3.2155504392613956},
{0.5098368717958378, 0.9942530582343251, 3.232847190204021},
{0.4924990228827399, 0.9924715639454457, 3.251942325757409},
{0.47550634202043296, 0.9903641103991859, 3.272676655314707},
{0.4587875847341633, 0.9879037694389314, 3.2948300343994115},
{0.4422715065491776, 0.9850636129080678, 3.3181268228492407},
{0.4258868629907219, 0.9818167126499805, 3.3422463721184625},
{0.4095624095840428, 0.9781361405080548, 3.3668378922754236},
{0.39322690185438647, 0.9739949683256759, 3.391538283735227},
{0.37680909532699947, 0.9693662679462297, 3.4159909690010126},
{0.360237745527128, 0.9642231112131014, 3.4398635860334235},
{0.3434416079800186, 0.9585385699696765, 3.462862658085836},
{0.32634943821091744, 0.9522857160593402, 3.4847439544741636},
{0.3088899917450711, 0.9454376213254784, 3.5053180262688106},
{0.2909920241077258, 0.937967357611476, 3.5244511395395723},
{0.27878124035310553, 0.9326282345136113, 3.5363640425190335},
{0.26632278461503855, 0.9269926450863403, 3.5475875469317},
{0.25359554741952395, 0.9210526106165917, 3.5581180156649177},
{0.24057841929256055, 0.9148001523912948, 3.567959183510209},
{0.2272502907601472, 0.9082272916973784, 3.5771211022053526},
{0.2135900523482829, 0.9013260498217713, 3.5856191014059497},
{0.19957659458296664, 0.8940884480514029, 3.5934727984050907},
{0.1851888079901972, 0.886506507673202, 3.6007051798266585},
{0.17040558309597365, 0.878572249974098, 3.6073417700337163},
{0.1552058104262948, 0.8702776962410195, 3.613409893899666},
{0.13157894736842105, 0.8571428571428571, 3.618938035963465},
{0.11843894218016852, 0.8493970742137269, 3.6708933154605097},
{0.10620272202490152, 0.8414261863485402, 3.7168661965556007},
{0.09484946145127905, 0.8332195247509186, 3.7669011797465584},
{0.08186782137241153, 0.8226133876981742, 3.835190108673868},
{0.07019259116249331, 0.8116013467012351, 3.9096203865891024},
{0.05978309611187414, 0.8001625642671755, 3.989533009183447},
{0.05059866151090397, 0.7882762029030707, 4.07379766004781},
{0.04259861264993248, 0.7759214251159944, 4.16083371010866},
{0.03574227481930951, 0.7630773934130213, 4.248728060306934},
{0.029988973309384884, 0.7497232703012261, 4.335438069261773},
{0.02529803341050843, 0.7358382182876837, 4.419030557251348},
{0.021628780413029916, 0.721401399879468, 4.4978903528517264},
{0.01894053960729918, 0.7063919775836537, 4.570846706857035},
{0.01719263628366602, 0.6907891139073155, 4.63720235758691},
{0.01634439573248024, 0.6745719713575277, 4.696684394304556},
{0.016355143244091663, 0.6577197124413652, -1.5338331526790827},
{0.017184204108850087, 0.640211499665902, -1.4876902804782737},
{0.01840930501003774, 0.6257186398715893, -1.4551887777588686},
{0.020111269191722448, 0.6107819648154742, -1.426337021026423},
{0.022269271202563327, 0.5953908057011789, -1.4008711188086185},
{0.024862485591219473, 0.5795344937323255, -1.3785284282358816},
{0.02631578947368421, 0.5714285714285714, -1.3734007669450161},
{0.029976972902709387, 0.5518834807844742, -1.3641330393444075},
{0.033644325732104824, 0.5330193307954486, -1.3556280753669827},
{0.03733765432498042, 0.514810533392688, -1.3456806589918244},
{0.04107676504444598, 0.49723150050738457, -1.3341933412367402},
{0.04488146425361138, 0.48025664407073193, -1.3210731835897493},
{0.04877155831558653, 0.46386037601392316, -1.306235051248028},
{0.05276685359348121, 0.4480171082681511, -1.2896055452269803},
{0.05688715645040534, 0.4327012527646086, -1.2711275480722315},
{0.061152273249468765, 0.4178872214344889, -1.250765286749691},
{0.06558201035378135, 0.40354942620898504, -1.2285097220139134},
{0.07019617412645295, 0.3896622790192902, -1.2043839602588027},
{0.07501457093059344, 0.376200191796597, -1.1784482628610382},
{0.0817910290497, 0.3588677202676885, -1.141233574393409},
{0.0890127278420958, 0.34218476780210255, -1.101348559643235},
{0.09672661572404133, 0.3260906811997041, -1.0592921810260103},
{0.10497964111179695, 0.3105248072603581, -1.015685083908715},
{0.11381875242162308, 0.2954264927839295, -0.9712383504893545},
{0.12329089806978015, 0.2807350845702833, -0.9267091957169309},
{0.13344302647252856, 0.2663899294192844, -0.8828497080913476},
{0.1443220860461287, 0.2523303741307978, -0.8403566613063465},
{0.155975025206841, 0.2384957655046885, -0.7998301070997944},
{0.1652508304630743, 0.22823094359158538, -0.7710171225591331},
{0.17500815783431448, 0.2180329486821865, -0.7437316438456394},
{0.18526681368367143, 0.20787619270768487, -0.7180816236515457},
{0.19604660437425506, 0.19773508759927366, -0.6941346634918069},
{0.2073673362691752, 0.1875840452881458, -0.6719220144011522},
{0.21924881573154173, 0.17739747770549424, -0.6514434934486109},
{0.2317108491244645, 0.1671497967825121, -0.6326727874374791},
{0.2447732428110533, 0.15681541445039246, -0.6155627242818902},
{0.2631578947368421, 0.14285714285714285, -0.6000502134017536},
{0.2765923101172719, 0.13405315609333476, -0.45342995698686206},
{0.28934677389763125, 0.12799141908957923, -0.30937128179325657},
{0.30390732575243173, 0.12398164011774242, -0.11979327345543456},
{0.31783239302167177, 0.12312090623653264, 0.06860631328105593},
{0.3313094188245551, 0.12497296586566882, 0.2340622709453346},
{0.34452584628028626, 0.12910156742486997, 0.36322829453843863},
{0.3576691185080696, 0.13507045933385514, 0.4530249573035634},
{0.37092667862710893, 0.14244339001234319, 0.5062643482013096},
{0.3844859697566086, 0.15078410788005317, 0.5273684431031753},
{0.3961510989515711, 0.1581592540119156, 0.5233108914276063},
{0.4082644064305624, 0.16565106168917626, 0.5015522954247196},
{0.42093436622089964, 0.17300707050657987, 0.4636007270586222},
{0.4342694523499001, 0.17997482005887122, 0.4108723780743475},
{0.44837813884488115, 0.1863018499407951, 0.3449586582204742},
{0.46336889973315987, 0.19173569974709628, 0.26786562076883724},
{0.4793502090420538, 0.1960239090725196, 0.18214824890400916},
{0.4929213458983688, 0.19845996199429455, 0.10940906649754867},
{0.5072513958233469, 0.19987197062145373, 0.03480501136505465},
{0.5263157894736842, 0.2, -0.03997868712329011},
{0.5436424213652257, 0.1989693367232313, -0.07995060628753925},
{0.5601280294265721, 0.19744559389623684, -0.11058581427848568},
{0.575820655922017, 0.19546685630969834, -0.1415105202928193},
{0.5907683431158537, 0.19307120875429734, -0.17242804091826724},
{0.6050191332723754, 0.19029673602071556, -0.20299636292225842},
{0.6186210686558763, 0.18718152289963477, -0.23283232398827858},
{0.631622191530649, 0.1837636541817365, -0.2615182232825388},
{0.648105460806906, 0.17880152386029727, -0.2972081667572417},
{0.6637199053861975, 0.17345932049845478, -0.3289748459292654},
{0.6785794032283299, 0.16782731915560256, -0.35572929337541637},
{0.6927978322931101, 0.1619957948911342, -0.37643040181576337},
{0.7064890705403445, 0.1560550227644433, -0.39013046053669354},
{0.7197669959298403, 0.15009527783492346, -0.3960173973907908},
{0.7327454864214034, 0.14420683516196828, -0.393455978773533},
{0.745538419974841, 0.13847996980497124, -0.38203162477971686},
{0.7582596745499597, 0.13300495682332605, -0.3615993425308772},
{0.7710231281065661, 0.12787207127642622, -0.33233594706101655},
{0.7839426586044668, 0.1231715882236654, -0.294786680777696},
{0.7971321440034687, 0.11899378272443717, -0.249889798026113},
{0.810705462263378, 0.11542892983813506, -0.1989589669618994},
{0.8247764913440018, 0.11256730462415268, -0.14360841553461867},
{0.8394591092051467, 0.11049918214188366, -0.08562142102724324},
{0.8548671938066195, 0.10931483745072158, -0.026783842047543027},
{0.8711146231082264, 0.10910454561006, 0.03128025028374082},
{0.8883152750697745, 0.1099585816792925, 0.08723378695548778},
{0.9019098211217178, 0.1113518800125013, 0.12720735309384001},
{0.9210526315789473, 0.11428571428571428, 0.1651486774146269},
{0.9356464233694142, 0.11816829316929492, 0.3380712868384268},
{0.9490717123333366, 0.12418097714546301, 0.4870495029920989},
{0.961280517484962, 0.1321020140964897, 0.6306796446876225},
{0.9722248578385366, 0.1417096519046459, 0.7672856929823042},
{0.9818567524083086, 0.15278213845220276, 0.8965133395398792},
{0.9901282202085253, 0.1650977216214314, 1.0190649382798234},
{0.9969912802534339, 0.17843464929460284, 1.1363592399407407},
{1.0023979515572807, 0.19257116935398805, 1.2502406166068107},
{1.0063002531343141, 0.20728552968185823, 1.3627758593047952},
{1.008650203998781, 0.2223559781604844, 1.4761218819156996},
{1.0093998231649286, 0.23756076267213758, 1.5924241125405467},
{1.0085011296470043, 0.25267813109908893, 1.7136979113860737},
{1.0059061424592552, 0.2674863313236094, 1.8416456724841714},
{1.0015668806159286, 0.28176361122797006, 1.977375198070452},
{1, 0.2857142857142857, 1.997423819921773},
{0.9940911323531451, 0.2991050547788758, 2.047574287170348},
{0.9878790249009759, 0.31173690037610274, 2.094498207220903},
{0.9799813206197618, 0.3259170957704807, 2.156912183295357},
{0.9715504287288067, 0.3390579005947631, 2.2255851116238787},
{0.9625337007062424, 0.35118847442508067, 2.299654833503473},
{0.9528784880302028, 0.3623379768375648, 2.377782189720949},
{0.9425321421788218, 0.3725355674083471, 2.4582173352364656},
{0.9314420146302319, 0.38181040571355845, 2.5389632966200706},
{0.9195554568625665, 0.39019165132933015, 2.618005998901265},
{0.9068198203539589, 0.3977084638317936, 2.69354889226218},
{0.8931824565825427, 0.4043900027970798, 2.7641880407535213},
{0.8785907170264511, 0.41026542780132025, 2.8289917633513246},
{0.8656639136967034, 0.41456687100103246, 2.8781843167340884},
{0.852007320037258, 0.41834563729925955, 2.922924659133524},
{0.8375904681535162, 0.42161860145070706, 2.963292439652352},
{0.8223828901508798, 0.4244026382100808, 2.9994705796566086},
{0.8063541181347493, 0.42671462233208607, 3.0317086624208613},
{0.7894736842105263, 0.42857142857142855, 3.054854314913808},
{0.7730876343179806, 0.4298688243746938, 3.0931900395924568},
{0.7575850151986846, 0.4306007820702854, 3.1239727368707095},
{0.7429081538920044, 0.4307985268119396, 3.1563543605163225},
{0.7289993774373058, 0.4304932837533922, 3.190121133669238},
{0.715801012873955, 0.4297162780483795, 3.2249686467884326},
{0.699208596960118, 0.42800038683760233, 3.272406855001667},
{0.6836398995349364, 0.4255753330411991, 3.319835274101419},
{0.6689582143213524, 0.4225151318383965, 3.3657985248760216},
{0.6550268350423077, 0.41889379840842056, 3.40869250635928},
{0.6417090554207441, 0.4147853479304978, 3.4469006703560003},
{0.6288681691796034, 0.4102637955838541, 3.478942526996639},
{0.6163674700418276, 0.40540315654771625, 3.5036056245457345},
{0.6040702517303586, 0.40027744600131004, 3.520039593238918},
{0.5918398079681381, 0.39496067912386196, 3.527804218887824},
{0.5795394324781079, 0.38952687109459827, 3.526875410929903},
{0.5670324189832099, 0.38405003709274516, 3.517618597489103},
{0.5541820612063861, 0.37860419229752895, 3.5007387010559317},
{0.5408516528705783, 0.37326335188817594, 3.4772128505187077},
{0.5269044876987282, 0.3681015310439123, 3.4482099632211773},
{0.512203859413778, 0.36319274494396453, 3.4150019163394285},
{0.4966130617386691, 0.3586110087675587, 3.3788734583169875},
{0.47999538839634376, 0.3544303376939211, 3.3410401070177302},
{0.4667760088631959, 0.3516025581186379, 3.312203050109561},
{0.4528444415257597, 0.3490732363557127, 3.283410948754411},
{0.4381430134234012, 0.3468735975588816, 3.254994683732243},
{0.42261405159548626, 0.3450348668818806, 3.227223109810711},
{0.4061998830813813, 0.3435882694784459, 3.20030557192655},
{0.39473684210526316, 0.34285714285714286, 3.1915510493117356},
{0.3808551675590803, 0.3423186758310355, 3.1565518352144704},
{0.366176091227392, 0.34233390660456736, 3.1109958441212004},
{0.35266805188726597, 0.3430812468052346, 3.053191481662484},
{0.33874951774743534, 0.3448743398767713, 2.9718564111388006},
{0.32470826962450555, 0.34815289100901564, 2.860712397777198},
{0.3119811407653666, 0.35290247943432196, 2.730810736226517},
{0.2992711809650295, 0.3599706723014825, 2.5762906326385715},
{0.2876660440826685, 0.36912667309019154, 2.425093903374455},
{0.27786076095701984, 0.3793977370105019, 2.302799184734702},
{0.26856751215101166, 0.3916486858221278, 2.2012771052327893},
{0.2631578947368421, 0.4, 2.1587989303424644},
{0.2567637726252808, 0.4127042323990756, 1.9656227129529036},
{0.2523883756619582, 0.42732511789898076, 1.7709441335716236},
{0.2507349054611436, 0.4423617950324572, 1.575238501445945},
{0.2518124894807333, 0.4574243841745563, 1.378499296063735},
{0.25563025517862387, 0.47212300570033, 1.1809588463790308},
{0.2615448427131906, 0.48494402208271253, 1.000137966654362},
{0.2697766440858467, 0.49683129079429883, 0.8214174042866251},
{0.28033268976329356, 0.5074845052489743, 0.647388107468649},
{0.2894736842105263, 0.5142857142857142, 0.540419500270584},
{0.3026531798062231, 0.5225245576433776, 0.49500225482604976},
{0.31499360921820474, 0.5295453485785594, 0.45192239891655506},
{0.3288584221270111, 0.536515367360968, 0.3945717921421077},
{0.34188367592936625, 0.5420754130852029, 0.3327730512790845},
{0.3562869938039312, 0.5470304267365899, 0.2591941418493402},
{0.37014065794064605, 0.5506197000083831, 0.19031698997894608},
{0.3837640188343283, 0.5531412119247207, 0.13300509387705928},
{0.39747642697979574, 0.5548929415097392, 0.09245648682463892},
{0.4115972328718655, 0.5561728677875758, 0.07093370031658885},
{0.42644578700535546, 0.5572789697823679, 0.06771995733804004},
{0.4399944205733038, 0.5583145805796664, 0.07740882130515958},
{0.454513458189102, 0.559629055703405, 0.09602441953956897},
{0.47020400686989444, 0.5614100437518743, 0.12101473944959085},
{0.48431945717130703, 0.5633859436957263, 0.14500647957074353},
{0.4995044958498672, 0.5659247154138348, 0.17063137258092143},
{0.512500838708707, 0.5684339749206774, 0.1916663835684287}}