#
# Cookbook Name:: encoder
# Recipe:: default
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#

directory "/content/music/live" do
    owner "converter"
    group "converter"
    mode 00775
    recursive
    action :create
end

content_music_directory_links = {
    "/content/music/live" => "/content/music/prod",
    "/content/music/prod" => "/content/music/gen"
}

content_music_prod_links = {
    "/data/encoder/cdbaby" => "/content/music/prod/CDBABY27",
    "/data/encoder/dashgo" => "/content/music/prod/DashGo3",
    "/data/encoder/digdis" => "/content/music/prod/DigDis7",
    "/data/encoder/e1" => "/content/music/prod/E19",
    "/data/encoder/emi" => "/content/music/prod/EMI11",
    "/data/encoder/finetunes" => "/content/music/prod/Finetunes7",
    "/data/encoder/fuga" => "/content/music/prod/FUGA7",
    "/data/encoder/houseplanet" => "/content/music/prod/House_Planet",
    "/data/encoder/ingrooves" => "/content/music/prod/Ingrooves7",
    "/data/encoder/naxos" => "/content/music/prod/Naxos",
    "/data/encoder/nextplateau" => "/content/music/prod/NextPlateau",
    "/data/encoder/onerpm" => "/content/music/prod/ONErpm",
    "/data/encoder/orchard" => "/content/music/prod/Orchard15",
    "/data/encoder/rebeat" => "/content/music/prod/Rebeat7",
    "/data/encoder/sbmg" => "/content/music/prod/SBMG7",
    "/data/encoder/sundesire" => "/content/music/prod/Sundesire7",
    "/data/encoder/symphonic" => "/content/music/prod/Symphonic",
    "/data/encoder/tunecore" => "/content/music/prod/Tunecore9",
    "/data/encoder/umg" => "/content/music/prod/UMG13",
    "/data/encoder/wmg" => "/content/music/prod/WMG4",
    "/data/encoder/independent" => "/content/music/prod/independent",
    "/data/encoder/believe" => "/content/music/prod/Believe",
    "/data/encoder/alienprod" => "/content/music/prod/Alien_Prod",
    "/data/encoder/catapult" => "/content/music/prod/Catapult",
    "/data/encoder/consolidated" => "/content/music/prod/Consolidated5"
}

content_music_directory_links.each do |source,dest|
    link source do
        to dest
        link_type :symbolic
        action :create
    end
end

content_music_prod_links.each do |source,dest|
    link source do
        to dest
        link_type :symbolic
        action :create
    end
end
