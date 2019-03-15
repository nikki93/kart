
function removeHeights()
    local x = -WorldSize
    local xi = 1
    while x <= WorldSize do
        local y = -WorldSize
        local yi = 1
        while y <= WorldSize do
            HEIGHTS[xi][yi] = 0
            y = y + GridSize
            yi = yi + 1
        end

        x = x + GridSize
        xi = xi + 1
    end
end

function loadRainbowLevel()
    PATH_POINTS = RAINBOW_PATH_POINTS

    heightAtPoint = function(x, y)
        return _heightAtPoint(x, y)
    end

    FontColor = {1, 1, 1, 1}
    WorldSize = 30
    RoadScale = 35
    RoadRadius = 1.5
    MaxClosestRoadDistance = RoadRadius + 2

    makeHeightMap()
    math.randomseed(128310)
    local numRows = 2 * WorldSize / GridSize
    for i = 0, 10 do
        addMountain(math.floor(math.random() * numRows), math.floor(math.random() * numRows), math.floor(math.random() * 7), math.random() * 0.2 + 0.05)
    end
    math.randomseed(os.time())

    updatePathPoints()
    makeSinHill(70, 80, 3)
    makeSinHill(200, 100, 4)
    makeSinHill(430, 60, 1)
    makeRoad(rainbowRoadImage, nil)

    if CASTLE_SERVER then
        return
    end

    skybox(moonSkyboxImage)
    clearItems()
    makeItems(40)
    makeItems(180)
    makeItems(300)
    makeItems(400)
    makeItems(480)

    heightAtPoint = function(x, y)
        return {
            height = -100,
            normal = {0,1,0}
        }
    end

    FogColor = {0,0,0,1}
    FogStartDist = 5
    FogDivide = 20
    GRAVITY = 2.5
    Engine.camera.pos.y = 5
end

-- [282,387.5625,438,391.5625,502,299.5625,403,239.5625,346,335.5625,419,483.5625,279,515.5625,115,428.5625,60,192.5625,144,50.5625,263,65.5625,237,176.5625,137,151.5625,107,28.5625,331,12.5625,393,107.5625,541,58.5625,567,144.5625,356,178.5625]

-- generate with createpath.html
-- format is x,y,angle
RAINBOW_PATH_POINTS = {{0.4973544973544973, 0.7517274821190447, 1.203307928658648},
{0.5014230804787856, 0.761429692889072, 1.037903853268882},
{0.5064286364926451, 0.7700799709497639, 0.9007273322041224},
{0.5123243505396208, 0.777713439370569, 0.7645143803938014},
{0.5190634077632578, 0.7843652212209378, 0.6339682885500473},
{0.5265989933071019, 0.7900704395703195, 0.5126836064960127},
{0.534884292314697, 0.7948642174881634, 0.402730741333714},
{0.543872489929589, 0.7987816780439186, 0.3047587961023368},
{0.5535167712953227, 0.8018579443070355, 0.21838894357477945},
{0.5637703215554435, 0.8041281393469628, 0.14264957158912894},
{0.5745863258534959, 0.8056273862331502, 0.0763170801922175},
{0.5859179693330254, 0.8063908080350474, 0.018132845886754234},
{0.5977184371375771, 0.8064535278221036, -0.03308066893739969},
{0.6068482918922005, 0.8060618606866223, -0.06755131781121348},
{0.6161957769553259, 0.805310622939282, -0.09908137600064126},
{0.6257411423093867, 0.8042146321250073, -0.12801557983103473},
{0.6354646379368156, 0.8027887057887216, -0.154657998017093},
{0.6453465138200458, 0.8010476614753497, -0.17927607909589072},
{0.6553670199415106, 0.7990063167298145, -0.20210487664886756},
{0.6655064062836431, 0.7966794890970411, -0.2233511326622688},
{0.6757449228288759, 0.7940819961219528, -0.2431970577355671},
{0.6860628195596424, 0.791228655349474, -0.26180374248097604},
{0.6964403464583758, 0.7881342843245281, -0.27931418989105494},
{0.706857753507509, 0.7848137005920399, -0.295855988871766},
{0.7172952906894753, 0.781281721696933, -0.3115436644572691},
{0.7277332079867075, 0.7775531651841311, -0.3264807467625641},
{0.7381517553816388, 0.7736428485985586, -0.3407616024565212},
{0.7485311828567024, 0.7695655894851395, -0.3544730719121769},
{0.758851740394331, 0.7653362053887975, -0.3676959537409261},
{0.7724867724867724, 0.7594859983028246, -0.3805063771123647},
{0.7820520619622532, 0.7550413485811545, -0.4290963945434212},
{0.7912789952153002, 0.7502770600790264, -0.46897262701468057},
{0.800156811119559, 0.7452055510594634, -0.5098476488651507},
{0.8086747485486752, 0.7398392397854882, -0.5518266256405702},
{0.8168220463762944, 0.7341905445201237, -0.5950209585922508},
{0.824587943476061, 0.7282718835263917, -0.6395474345863672},
{0.8319616787216217, 0.7220956750673153, -0.6855269269200672},
{0.8389324909866213, 0.7156743374059177, -0.7330825205963905},
{0.8454896191447054, 0.7090202888052207, -0.7823369196014198},
{0.8530878921635295, 0.7003943967435339, -0.8464742253206277},
{0.8600019516804579, 0.6914485517951312, -0.9136634067329528},
{0.8662107798705797, 0.6822070083799792, -0.984078752847235},
{0.871693358908983, 0.6726940209180435, -1.0578345993701137},
{0.8764286709707568, 0.6629338438292905, -1.134959813722518},
{0.8803956982309898, 0.6529507315336862, -1.215370546217395},
{0.8835734228647709, 0.6427689384511971, -1.2988446935062345},
{0.8859408270471887, 0.6324127190017887, -1.3850030229603263},
{0.8874768929533321, 0.6219063276054276, -1.4733027378307324},
{0.8881606027582897, 0.6112740186820798, -1.563048641300277},
{0.8879709386371506, 0.6005400466517112, 4.629760852967527},
{0.8868868827650029, 0.5897286659342882, 4.5396428143351955},
{0.8853615520282186, 0.581040126075888, 4.486070670496602},
{0.882471660895998, 0.5699301620706676, 4.362758622502417},
{0.8785526626608909, 0.5591009743683762, 4.267264329326561},
{0.8736736143383259, 0.5485985928284798, 4.178162683818445},
{0.8679035729437333, 0.538469047310444, 4.094914236541001},
{0.8613115954925428, 0.5287583676737353, 4.016789108931798},
{0.8554926258852085, 0.5213223394644847, 3.957424117683062},
{0.8492271708834259, 0.5142074118173883, 3.900368760463193},
{0.8425505876790955, 0.5074371520204923, 3.8451798289338743},
{0.8354982334641172, 0.5010351273618436, 3.7914184877274724},
{0.828105465430391, 0.49502490512948855, 3.7386528929685436},
{0.8204076407698168, 0.4894300526114739, 3.6864582394220253},
{0.8124401166742943, 0.48427413709584605, 3.6344152293630176},
{0.8042382503357237, 0.4795807258706517, 3.5821077566493686},
{0.7958373989460051, 0.4753733862239373, 3.5291204784201424},
{0.7872729196970382, 0.47167568544374966, 3.4750369085861936},
{0.7785801697807231, 0.4685111908181351, 3.4194387091789507},
{0.7697945063889595, 0.4659034696351404, 3.3619069700262605},
{0.760951286713648, 0.46387608918281203, 3.3020264373194266},
{0.752085867946688, 0.46245261674919647, 3.239393841213951},
{0.7432336072799797, 0.4616566196223406, 3.173631609711717},
{0.732240649497108, 0.4615799136542846, 3.0865292630854313},
{0.721392553873653, 0.46256649160007923, 2.993548429372238},
{0.7107583774250441, 0.4646623833191902, 2.9147938055359077},
{0.7008459970076454, 0.4676524176578232, 2.815766019534565},
{0.6913780636344985, 0.47146305031278773, 2.7318517618927123},
{0.6823662207875424, 0.4760683953380614, 2.6473647141117667},
{0.673822111948717, 0.48144256678762276, 2.5629687423528837},
{0.6657573805999618, 0.48755967871544986, 2.479302779394695},
{0.6581836702232163, 0.49439384517552093, 2.3969463391716723},
{0.6511126243004203, 0.5019191802218143, 2.3163929282219726},
{0.6445558863135131, 0.5101097979083078, 2.2380338970886013},
{0.6385250997444339, 0.5189398122889797, 2.162153102522465},
{0.6330319080751227, 0.5283833374178081, 2.088930922743907},
{0.6280879547875191, 0.5384144873487716, 2.0184550807285206},
{0.6237048833635623, 0.5490073761358479, 1.9507354401229726},
{0.6198943372851919, 0.5601361178330155, 1.8857202513612141},
{0.6172659430911813, 0.5694075299302884, 1.835590913075695},
{0.6150173784095405, 0.5789920672802026, 1.787065483893306},
{0.6131546047030224, 0.5888764762783947, 1.7400699495715088},
{0.6116835834343802, 0.5990475033205018, 1.694524753545156},
{0.6106102760663666, 0.6094918948021604, 1.6503475526033837},
{0.6099406440617352, 0.6201963971190078, 1.6074554113445347},
{0.6096806488832386, 0.6311477566666801, 1.56576650188177},
{0.6098362519936299, 0.6423327198408147, 1.5252013812035283},
{0.6102292768959435, 0.6508667717299067, 1.505316301871432},
{0.6113653317863176, 0.6633341107825738, 1.4134240658620978},
{0.613223349399935, 0.6753441636908637, 1.345965845037334},
{0.6157503522205748, 0.6869178802195554, 1.280763846542623},
{0.6188933627320162, 0.6980762101334275, 1.2186147385862656},
{0.6225994034180388, 0.7088401031972584, 1.1601785676730878},
{0.6268154967624221, 0.7192305091758282, 1.1059642356097381},
{0.6314886652489451, 0.7292683778339142, 1.0563335059352195},
{0.6365659313613873, 0.7389746589362958, 1.0115189882913498},
{0.641994317583528, 0.7483703022477517, 0.9716504943840986},
{0.6477208463991463, 0.757476257533061, 0.9367846997327642},
{0.6536925402920221, 0.7663134745570022, 0.906934437469408},
{0.6598564217459341, 0.7749029030843541, 0.8820955119162854},
{0.666159513244662, 0.7832654928798956, 0.8622702323549385},
{0.672548837271985, 0.7914221937084052, 0.8474877754561793},
{0.6789714163116826, 0.7993939553346622, 0.8378219996204184},
{0.6853742728475338, 0.8072017275234448, 0.8334075334706884},
{0.6917044293633182, 0.8148664600395322, 0.8344549165390174},
{0.6979089083428153, 0.822409102647703, 0.8412653093416328},
{0.703934732269804, 0.8298506051127361, 0.8542447678396518},
{0.709728923628064, 0.8372119171994102, 0.8739171552481008},
{0.7170026286991915, 0.8469384688630719, 0.9117014091394009},
{0.723644783951219, 0.8566093625820668, 0.9644416805305446},
{0.7295298130494016, 0.8662742570580928, 1.0343123986668916},
{0.7345321396589932, 0.8759828109928475, 1.123444344550693},
{0.7385261874452491, 0.8857846830880286, 1.2332071559213444},
{0.741386380073424, 0.8957295320453348, 1.3630352811680086},
{0.7429871412087722, 0.9058670165664631, 1.5091263342814674},
{0.7432028945165488, 0.9162467953531117, 1.6639912638140901},
{0.7419080636620083, 0.9269185271069785, 1.8178903970782372},
{0.7389770723104057, 0.9379318705297612, 1.9271294638065388},
{0.735321912548572, 0.9473121614123547, 2.050574594711266},
{0.7309699736845902, 0.9559711873169079, 2.1524066053868185},
{0.7245856404065051, 0.9658097953344906, 2.2801382256091243},
{0.7171943649681323, 0.9745885910829468, 2.404501775846845},
{0.7088415780288162, 0.9823448880395345, 2.5219661204590653},
{0.7014975895997626, 0.9878388011313751, 2.60929912072824},
{0.6935905699296696, 0.9927213001222193, 2.6899675488897135},
{0.6851437795161208, 0.9970114895124219, 2.7637420273776847},
{0.6761804788567005, 1.0007284738023392, 2.8307326994444537},
{0.6667239284489926, 1.0038913574923263, 2.891278080448865},
{0.6567973887905815, 1.0065192450827383, 2.945848966443909},
{0.6464241203790508, 1.008631241073931, 2.9949757279393365},
{0.6356273837119852, 1.0102464499662598, 3.0391987108291065},
{0.6244304392869684, 1.0113839762600798, 3.079037532919496},
{0.6128565476015844, 1.0120629244557469, 3.114974172641405},
{0.6039427498410084, 1.0122826862765788, 3.1396303251621545},
{0.5948398162987856, 1.0122633039097377, 3.1625049139792223},
{0.5855575599973336, 1.01201283706631, 3.1837500817772852},
{0.5761057939590712, 1.0115393454573833, 3.2035040075641237},
{0.5664943312064166, 1.0108508887940453, 3.221891802121247},
{0.5567329847617879, 1.0099555267873832, 3.2390265009945827},
{0.5468315676476038, 1.008861319148485, 3.2550100829403688},
{0.536799892886282, 1.0075763255884371, 3.2699344675141733},
{0.5266477735002411, 1.0061086058183282, 3.2838824635689416},
{0.5163850225118995, 1.0044662195492449, 3.296928652848176},
{0.5060214529436753, 1.0026572264922746, 3.3091402012023132},
{0.49206349206349204, 1, 3.3205775954072836},
{0.4831095783779186, 0.9982269657121925, 3.318401628997127},
{0.47438200694731025, 0.9965117175313389, 3.317696929505849},
{0.46170178090438685, 0.9940303544791662, 3.317884380379841},
{0.44949672618495423, 0.9916357080011025, 3.319723872231898},
{0.4377463835389041, 0.9893017967972246, 3.323401306708228},
{0.4264302937161283, 0.9870026395676099, 3.329108267861809},
{0.415527997466519, 0.9847122550123364, 3.3370383775531574},
{0.40501903553996754, 0.9824046618314799, 3.347382304062806},
{0.39488294868636586, 0.9800538787251182, 3.360321179631797},
{0.38509927765560586, 0.977633924393329, 3.3760182305950863},
{0.37564756319757925, 0.975118817536189, 3.394608539823119},
{0.36650734606217783, 0.9724825768537757, 3.416187071523332},
{0.3576581669992935, 0.969699221046166, 3.4407954124211697},
{0.34907956675881796, 0.9667427688134376, 3.468408118688262},
{0.33802697182841074, 0.9624866654469082, 3.5097040510097743},
{0.3273705379151703, 0.9578150608212287, 3.555644788091194},
{0.31706176901884026, 0.9526663696328774, 3.605436019082328},
{0.30705216913916406, 0.9469790065783346, 3.6580152012877374},
{0.29729324227588544, 0.9406913863540792, 3.7121254403529633},
{0.28773649242874777, 0.9337419236565907, 3.766427680436761},
{0.27833342359749463, 0.9260690331823482, 3.81962904785885},
{0.2713528017655747, 0.9198025684390224, 3.8581188910214252},
{0.2644108872548374, 0.9130685525381196, 3.894959027215409},
{0.25748722081517444, 0.9058410041797164, 3.92984742026712},
{0.25056134319647766, 0.8980939420638907, 3.962570785028005},
{0.24361279514863884, 0.8898013848907194, 3.992999304476149},
{0.2366211174215499, 0.8809373513602797, 4.021076775963482},
{0.22956585076510247, 0.871475860172649, 4.046808284029749},
{0.22242653592918848, 0.8613909300279043, 4.070247178059123},
{0.21518271366369968, 0.8506565796261226, 4.091482647677426},
{0.20781392471852783, 0.8392468276673818, 4.110628691174566},
{0.20282186948853614, 0.8312522730027883, 4.116568483521973},
{0.1963880303217313, 0.8207461804194417, 4.126354376265558},
{0.19020550170664763, 0.8105032778694464, 4.1337283475824576},
{0.18427004051924503, 0.800510562515224, 4.141825804592346},
{0.1785774036354833, 0.7907550315191967, 4.150682962089667},
{0.1731233479313223, 0.7812236820437861, 4.160334343647765},
{0.1679036302827219, 0.7719035112514139, 4.170811946786719},
{0.16291400756564203, 0.7627815163045024, 4.182144286531823},
{0.15815023665604253, 0.7538446943654732, 4.194355321149777},
{0.15360807442988328, 0.7450800425967488, 4.207463271557327},
{0.1492832777631241, 0.7364745581607506, 4.221479355590626},
{0.14319436135302266, 0.7238363265484121, 4.24420996636672},
{0.1375706498788457, 0.7114830804733315, 4.268955872410673},
{0.13239782279695778, 0.6993709353586819, 4.295626699939178},
{0.12766155956372346, 0.6874560066276378, 4.324066529231747},
{0.12334753963550721, 0.6756944097033724, 4.3540498113152974},
{0.11944144246867362, 0.66404226000906, 4.385282042391042},
{0.11592894751958721, 0.6524556729678744, 4.4174062354089285},
{0.11279573424461266, 0.6408907640029898, 4.450015510705425},
{0.11002748210011436, 0.6293036485375798, 4.482671154467754},
{0.10760987054245696, 0.6176504419948184, 4.514924479679522},
{0.10552857902800496, 0.6058872597978795, 4.5463400489896735},
{0.10376928701312294, 0.5939702173699372, 4.576517523095656},
{0.10231767395417544, 0.5818554301341652, 4.605109678868667},
{0.10115941930752705, 0.5694990135137374, 4.631834907708786},
{0.10028020252954226, 0.556857082931828, 4.6564835193129195},
{0.09966570307658563, 0.5438857538116105, 4.6789181584308235},
{0.09930160040502174, 0.5305411415762592, 4.699069373575645},
{0.09917357397121515, 0.5167793616489478, -1.5662575485268526},
{0.09926730323153037, 0.5025565294528502, -1.550651166996201},
{0.09944591513951907, 0.4927968297768295, -1.5414595572477987},
{0.09971247732368382, 0.482799710887403, -1.5332020580234524},
{0.10006274665998448, 0.47255216994699256, -1.5258425148283408},
{0.10049248002438091, 0.4620412041180203, -1.5193413263204167},
{0.10099743429283299, 0.451253810562908, -1.51365645635236},
{0.10157336634130053, 0.4401769864440774, -1.5087443192649217},
{0.10221603304574348, 0.4287977289239506, -1.5045605400027537},
{0.10292119128212165, 0.41710303516494956, -1.5010605949147555},
{0.10368459792639494, 0.40507990232949603, -1.4982003419253607},
{0.1045020098545232, 0.392715327580012, -1.4959364504063934},
{0.10582010582010581, 0.37349981815977695, -1.4942267418140842},
{0.1068178154393729, 0.3603834434530691, -1.4750484660606427},
{0.10795132019737351, 0.34775099746474986, -1.458789751222974},
{0.10922803120668126, 0.335584891052165, -1.440812906746892},
{0.11065535957986955, 0.3238675350726602, -1.4210245461743019},
{0.1122407164295119, 0.31258134038358165, -1.3993416554884015},
{0.11399151286818192, 0.3017087178422752, -1.3756965852706164},
{0.11591516000845294, 0.2912320783060867, -1.3500428450265067},
{0.11801906896289852, 0.28113383263236197, -1.3223615498296182},
{0.12031065084409218, 0.271396391678447, -1.2926682255269428},
{0.12279731676460745, 0.2620021663016877, -1.2610195076616728},
{0.1264291447168353, 0.24998002237650305, -1.2159660812850372},
{0.13043853113186563, 0.23849507710784476, -1.1680158635102496},
{0.13484304309135417, 0.22750563771312535, -1.117725707141521},
{0.1396602476769566, 0.21697001140975725, -1.065807360486028},
{0.1449077119703286, 0.2068465054151531, -1.0130933943327314},
{0.1506030030531259, 0.19709342694672533, -0.9604841023937989},
{0.15676368800700421, 0.18766908322188652, -0.9088827881016615},
{0.16340733391361925, 0.17853178145804904, -0.8591303408276971},
{0.17055150785462667, 0.16963982887262555, -0.8119502313875469},
{0.17821377691168216, 0.16095153268302842, -0.7679119120257174},
{0.1864117081664415, 0.15242520010667027, -0.7274155383507956},
{0.19516286870056032, 0.14401913836096356, -0.6906960233084471},
{0.20209986351328765, 0.13776843896977317, -0.6656926292231677},
{0.2093653423916595, 0.1315443505879647, -0.642856767451077},
{0.21696671644824939, 0.125329284072884, -0.6221481592843761},
{0.22491139679563085, 0.11910565028187695, -0.6035018465979922},
{0.2332067945463773, 0.11285586007228947, -0.5868344000163161},
{0.24186032081306233, 0.10656232430146743, -0.5720493843193415},
{0.25396825396825395, 0.09807249363559219, -0.5590419890640934},
{0.26308886488135724, 0.09218579456686697, -0.4880521972894818},
{0.2723478688065699, 0.08696254700149007, -0.4313976135770594},
{0.28171932807726147, 0.08239284940094092, -0.37492648753429525},
{0.2911773050268011, 0.07846680022669908, -0.318670557536179},
{0.30069586198855847, 0.07517449794024404, -0.2626375142911741},
{0.3102490612959024, 0.0725060410030552, -0.20681118003190657},
{0.31981096528220243, 0.07045152787661206, -0.15115222697256647},
{0.3293556362808279, 0.06900105702239417, -0.09559932136497351},
{0.3388571366251482, 0.06814472690188098, -0.04007059145995573},
{0.3482895286485326, 0.06787263597655194, 0.015534658232536414},
{0.3576268746843504, 0.06817488270788659, 0.07133403137133931},
{0.3668432370659709, 0.06904156555736435, 0.12745992998873867},
{0.37591267812676354, 0.07046278298646476, 0.18405721713014667},
{0.38480926020009754, 0.07242863345666728, 0.24128057801011948},
{0.3935070456193423, 0.0749292154294514, 0.2992914675023157},
{0.40198009671786705, 0.0779546273662966, 0.35825449901657436},
{0.4102024758290412, 0.08149496772868235, 0.41833310725280537},
{0.4200884278217894, 0.08662942690499112, 0.49523824898730995},
{0.42949151772505373, 0.09253365164984584, 0.5744076568107568},
{0.4383610860336963, 0.09918830302082358, 0.6560637287872706},
{0.44664647324257883, 0.10657404207550152, 0.7403473873748035},
{0.45429701984656357, 0.11467152987145673, 0.8272883642622272},
{0.4612620663405121, 0.12346142746626636, 0.9167759289750446},
{0.4638447971781305, 0.12716692932476664, 0.9349579032711512},
{0.4693383144486138, 0.1364770348607128, 1.0770817602026568},
{0.473847752750754, 0.14648276168260682, 1.1868778294842854},
{0.4774005237331355, 0.15709369634224757, 1.2883784079775695},
{0.4800240390443437, 0.16821942539143422, 1.3818770693386848},
{0.48174571033296354, 0.17976953538196577, 1.4680960150195317},
{0.4825929492475798, 0.19165361286564117, 1.547989480484725},
{0.48259316743677777, 0.20378124439425951, 1.6226068476980016},
{0.4820019076936837, 0.213597950692322, 1.6792167983392605},
{0.48090013290549166, 0.2234663752868204, 1.7336629405085728},
{0.47930187783627715, 0.23334022649227593, 1.786460670628483},
{0.47722117725011565, 0.2431732126232095, 1.8381083524674375},
{0.47467206591108274, 0.25291904199414234, 1.8890900567760556},
{0.4716685785832537, 0.2625314229195955, 1.9398800051379506},
{0.4682247500307042, 0.27196406371409015, 1.9909478194703378},
{0.46435461501750974, 0.2811706726921473, 2.042763875903922},
{0.4600722083077457, 0.290104958168288, 2.0958041206516507},
{0.4553915646654877, 0.2987206284570336, 2.150553633842821},
{0.4503267188548112, 0.3069713918729049, 2.2075080282867043},
{0.44489170563979163, 0.31481095673042314, 2.2671714481895773},
{0.4391005597845046, 0.3221930313441094, 2.33004950977562},
{0.4313821970259159, 0.33070675646623177, 2.413915486394391},
{0.4231567179843621, 0.3383429088756049, 2.504444512354209},
{0.41798941798941797, 0.3424657534246575, 2.5426813918595617},
{0.4099350477660871, 0.347934402645751, 2.6533905842635264},
{0.4016197497596854, 0.3524707328933673, 2.7461974160169516},
{0.3930736089177708, 0.3560916537239886, 2.838464145539829},
{0.3843267101879024, 0.3588140746940979, 2.929294646246051},
{0.3754091385176381, 0.36065490536017775, 3.0179295675780065},
{0.3663509788545365, 0.3616310552787106, 3.103783665804626},
{0.35718231614615603, 0.36175943400617955, 3.1864587273963343},
{0.34793323534005516, 0.3610569510990668, 3.26573530435829},
{0.3386338213837921, 0.3595405161138551, 3.3415497730762334},
{0.3293141592249253, 0.35722703860702715, 3.413963906330318},
{0.3200043338110134, 0.35413342813506554, 3.483132965860934},
{0.3107344300896146, 0.350276594254453, 3.549276346784988},
{0.3015345330082875, 0.3456734465216721, 3.6126528693703497},
{0.29243472751459026, 0.3403408944932055, 3.673541342499303},
{0.2834650985560815, 0.3342958477255357, 3.732226106179654},
{0.2746557310803195, 0.3275552157751456, 3.7889868058412257},
{0.2660367100348628, 0.32013590819851756, 3.8440915112141227},
{0.2592987597130765, 0.3137231789082804, 3.8871529877581317},
{0.25271728896627277, 0.3068955770263189, 3.929436936806545},
{0.2463077012876016, 0.29966176024555247, 3.971055840558878},
{0.24162257495590828, 0.2939750272760335, 3.9916487634112228},
{0.23410277597005155, 0.2843345595815406, 4.020975039231036},
{0.22673510414018475, 0.2744254890687169, 4.044924515217064},
{0.21955844936845526, 0.26428391059200146, 4.0696036632792705},
{0.21261170155701078, 0.25394591900583374, 4.095295184253906},
{0.20593375060799898, 0.2434476091646531, 4.122300688764019},
{0.19956348642356725, 0.23282507592289853, 4.150950143459088},
{0.19353979890586318, 0.22211441413500954, 4.1816120680345295},
{0.18790157795703438, 0.2113517186554254, 4.214704797140859},
{0.18268771347922846, 0.2005730843385853, 4.250708981634705},
{0.17793709537459287, 0.18981460603892866, 4.290181237759406},
{0.17368861354527532, 0.1791123786108947, 4.333768339476019},
{0.1699811578934233, 0.16850249690892272, 4.382220388694156},
{0.16685361832118437, 0.15802105578745196, 4.436399681361772},
{0.16434488473070613, 0.14770415010092178, 4.497279092530022},
{0.1624938470241362, 0.13758787470377143, 4.5659193133448746},
{0.161339395103622, 0.12770832445044022, 4.643408228514858},
{0.16093515029992328, 0.11574676962208175, -1.528982773398198},
{0.16175604309917427, 0.10428199380357873, -1.4016245307473016},
{0.16387803034150702, 0.09338449475750803, -1.2581561539766821},
{0.16737706886705347, 0.08312477024644628, -1.1016531361841277},
{0.1723291155159456, 0.07357331803297026, -0.9381410159762527},
{0.17881012712831537, 0.06480063587965672, -0.7755816451305844},
{0.18871252204585537, 0.05540065462480301, -0.6217107611239197},
{0.19858309557863207, 0.047885320008454996, -0.5780466814482841},
{0.20850725717557417, 0.040851439132053045, -0.5442057314563038},
{0.2184916098909934, 0.03429190997425904, -0.5095544762410347},
{0.22854275677920124, 0.02819963051373483, -0.47422588286158485},
{0.23866730089450935, 0.022567498729142304, -0.43836874641219126},
{0.24887184529122974, 0.017388412599143366, -0.40214511546162446},
{0.25916299302367357, 0.01265527010239985, -0.3657270051798531},
{0.26954734714615275, 0.008360969217573651, -0.32929254579978084},
{0.28003151071297894, 0.004498407923326641, -0.29302177180504363},
{0.2906220867784638, 0.0010604841983207047, -0.2570922956348134},
{0.3013256783969188, -0.001959903978782285, -0.22167512230416975},
{0.3121488886226559, -0.004569858629320447, -0.1869308459817367},
{0.32309832050998655, -0.006776481774631909, -0.153006428887277},
{0.3341805771132224, -0.008586875436054794, -0.12003270367475927},
{0.34540226148667524, -0.010008141634927229, -0.088122672091268},
{0.3567699766846567, -0.011047382392587332, -0.05737060494661894},
{0.3682903257614782, -0.011711699730373226, -0.027851889626802295},
{0.3799699117714517, -0.012008195669623035, 0.0003764728800590422},
{0.39181533776888877, -0.011943972231674888, 0.02727484682096759},
{0.40383320680810086, -0.011526131437866904, 0.052819552688129434},
{0.41603012194339983, -0.010761775309537206, 0.07700120383424625},
{0.42841268622909734, -0.009658005868023919, 0.09982290914998648},
{0.4409875027195051, -0.00822192513466516, 0.12129844312598603},
{0.4537611744689345, -0.006460635130799063, 0.1414504628496034},
{0.46674030453169746, -0.004381237877763744, 0.160308829823804},
{0.4755104621818415, -0.002821753963899582, 0.17217973376960605},
{0.4843768257892534, -0.0011261498069514134, 0.18350302466211388},
{0.4933413518144702, 0.0007034702904620577, 0.19429102720042257},
{0.5024059967180284, 0.0026650020257221276, 0.20455660420483257},
{0.511572716960465, 0.004756341096210097, 0.21431302524957552},
{0.5208434690023167, 0.006975383199307255, 0.2235738496319133},
{0.5302202093041204, 0.00932002403239491, 0.23235282293669224},
{0.5397048943264126, 0.011788159292854344, 0.24066378634174002},
{0.5492994805297302, 0.014377684678066868, 0.24852059774042923},
{0.55900592437461, 0.017086495885413767, 0.2559370637248797},
{0.5688261823215892, 0.01991248861227635, 0.2629268814690653},
{0.5837742504409171, 0.0243665898896836, 0.2695035895689224},
{0.5932865921614392, 0.027984564062868256, 0.4347791732010984},
{0.6015781342375697, 0.032607159846255854, 0.5765885377099578},
{0.6103833084762581, 0.03966066607823831, 0.7545671631057719},
{0.6176444359093182, 0.04796661441477841, 0.9198744666239391},
{0.6235634346693811, 0.05734873865510705, 1.0619813515514094},
{0.6283422228890759, 0.06763077259845504, 1.176426978478663},
{0.6321827187010335, 0.07863645004405335, 1.2633598827076806},
{0.6352868402378838, 0.09018950479113279, 1.3250122414075194},
{0.637375636974414, 0.09970760935894588, 1.3578137732694522},
{0.6392257638636656, 0.1093729767364209, 1.3769982817052862},
{0.6409406029895449, 0.119095358628764, 1.3830963851303149},
{0.642623536435959, 0.12878450674118141, 1.3761394547096706},
{0.6443779462868142, 0.13835017277887937, 1.355622992572175},
{0.6468289684375801, 0.1499961210218276, 1.3092429313238485},
{0.6497551251090196, 0.1611318493616422, 1.2367607282489148},
{0.6533583344337628, 0.17158109159755408, 1.134148225013703},
{0.6578405145444399, 0.18116758152879403, 0.9980980759194082},
{0.6634035835736812, 0.18971505295459298, 0.8292708851354187},
{0.6702494596541168, 0.1970472396741818, 0.6363863137062478},
{0.6785800609183766, 0.20298787548679137, 0.43684724825062915},
{0.688597305499091, 0.20736069419165248, 0.25014151468717905},
{0.6931216931216931, 0.2086313492544551, 0.21564170991446985},
{0.7026342805502682, 0.21050688180019758, 0.11224776243840107},
{0.7118879368631414, 0.21152179032925808, 0.033853307373305164},
{0.7208974925369223, 0.2117304813184327, -0.04368520321077529},
{0.7325561542525754, 0.21084865568332983, -0.14330087294994986},
{0.7438423782905902, 0.20875924054773168, -0.23592958302558897},
{0.7547913183732998, 0.20559119941219192, -0.3193659419891419},
{0.7654381282230364, 0.20147349577726392, -0.39225536834142005},
{0.7758179615621329, 0.1965350931435014, -0.4539877402058381},
{0.7859659721129219, 0.19090495501145777, -0.5044843300964637},
{0.7959173135977361, 0.18471204488168666, -0.5439703897191963},
{0.8057071397389082, 0.17808532625474155, -0.5727854381097637},
{0.8153706042587711, 0.17115376263117613, -0.591246413605464},
{0.824942860879657, 0.16404631751154375, -0.5995584943369616},
{0.8344590633238986, 0.15689195439639803, -0.5977622375113407},
{0.8439543653138293, 0.1498196367862925, -0.5857076001193504},
{0.853463920571781, 0.1429583281817808, -0.5630509739639198},
{0.8630228828200865, 0.1364369920834163, -0.5292785965101992},
{0.872666405781079, 0.13038459199175273, -0.4837677966709837},
{0.8824296431770906, 0.1249300914073435, -0.4259050803374176},
{0.8923477487304543, 0.12020245383074221, -0.35528256150295134},
{0.9024558761635023, 0.11633064276250239, -0.2719817349000506},
{0.9127891791985681, 0.11344362170317761, -0.176912286713252},
{0.9233828115579836, 0.11167035415332137, -0.0721004324631831},
{0.9342719269640818, 0.11113980361348724, 0.03924684386600363},
{0.9454916791391954, 0.11198093358422877, 0.1530518923534887},
{0.9541446208112875, 0.11358952600315189, 0.20952285944517168},
{0.9640323891629119, 0.1170558520491522, 0.4326859045116258},
{0.9719104396583914, 0.12151703157260331, 0.5705537232418738},
{0.979405005970548, 0.1272550809906603, 0.6914507642068526},
{0.9864648868458775, 0.1341268034842458, 0.7979178352831601},
{0.9930388810308739, 0.14198900223428215, 0.8929246766822556},
{0.9990757872720321, 0.15069848042169182, 0.9793724120145517},
{1.0045244043158472, 0.16011204122739753, 1.0599242118560337},
{1.0093335309088136, 0.1700864878323215, 1.13700800183579},
{1.0134519657974257, 0.18047862341738635, 1.2128964550397423},
{1.0168285077281785, 0.1911452511635145, 1.2898180920058615},
{1.0194119554475667, 0.20194317425162847, 1.3700795063139628},
{1.0211511077020845, 0.21272919586265077, 1.4561871954828314},
{1.0219947632382274, 0.22336011917750387, 1.5509503884644902},
{1.0218917208024896, 0.23369274737711015, 1.657519197099248},
{1.0207907791413655, 0.24358388364239222, 1.779255715009521},
{1.0180803308055721, 0.2546688566861615, 1.9496336492325035},
{1.0137707020141185, 0.2646644338216664, 2.1486839966459605},
{1.0077734170009465, 0.27332317094554076, 2.371823795318594},
{1, 0.2803976239544187, 2.566168003054508},
{0.9896122675958939, 0.28720745543713666, 2.6679032164447487},
{0.979126375381715, 0.2929385648358561, 2.743492709848579},
{0.9685471241823326, 0.2976656207453475, 2.816866480006621},
{0.9578793148226153, 0.30146329176038067, 2.8866975504793735},
{0.9471277481274332, 0.30440624647572584, 2.9518721643284436},
{0.9362972249216557, 0.3065691534861536, 3.0115425931994784},
{0.9253925460301513, 0.3080266813864336, 3.065134553549673},
{0.9144185122777896, 0.30885349877133633, 3.1123189165943232},
{0.9033799244894402, 0.3091242742356318, 3.1529626111553974},
{0.8922815834899723, 0.30891367637409045, 3.1870727854595753},
{0.8811282901042551, 0.3082963737814822, 3.2147441931238667},
{0.869924845157158, 0.3073470350525774, 3.2361151400495443},
{0.8586760494735503, 0.30614032878214603, 3.2513337338307515},
{0.8473867038783011, 0.3047509235649585, 3.2605340319135276},
{0.8360616091962799, 0.30325348799578494, 3.263820763974314},
{0.824705566252356, 0.30172269066939533, 3.2612611915626015},
{0.8133233758713984, 0.3002332001805601, 3.2528829943660766},
{0.8019198388782768, 0.2988596851240493, 3.2386775818451943},
{0.7904997560978604, 0.29767681409463315, 3.218608760025216},
{0.7790679283550185, 0.2967592556870819, 3.19262712047371},
{0.7676291564746202, 0.29618167849616556, 3.160690744171121},
{0.756188241281535, 0.29601875111665443, 3.122792673072642},
{0.7447499836006319, 0.29634514214331875, 3.0789949025492396},
{0.7333191842567808, 0.2972355201709285, 3.029467206538818},
{0.7219006440748504, 0.2987645537942541, 2.9745268910328924},
{0.7104991638797106, 0.30100691160806553, 2.9146729148151547},
{0.6991195444962299, 0.3040372622071331, 2.8506056228854644},
{0.6877665867492783, 0.307930274186227, 2.78322303161732},
{0.6764450914637248, 0.31276061614011724, 2.7135875607783184},
{0.6651598594644388, 0.31860295666357424, 2.642863593541899},
{0.6539156915762895, 0.325531964351368, 2.5722345283622587},
{0.6464447638236457, 0.33079188017021766, 2.525756760110877},
{0.6389956429536329, 0.3365900692434173, 2.4801161767221713},
{0.6278659611992945, 0.34634501151654745, 2.4355728047519185},
{0.6202875119206991, 0.3535970097334286, 2.405370385689787},
{0.6129084383284994, 0.3609507984747236, 2.3851304818452586},
{0.6057289534729122, 0.36840219861631757, 2.364803858737419},
{0.5987492704041547, 0.375947031034096, 2.344387722708119},
{0.5919696021724434, 0.38358111660394395, 2.323878885484077},
{0.5853901618279951, 0.3913002762017468, 2.3032737569797757},
{0.5790111624210265, 0.3991003307033898, 2.2825683389714895},
{0.5728328170017549, 0.4069771009847582, 2.2617582196905435},
{0.5668553386203973, 0.4149264079217376, 2.2408385693929045},
{0.5610789403271699, 0.42294407239021287, 2.2198041369731296},
{0.5555038351722899, 0.4310259152660695, 2.1986492477036363},
{0.5501302362059739, 0.4391677574251926, 2.1773678021953664},
{0.5449583564784392, 0.44736541974346766, 2.1559532766932703},
{0.5399884090399022, 0.4556147230967799, 2.134398724839683},
{0.53522060694058, 0.46391148836101465, 2.1126967810607566},
{0.5306551632306894, 0.4722515364120571, 2.0908396657555537},
{0.5241868856933872, 0.4848336218798845, 2.0577450294023407},
{0.5181751129397759, 0.49748958604488397, 2.02425345141245},
{0.5126205640143372, 0.5102053243631686, 1.9903337261212684},
{0.5075239579615531, 0.5229667322908509, 1.9559528658101462},
{0.5028860138259053, 0.5357597052840437, 1.9210762714971124},
{0.4987074506518759, 0.5485701387988604, 1.8856679511278838},
{0.4949889874839466, 0.561383928291413, 1.849690793247668},
{0.4917313433665994, 0.574186969217815, 1.8131069050702089},
{0.4889352373443158, 0.5869651570341791, 1.7758780245120473},
{0.48660138846157824, 0.5997043871966179, 1.7379660160989874},
{0.48473051576286813, 0.6123905551612445, 1.6993334605138006},
{0.4833233382926675, 0.6250095563841715, 1.659944346736394},
{0.4823805750954581, 0.6375472863215119, 1.6197648739912018},
{0.4819029452157219, 0.6499896404293786, 1.5787643677964003},
{0.48189116769794077, 0.6623225141638842, 1.536916310034273},
{0.48234596158659643, 0.6745318029811417, 1.4941994768879816},
{0.48326804592617095, 0.6866034023372638, 1.4505991705512824},
{0.484658139761146, 0.6985232076883636, 1.4061085207943662},
{0.4865169621360036, 0.7102771144905536, 1.36072982096856},
{0.48884523209522546, 0.721851018199947, 1.3144758503774878},
{0.4916436686832935, 0.7332308142726562, 1.2673711220446506},
{0.4949129909446896, 0.7444023981647946, 1.219452983107277}}