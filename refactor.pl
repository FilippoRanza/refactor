#! /usr/bin/perl -ni

# refactor.pl - Removes all comments and private methods from a Java source
# Copyright (C) 2017 Filippo Ranza

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


#Questo bellissimo programma(pugno nello stomaco dell'ingsw)
#rimuove tutti i commmenti e metodi superflui generati in automatico
#da Umbrello

#Esecuzione
#./refactor.pl file.java ...
#dove file.java sono i file da processare
#è fondamentale,per una corretta esecuzione rendere il file esegibile
#e non lanciarlo tramite perl refactor.pl (non verrebbero usate le corrette opzioni)

BEGIN{
	if ($#ARGV  == -1 ){

		print "USAGE:\n";
		print " ./refactor.pl java_source...\n";
		print " perl -ni refactor.pl java_souce...\n";
		print " Remove all comments,javadoc and private methods\n";
		print " from given source file.\n";
		print " \n";
		print " This tool DOES NOT produce any BACKUP.\n";
		print " \n";
		print " Use with care.\n";
		print "Made with <3 by Filippo Ranza\n";


		exit
	}
}

if( /^\s*private .+\(.*\)/ ){
	$state = 1;
}
elsif( /\}/ and $state == 1 ){
	$state = 2;
}

if(/^\s*\// or /^\s*\*/){
	$prev = $state;
	$state = 4;
}

print unless $state;

$state = 0 if($state == 2);
$state = $prev if($state == 4);
