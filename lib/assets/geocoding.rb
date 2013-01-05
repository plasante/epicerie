require 'geocoder'
results_1 = Geocoder.search("2595 chemin ste-marie, Mascouche, Quebec")
results_2 = Geocoder.search("93 rue juneau, Repentigny, Quebec")
p results_1[:data]
p "****************************"
p results_2.location