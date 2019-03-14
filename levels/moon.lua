
function loadMoonLevel()
    PATH_POINTS = MOON_PATH_POINTS

    heightAtPoint = function(x, y)
        return _heightAtPoint(x, y)
    end

    FontColor = {1, 1, 1, 1}
    WorldSize = 30
    RoadScale = 35
    RoadRadius = 1.5
    MaxClosestRoadDistance = RoadRadius + 1

    makeHeightMap()
    math.randomseed(128310)
    local numRows = 2 * WorldSize / GridSize
    for i = 0, 10 do
        addMountain(math.floor(math.random() * numRows), math.floor(math.random() * numRows), math.floor(math.random() * 7), math.random() * 0.2 + 0.05)
    end
    math.randomseed(os.time())

    updatePathPoints()
    makeJump(10)
    makeRoad(moonRoadImage)

    if CASTLE_SERVER then
        return
    end

    skybox(moonSkyboxImage)
    terrain(moonTerrainImage)
    clearItems()
    makeItems(40)
    makeItems(140)
    makeItems(230)

    FogColor = {0,0,0,1}
    FogStartDist = 5
    FogDivide = 20
end

-- generate with createpath.html
-- format is x,y,angle
MOON_PATH_POINTS = {{0.05714285714285714, 0.29411764705882354, -0.718829999621625},
{0.07006908232431157, 0.28467944840100784, -0.47335144450944666},
{0.08327719544845202, 0.27903704886090697, -0.2472280670397633},
{0.09877399452496549, 0.27649256234871283, -0.019853885151829287},
{0.11476256011227325, 0.27728269678812706, 0.14596237044880533},
{0.12920777336513062, 0.2800289530794166, 0.23787526495540257},
{0.14412411614495585, 0.28408554858514196, 0.28619697848256553},
{0.1595557448214145, 0.2888725426612046, 0.2970863041189842},
{0.17554681576417241, 0.2938099946635064, 0.2748263137281426},
{0.1897321896766611, 0.29772224345381065, 0.23129634388807774},
{0.20438883073816141, 0.3009537434860221, 0.16634781750457606},
{0.2195445458753433, 0.3031392843253732, 0.08131556462881306},
{0.23522714201487668, 0.3039136555370963, -0.02143031676051388},
{0.2514644260834316, 0.3029116466864242, -0.1378637675593699},
{0.268284205007678, 0.299768047338589, -0.26224923115996446},
{0.2857142857142857, 0.29411764705882354, -0.36717383381821933},
{0.3004919953502479, 0.28681679825020595, -0.5527636887867109},
{0.31357943429633817, 0.27757230091365553, -0.695456351792973},
{0.32516028017554044, 0.2667419590021439, -0.8170782868587967},
{0.3354182106108388, 0.2546835764686429, -0.9158478394870544},
{0.3445369032252173, 0.2417549572661244, -0.992259142268948},
{0.35270003564166025, 0.22831390534756024, -1.0475648381682339},
{0.36009128548315145, 0.21471822466592205, -1.0826762433425468},
{0.3668943303726749, 0.20132571917418177, -1.0974033571133441},
{0.3743328355978107, 0.18643526831942064, -1.0860039477547367},
{0.3815124074431427, 0.17287655183444203, -1.0357385439152016},
{0.3897747292487373, 0.15974043090248358, -0.9076089379952683},
{0.3996630596821831, 0.14898450541064842, -0.6133999337528189},
{0.413474826274907, 0.14332261809877161, 0.0043203180100694905},
{0.42857142857142855, 0.14705882352941177, 0.46364760900080615},
{0.4409449600835574, 0.15528876621947804, 0.7162725545517798},
{0.45190792993233736, 0.16623937570046773, 0.8856971352766005},
{0.46160366551132165, 0.17957082048376852, 1.0174020958704775},
{0.47017549421406385, 0.1949432690807682, 1.1173534987633422},
{0.47632006023383133, 0.20848238394388374, 1.1789858984484765},
{0.48191043901017705, 0.22293625537288522, 1.227510888317925},
{0.4870200141686008, 0.2381308896456033, 1.2652026555952833},
{0.4917221693346017, 0.25389229303986854, 1.293752147450967},
{0.496090288133679, 0.27004647183351127, 1.3143516709754506},
{0.5001977541913323, 0.2864194323043622, 1.3277700837843613},
{0.5041179511330608, 0.30283718073025184, 1.3344020652132758},
{0.5079242625843637, 0.31912572338901074, 1.3342855470669026},
{0.5116900721707407, 0.33511106655846945, 1.327082511890504},
{0.5154887635176908, 0.3506192165164585, 1.3120145396935172},
{0.5193937202507134, 0.3654761795408083, 1.2877368816646007},
{0.5245361472331279, 0.38286658313469824, 1.2410988441782265},
{0.5301026031896767, 0.39862781046527485, 1.169897852910502},
{0.5362364155139134, 0.412420030043926, 1.0629145636340995},
{0.5445477056784687, 0.42589312056980005, 0.8622109640866986},
{0.5558680727338471, 0.43662621390712714, 0.48550362059340335},
{0.5714285714285714, 0.4411764705882353, 0},
{0.5868317524303556, 0.4372331450573543, -0.5572025438773913},
{0.5992016796835344, 0.42612002849591263, -0.9365366219892479},
{0.6080631891066506, 0.4113599030886407, -1.1330184567104702},
{0.6145579431672826, 0.39554057621517885, -1.2332606321793644},
{0.6194096584817754, 0.3804706341914792, -1.285380814295562},
{0.6239260130940832, 0.36396510686369626, -1.3172029630977113},
{0.6282703731663917, 0.3462865162159128, -1.3333883922934446},
{0.6317318072164274, 0.3314754528805892, -1.3369871186755669},
{0.6352713625797011, 0.31621605434612854, -1.3331945530791764},
{0.6389726827312516, 0.300642731868381, -1.3224419600150745},
{0.6429194111461181, 0.28488989670319687, -1.3048517759599711},
{0.6471951912993391, 0.2690919601064265, -1.2802860119790371},
{0.6518836666659541, 0.25338333333392027, -1.2483767409525521},
{0.6570684807210013, 0.2378984276415283, -1.2085492238375983},
{0.6628332769395202, 0.22277165428510098, -1.1600494383906783},
{0.6692616987965494, 0.20813742452048864, -1.1019915997001677},
{0.6764373897671281, 0.1941301496035416, -1.0334470984694217},
{0.6844439933262949, 0.18088424079011003, -0.9536013308313533},
{0.693365152949089, 0.16853410933604435, -0.8620014775171678},
{0.7032845121105491, 0.15721416649719477, -0.7588921204472405},
{0.7142857142857143, 0.14705882352941177, -0.674740942223552},
{0.7270422837712017, 0.13862973251131533, -0.4329237967170476},
{0.7416342213830217, 0.13347341471210444, -0.17327211592166303},
{0.7565174019841877, 0.1323614306704995, 0.07369868215798814},
{0.7715379700281075, 0.1348939018189828, 0.2855503823374539},
{0.7850467859219301, 0.1399586354040898, 0.4412494497183477},
{0.7984301019581761, 0.1473599645777583, 0.5674639441238738},
{0.8115757574433787, 0.15680637786426782, 0.6701603615452651},
{0.8229705948395697, 0.16668438864208082, 0.7463521413026484},
{0.8340102562249347, 0.17774320046709896, 0.8118545794983176},
{0.8446159675596177, 0.18977807551275314, 0.8693823658521098},
{0.8547089548037629, 0.20258427595247425, 0.9211371863825054},
{0.8571428571428571, 0.20588235294117646, 0.9272952180016115},
{0.8653251439320329, 0.21861201373024436, 1.0702156130765141},
{0.8716635740298397, 0.2323697648216563, 1.2308736820232125},
{0.8756273841115597, 0.24709899000354363, 1.4104836486819303},
{0.8770409270599637, 0.2628982190720168, 1.5717433808250736},
{0.8763715065415004, 0.2785110270503506, 1.664766942320436},
{0.8747209830086622, 0.2943615264469442, 1.6820755097610858},
{0.8733073564158024, 0.3091807310546829, 1.6374940438142909},
{0.872794799617685, 0.32484517486163905, 1.5455677974539395},
{0.873745010323095, 0.3397286520758189, 1.4356372107649211},
{0.8766060015818475, 0.3557414070170376, 1.3124188932274397},
{0.8811203049380483, 0.37084963351069616, 1.2037700292118396},
{0.8857142857142857, 0.38235294117647056, 1.1441688336680207},
{0.8931240585217699, 0.3964373913581261, 0.9836325973357156},
{0.9019619790580129, 0.4089489055137352, 0.8617087569853313},
{0.9119214958207983, 0.4200718464176901, 0.758549785810837},
{0.9226960573079094, 0.42999057684438324, 0.6757885540486548},
{0.9358875331409542, 0.4402864000545143, 0.6053653162729089},
{0.9492843323167773, 0.44948685848211367, 0.5631502406579321},
{0.9623996624036184, 0.45788471338466497, 0.5505753376264619},
{0.974746730969717, 0.46577272601965275, 0.5722435979702254},
{0.9872924813173095, 0.4745388547480249, 0.652287234756878},
{0.9985422767941762, 0.484605963622105, 0.848775341399939},
{1.0067165413914843, 0.4980815790336553, 1.30986234054328},
{1.0069832740454303, 0.5139129015146512, 1.8651247168075697},
{1.0011319400142156, 0.5275548920910177, 2.1451011569695977},
{1, 0.5294117647058824, 2.1451011569695986},
{0.989254818570365, 0.546172676617793, 2.1691327747139857},
{0.978242286417085, 0.5626961940211842, 2.18705603350978},
{0.9669754931721692, 0.5789684894175455, 2.204936655884951},
{0.9554675284676255, 0.5949757353083651, 2.2228143252991446},
{0.9437314819354635, 0.6107041041951323, 2.2407294732975647},
{0.9317804432076925, 0.6261397685793364, 2.2587235095364147},
{0.91962750191632, 0.6412689009624659, 2.2768390682036164},
{0.9072857476933557, 0.6560776738460099, 2.2951202725283797},
{0.8947682701708084, 0.6705522597314576, 2.3136130192610116},
{0.8820881589806868, 0.6846788311202978, 2.3323652851410364},
{0.8692585037550001, 0.6984435605140196, 2.3514274574382963},
{0.8562923941257568, 0.7118326204141118, 2.370852690619751},
{0.8432029197249656, 0.7248321833220637, 2.390697291022796},
{0.8300031701846357, 0.7374284217393636, 2.411021131045702},
{0.8167062351367759, 0.7496075081675015, 2.4318880937159912},
{0.8033252042133945, 0.7613556151079656, 2.4533665474570254},
{0.7898731670465011, 0.772658915062245, 2.4755298492911253},
{0.7763632132681042, 0.783503580531829, 2.498456872392531},
{0.7628084325102127, 0.7938757840182061, 2.5222325505693446},
{0.7492219144048354, 0.8037616980228658, 2.546948427563816},
{0.7356167485839813, 0.8131474950472968, 2.5727031925733472},
{0.722006024679659, 0.8220193475929882, 2.5996031745611035},
{0.7084028323238775, 0.8303634281614287, 2.6277627560865975},
{0.6948202611486456, 0.8381659092541076, 2.657304651795155},
{0.681271400785972, 0.8454129633725138, 2.688359976585063},
{0.667769340867866, 0.8520907630181361, 2.721068003153617},
{0.6543271710263358, 0.8581854806924637, 2.7555754777993027},
{0.6409579808933908, 0.8636832888969855, 2.7920353275121066},
{0.6232685420959202, 0.8700612746142854, 2.8439570557467384},
{0.6057631427353783, 0.8753207294284774, 2.900001528966318},
{0.5884728100876376, 0.8794288770467948, 2.960523524674885},
{0.5714285714285714, 0.8823529411764706, 3.0090411212931185},
{0.5571814936535456, 0.8812206081571107, 3.511971709079985},
{0.5437055266081489, 0.8726297424382098, 3.966778991706987},
{0.5343288479539299, 0.8595683635797882, 4.239789918049114},
{0.5280565997795559, 0.8448500714341715, 4.400984323859917},
{0.5240567188089787, 0.8304609149386593, 4.502278337513264},
{0.5211581508198315, 0.8144319424771254, 4.584014502132914},
{0.5193476444810095, 0.7970359797412238, 4.652726514523222},
{0.5186737389036842, 0.7823183154197493, 4.7013756485869616},
{0.5186809272491353, 0.7670400725194652, -1.536929962566831},
{0.5193624248358377, 0.7513409377944985, -1.494489312003949},
{0.520711446982266, 0.7353605979989762, -1.453379979426407},
{0.522721209006895, 0.7192387398870251, -1.4126263399761818},
{0.5253849262281993, 0.7031150502127723, -1.371314299257958},
{0.5286958139646537, 0.6871292157303448, -1.3285316459545404},
{0.5326470875347329, 0.6714209231938693, -1.2833126460684428},
{0.5372319622569117, 0.656129859357473, -1.23458182222726},
{0.5424436534496647, 0.6413957109752829, -1.181093340369693},
{0.5482753764314668, 0.6273581648014257, -1.121364750386327},
{0.5547203465207926, 0.6141569075900287, -1.053608871919956},
{0.563628601839144, 0.599044171468732, -0.9543198251721581},
{0.5714285714285714, 0.5882352941176471, -0.8850668158886101},
{0.5809536774217798, 0.5771665379091133, -0.7907735488474081},
{0.5932812113449576, 0.5651166476224541, -0.6968201506069547},
{0.6064972099030963, 0.554432481366815, -0.603468881553614},
{0.6205058235975631, 0.5451363281839541, -0.5108754092004499},
{0.6352112029297243, 0.5372504771156277, -0.41909623136263296},
{0.6505174984009465, 0.530797217203593, -0.3281036974933744},
{0.666328860512597, 0.5257988374896075, -0.2378060262102748},
{0.6825494397660421, 0.5222776270154281, -0.1480699703355608},
{0.6990833866626484, 0.5202558748228115, -0.05874427985279285},
{0.7158348517037827, 0.5197558699535155, 0.03031739282175594},
{0.7327079853908118, 0.5207999014492966, 0.1192351661276454},
{0.7496069382251025, 0.523410258351912, 0.20808407569192955},
{0.7636399712001029, 0.5267981347883578, 0.2820847932285453},
{0.7775689035267935, 0.5313021144540089, 0.3560198026414294},
{0.7913382667453169, 0.5369350960998822, 0.4298228253553693},
{0.8048925923958161, 0.5437099784769945, 0.5033902497806662},
{0.8181764120184334, 0.5516396603363626, 0.5765831327112169},
{0.8285714285714286, 0.5588235294117647, 0.6202494859828215},
{0.8422355887442727, 0.5692416250117698, 0.6627910412918266},
{0.85574628257567, 0.5802851591899041, 0.6957255322090117},
{0.8690371157356066, 0.5918999777932658, 0.7281612758156314},
{0.8820416938940702, 0.6040319266689529, 0.7605096470250393},
{0.8946936227210481, 0.6166268516640642, 0.7931697473380905},
{0.9069265078865265, 0.629630598625697, 0.8265420949768325},
{0.9186739550604929, 0.64298901340095, 0.861041811318263},
{0.9298695699129345, 0.6566479418369213, 0.8971119130239559},
{0.9404469581138382, 0.6705532297807093, 0.9352371919047382},
{0.9503397253331908, 0.6846507230794117, 0.9759589856810152},
{0.9594814772409799, 0.698886267580127, 1.0198908341773931},
{0.9678058195071919, 0.7132057091299534, 1.067734444386322},
{0.9752463578018146, 0.7275548935759889, 1.1202943348658063},
{0.9817366977948343, 0.7418796667653318, 1.1784876545893428},
{0.9872104451562383, 0.7561258745450804, 1.2433425098546305},
{0.991601205556014, 0.7702393627623324, 1.3159732336209973},
{0.9954655580288142, 0.7876120856818261, 1.4194171850148},
{0.9974043258076181, 0.8045870485911238, 1.5386898122722363},
{0.997287832466619, 0.8210584816603393, 1.6747007223978811},
{0.9949864015800102, 0.8369206150595861, 1.8263445137470262},
{0.9903703567219854, 0.852067678958978, 1.9895934153155121},
{0.9833100214667378, 0.8663939035286286, 2.1575056888691417},
{0.9714285714285714, 0.8823529411764706, 2.321725389192837},
{0.9601393976862044, 0.8943043089009032, 2.376424770883294},
{0.9484671976606858, 0.905686560084778, 2.4175147350522925},
{0.9364190528124074, 0.9165043068270299, 2.4585250471450513},
{0.9240020446017604, 0.9267621612265918, 2.4993354161102164},
{0.9112232544891364, 0.9364647353823986, 2.539829612928181},
{0.8980897639349278, 0.9456166413933849, 2.5798974735952975},
{0.884608654399525, 0.9542224913584839, 2.6194366375314067},
{0.8707870073433204, 0.9622868973766301, 2.6583539604943924},
{0.8566319042267051, 0.9698144715467582, 2.6965665653823416},
{0.8421504265100717, 0.9768098259678013, 2.734002519123049},
{0.8273496556538105, 0.9832775727386943, 2.7706011466830387},
{0.8122366731183139, 0.9892223239583712, 2.8063130121588853},
{0.7968185603639734, 0.9946486917257662, 2.8410996107960385},
{0.7811023988511799, 0.999561288139813, 2.8749328242503336},
{0.7650952700403263, 1.0039647252994466, 2.9077941947680617},
{0.7488042553918032, 1.0078636153036005, 2.939674072990531},
{0.7322364363660023, 1.0112625702512088, 2.9705706898282065},
{0.7153988944233155, 1.0141662022412061, 3.000489196404606},
{0.6982987110241342, 1.016579123372526, 3.0294407084674955},
{0.6809429676288502, 1.018505945744103, 3.0574413837581593},
{0.6633387456978548, 1.0199512814548712, 3.0845115532588276},
{0.6454931266915398, 1.020919742603765, 3.1106749204295534},
{0.6274131920702969, 1.0214159412897181, 3.1359578367356757},
{0.6091060232945174, 1.0214444896116648, 3.160388657041657},
{0.590578701824593, 1.0210099996685391, 3.183997174783749},
{0.5718383091209155, 1.0201170835592757, 3.2068141341394965},
{0.5528919266438762, 1.018770353382808, 3.2288708145549823},
{0.533746635853867, 1.016974421238071, 3.2501986818248874},
{0.5144095182112791, 1.014733899223998, 3.270829099301915},
{0.4948876551765047, 1.0120533994395238, 3.290793092609412},
{0.4751881282099348, 1.008937533983582, 3.310121161330124},
{0.45531801877196115, 1.0053909149551072, 3.328843131450606},
{0.42857142857142855, 1, 3.3469880427795613},
{0.4120830056247699, 0.9954803434213839, 3.488582674582084},
{0.3980909836121314, 0.9896128603154926, 3.6298499543719553},
{0.38424083621510485, 0.9808937479930129, 3.819526028941665},
{0.3731868231798423, 0.970461011917594, 4.012657911072202},
{0.36449329924276624, 0.9584386046963286, 4.186287704284977},
{0.35772461914029946, 0.9449504789363097, 4.32492159344799},
{0.35244513760886503, 0.9301205872446315, 4.424156828671338},
{0.34821920938488526, 0.9140728822283862, 4.48662606984903},
{0.344611189204783, 0.8969313164946676, 4.517201808793407},
{0.3417622222661129, 0.8819005160200668, 4.521678445883417},
{0.33878771717511835, 0.8662679000793992, 4.509402756476238},
{0.335435564404266, 0.8501052005054737, 4.482130272906111},
{0.3314536544260227, 0.8334841491310987, 4.441367050899746},
{0.32658987771285547, 0.8164764777890828, 4.388567669246472},
{0.320592124737231, 0.7991539183122347, 4.32532114336331},
{0.31480804184526, 0.7851173550653241, 4.2684401276019575},
{0.3080077839695983, 0.7709618984835164, 4.207154986313731},
{0.3000622710321489, 0.7567242752652095, 4.142678389268081},
{0.2908424229548147, 0.7424412121088013, 4.076288388446906},
{0.2857142857142857, 0.7352941176470589, 4.059542349283916},
{0.2742186652281004, 0.7203474827051158, 4.016355436214215},
{0.2630555940979438, 0.7068362543225162, 3.9802620935410387},
{0.25220726983545694, 0.694633367189737, 3.9433628564290775},
{0.2416558899522809, 0.6836117559972565, 3.906378935002876},
{0.2288571221533579, 0.6713023352402252, 3.8614363343353038},
{0.21645974307397128, 0.6603919441611206, 3.8199511636836565},
{0.2044289822290455, 0.6506324083272816, 3.78435988842373},
{0.19273006913350466, 0.6417755533060482, 3.7571681087574684},
{0.17908045560505673, 0.6319894363520198, 3.73884185023509},
{0.16579854993900245, 0.622716963165473, 3.738925485536768},
{0.1528242687371307, 0.6135292883267699, 3.758805419600646},
{0.14009752860123034, 0.6039975664162724, 3.797770738493351},
{0.12755824613309022, 0.5936929520143427, 3.8528770374865546},
{0.11514633793449909, 0.5821865997013425, 3.919329539370609},
{0.10485703368685069, 0.571370587743502, 3.979259689327124},
{0.09457968872588883, 0.5591740518177866, 4.039915676272795},
{0.08427953256653754, 0.5453488174915353, 4.098670035407073},
{0.07599961781024513, 0.5329491939634003, 4.143031074228654},
{0.06766504828817606, 0.5192213065124972, 4.184387123482252},
{0.05714285714285714, 0.5, 4.222431654130961},
{0.04965370363048722, 0.48494299708090366, 4.262852617072488},
{0.04293718109039164, 0.470138038501675, 4.302011134074204},
{0.0370308095363015, 0.455604178700582, 4.345969278625482},
{0.03197210898194787, 0.441360472115892, 4.395405861672622},
{0.027191709262138358, 0.4251349564802302, 4.460997620726365},
{0.023675733258390248, 0.4093605645612312, 4.536283856313907},
{0.021483761362878398, 0.3940675541011441, 4.622416397219491},
{0.02067537396777766, 0.3792861828422179, -1.5629506760764245},
{0.021522117419235768, 0.3630584986952161, -1.4366766213068938},
{0.024342747263323767, 0.3475837643869301, -1.296490541012174},
{0.029226199828885798, 0.3329071459932539, -1.1463920974422361},
{0.03626141144476593, 0.31907380959008136, -0.9926341429845733},
{0.04553731843980836, 0.3061289212533066, -0.8424062280455487},
{0.05556172325501714, 0.2955664555473677, -0.7188299996216245}}