s.boot;
~classes = [2,2,4,2,4,   4];   //  define the possible classes for the compaction process

//     algorithmic system  16 beat-pattern
(
var init, text1, random, set, play, evaluate, save, parameters, compress, data, text2, par1, par2, par3, par4, par5, set1, text3, printRules, bag, text4, selectRule, ruleNumber, playRule;

w = Window.new("exploring-parameters of a simple model of garage", 500, 1050, resizable: true).front;


init = Button(w,Rect(10,10,90,30));
init.states = [["initialize",Color.white,Color.black]];
init.action = {'initializated!'.postln; ~data = []};

text1 = StaticText.new(w,Rect(10,40,150,50)).string_("random-setting");

random = Button(w,Rect(10,80,180,30));
random.states = [["generate-random-pattern", Color.black]];
random.action = {
	// generate a random pattern
	~p1 = [1,4].choose;
	~p2 = [1,4].choose;
	~p3 = [1,2,3,4].choose;
	~p4 = [2,4].choose;
	~p5 = [1,2,3,4].choose;
	// p6 is the user evaluation
	[~p1,~p2, ~p3, ~p4, ~p5].post
};

set = Button(w,Rect(10,120,180,30));
set.states = [["set-pattern",Color.black]];
set.action = {
	~waits = [0.32, 0.18, 0.33, 0.17,0.32, 0.18, 0.33, 0.17,0.32, 0.18, 0.33, 0.17,0.32, 0.18, 0.33, 0.17];
	~pieza =  [~p1,   4,   3,   ~p2,   2,   4,   3,   ~p3,     4,   ~p4,   3,   4,       2,   4,   3,   ~p5];
	Tdef(\beat,{
		var contador = -1;
		inf.do{
			contador = contador + 1;
			//contador.postln;
			switch(~pieza[contador%~pieza.size], 4,{},1,{Synth(\bombo)},2,{Synth(\snare)},3,{Synth(\hihat)});
			(~waits[contador%16]).wait
		};
	});
};


text3 = StaticText.new(w,Rect(20,155,450,20)).string_("-------------------------------------------------------------------");


play = Button(w,Rect(150,10,330,30));
play.states = [["play",Color.black],["stop",Color.black]];
play.action = {|value| if(value.value == 1,{Tdef(\beat).play},{Tdef(\beat).stop})};

StaticText.new(w,Rect(10,160,150,50)).string_("evaluate");
evaluate = NumberBox(w,Rect(15,195,40,30));
evaluate.action = { |num| ~p6 = num.value; 'evaluation : '.post; ~p6.postln};

save = Button(w,Rect(70,195,100,30));
save.states = [["save instance",Color.black]];
save.action = {~instance = [~p1,~p2, ~p3, ~p4, ~p5, ~p6].postln;
	~data = ~data.add(~instance)};

parameters = Button(w,Rect(185,195,100,30));
parameters.states = [["parameters",Color.black]];
parameters.action = {[~p1,~p2, ~p3, ~p4, ~p5, ~p6].postln};

data = Button(w,Rect(300,195,100,30));
data.states = [["data",Color.black]];
data.action = {
	var flag;
	'data'.postln;
	~uniqueData = List[];
	~data.do{|x|
		flag = ~uniqueData.indexOfEqual(x);
		if(flag == nil,{~uniqueData.add(x)})
	};
	~uniqueData.postln};

compress = Button(w,Rect(10,250,300,20));
compress.states = [["rule extraction",Color.red]];
compress.action = {'start compressing ...'.postln;
	~rules_basic_strict_compaction = ~compress.value(~data,~classes);'instances compressed!'.post};


// manual setting of the parameters
text2 = StaticText.new(w,Rect(250,40,150,50)).string_("manual-setting");

par1=Button(w, Rect(250,80,35,35));
par1.states=[["4", Color.white, Color.black],["1",Color.white,Color.black]];
par1.action={|val| switch(val.value,
	0, {~p1=4},
	1, {~p1=1},
)};


par2=Button(w, Rect(300,80,35,35));
par2.states=[["4", Color.white, Color.black],["1",Color.white,Color.black]];
par2.action={|val| switch(val.value,
	0, {~p2=4},
	1, {~p2=1},
)};


par3=Button(w, Rect(350,80,35,35));
par3.states=[["4", Color.white, Color.black],["1",Color.white,Color.black],["2",Color.white,Color.black],["3",Color.white,Color.black]];
par3.action={|val| switch(val.value,
	0, {~p3=4},
	1, {~p3=1},
	2, {~p3=2},
	3, {~p3=3})};


par4=Button(w, Rect(400,80,35,35));
par4.states=[["4", Color.white, Color.black],["2",Color.white,Color.black]];
par4.action={|val| switch(val.value,
	0, {~p4=4},
	1, {~p4=2},
)};

par5=Button(w, Rect(450,80,35,35));
par5.states=[["4", Color.white, Color.black],["1",Color.white,Color.black],["2",Color.white,Color.black],["3",Color.white,Color.black]];
par5.action={|val| switch(val.value,
	0, {~p5=4},
	1, {~p5=1},
	2, {~p5=2},
	3, {~p5=3})};

set1 = Button(w,Rect(250,120,100,30));
set1.states = [["set-pattern", Color.black]];
set1.action = {
	~pieza =  [~p1.value,   4,   3,   ~p2,   2,   4,   3,   ~p3,     4,   ~p4,   3,   4,       2,   4,   3,   ~p5.value];
	[~p1,~p2, ~p3, ~p4, ~p5].postln
};


printRules = Button(w,Rect(10, 280,300,20));
printRules.states = [["print rules", Color.blue]];
printRules.action = {
	var flag;
	~rules = List[];
	~rules_basic_strict_compaction.do{|x|
		flag = ~rules.indexOfEqual(x);
		if( flag == nil,{~rules.add(x)})
	};
	~rules.do{|x| x.postln}};

bag = Button(w,Rect(10,310,300,20));
bag.states = [["bag of rules",Color.cyan]];
bag.action = {
	var flag, flag1;
	~bag = [];
	~rules.do{|x|
		x.do{|y|
			flag = y.indexOfEqual(-1);
			if(flag != nil, {~bag = ~bag.add(y)})
		}
	};
	~bagOfRules = [];
	~bag.do{|x|
		flag1 = ~bagOfRules.indexOfEqual(x);
		if(flag1 == nil,{~bagOfRules = ~bagOfRules.add(x)})
	};
	~bagOfRules.postln;
};

text4 = StaticText.new(w,Rect(20,340,450,20)).string_("-------------------------------------------------------------------");


selectRule = StaticText.new(w,Rect(10,365,450,20)).string_("select rule");
selectRule = NumberBox(w,Rect(15,385,40,30));
selectRule.action = { |num| ruleNumber = num.value; 'rule number : '.post; ruleNumber.postln};

playRule = Button(w,Rect(70,385,100,30));
playRule.states = [["play rule"]];
playRule.action = {
	var rule;
	rule = ~getRule.value(ruleNumber);
	~p1 = rule[0];
	~p2 = rule[1];
	~p3 = rule[2];
	~p4 = rule[3];
	~p5 = rule[4];
	[~p1,~p2,~p3,~p4,~p5].postln;
	~pieza =  [~p1,   4,   3,   ~p2,   2,   4,   3,   ~p3,     4,   ~p4,   3,   4,       2,   4,   3,   ~p5];
};
//functions
(
~compress = { |data, classes|
	var sets, collection, compactionOrders, size;

	size = classes.size;
	sets = [];
	collection = (0 .. size - 2); // last item is always classifier
	compactionOrders = (collection.size.factorial).collect {|i|
		collection.permute(i)
	};

	compactionOrders.collect { |order|
		var temporalData = data.deepCopy;
		order.collect { |colToExclude|
			var section, selection, subsets;
			var newRule;
			section = (0..size-1).removing(colToExclude);
			subsets = temporalData.slice(nil, section);
			selection = temporalData.slice(nil, colToExclude);
			subsets.do {|x, i|
				var completeSet = [ ];
				var selectedClass = Set.new;
				subsets.do { |y,  j |
					if(x==y) {
						completeSet = completeSet.add(j);
						if(selection.at(j).notNil){selectedClass.add(selection.at(j))};
						if( selectedClass.size == classes[ colToExclude ],{
							newRule = temporalData[i].copy;
							if(newRule.notNil) {newRule[colToExclude] = -1;
								temporalData = temporalData.add(newRule)
							};
							completeSet.collect{ |x| temporalData[x]= nil};
						});
					}
				};
			};
		};
		sets = sets.add(temporalData);
	};
	sets = sets.collect({ |x| x.reject(_.isNil) });
	sets
}
);

(
~getRule = { | ruleNumber = 0 |
	var rule, parametersValues;
	parametersValues = [[1,4],[1,4],[1,2,3,4],[2,4],[1,2,3,4]];
	rule = ~bagOfRules[ruleNumber%~bagOfRules.size].deepCopy;
	rule.do{|x, i| if(x == -1,{
		rule[i]=parametersValues[i].choose
	})}
}
);
/* ************************************ Time ***********************************  */
~bpm = 140;
TempoClock.default.tempo_(~bpm/60);
/* ************************************ SynthDefs ***********************************  */
 (
SynthDef(\bombo,{|out=0,gate=1,frequency=100,mul=0.2,amp=0.6|
var sen, env, kik;
sen=Mix(SinOsc.ar(XLine.kr(MouseX.kr(60,61)*[1,1.05,1.1],60,0.13),mul,amp))!2;
kik=EnvGen.ar(Env.new([1,0],[0.01]))/6;
env =EnvGen.kr(Env.perc(0,0.27),gate,doneAction:2);
Out.ar(out,(sen+(kik*amp))*env)
}).add;
SynthDef(\snare,{|amp=1,gate=1,frecuencia=108|
    var sen, env, ruido;
   ruido=LPF.ar(WhiteNoise.ar(0.9),XLine.kr(5000,500,0.9),amp);
       sen=Pan2.ar(SinOsc.ar(frecuencia,0,0.5)!2+ruido,0,amp);
          env=EnvGen.kr(Env.perc(0,0.13),gate,doneAction:2);
              Out.ar(0,sen*env)
              }).add;
SynthDef(\hihat,{|amp=0.9,gate=1|
   var sen, env;
      sen=HPF.ar(WhiteNoise.ar(amp),2000,0.2)!2;
      env=EnvGen.kr(Env.perc(0,0.13),gate,doneAction:2);
      Out.ar(0,Pan2.ar(sen*env,0,0.5))
      }).add;
)
)
