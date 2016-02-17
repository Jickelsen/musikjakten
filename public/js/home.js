new Vue({
	el: '#hello',

	data:{
		logs:[
			{music_data: 'test',
			name: 'test'}
			],
	},

	// computed:{
		
	// },

	ready: function(){
		this.fetchLogs();
	},

	methods: {
		fetchLogs: function(){
			this.$http.get('/json/logs', function(logs){
				// this.$set('logs', logs);
				this.logs = logs;
			});

			for(var i=0;i<10;i++) {
			    genome[i]=Math.random();
			}
		},
		newGenome: function(){
			for(var i=0;i<10;i++) {
			    genome[i]=Math.random();
			}
		},
	}
})