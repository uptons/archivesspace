require 'spec_helper'

describe 'Accession model' do

  before(:each) do
    make_test_repo
  end


  it "Allows accessions to be created" do
    accession = Accession.create_from_json(JSONModel(:accession).
                                           from_hash({
                                                       "id_0" => "1234",
                                                       "id_1" => "5678",
                                                       "id_2" => "9876",
                                                       "id_3" => "5432",
                                                       "title" => "Papers of Mark Triggs",
                                                       "accession_date" => Time.now,
                                                       "content_description" => "Unintelligible letters written by Mark Triggs addressed to Santa Claus",
                                                       "condition_description" => "Most letters smeared with jam"
                                                     }),
                                           :repo_id => @repo_id)

    Accession[accession[:id]].title.should eq("Papers of Mark Triggs")
  end


  it "Enforces ID uniqueness" do
    lambda {
      2.times do
        Accession.create_from_json(JSONModel(:accession).
                                   from_hash({
                                               "id_0" => "1234",
                                               "id_1" => "5678",
                                               "id_2" => "9876",
                                               "id_3" => "5432",
                                               "title" => "Papers of Mark Triggs",
                                               "accession_date" => Time.now,
                                               "content_description" => "Unintelligible letters written by Mark Triggs addressed to Santa Claus",
                                               "condition_description" => "Most letters smeared with jam"
                                             }),
                                   :repo_id => @repo_id)
      end
    }.should raise_error(Sequel::ValidationFailed)
  end


  it "Allows long condition descriptions" do
    repo = Repository.create(:repo_code => "TESTREPO",
                             :description => "My new test repository")


    long_string = "x" * 1024

    accession = Accession.create_from_json(JSONModel(:accession).
                                           from_hash({
                                                       "id_0" => "1234",
                                                       "id_1" => "5678",
                                                       "id_2" => "9876",
                                                       "id_3" => "5432",
                                                       "title" => "Papers of Mark Triggs",
                                                       "accession_date" => Time.now,
                                                       "content_description" => "Unintelligible letters written by Mark Triggs addressed to Santa Claus",
                                                       "condition_description" => long_string
                                                     }),
                                           :repo_id => repo[:id])

    Accession[accession[:id]].condition_description.should eq(long_string)
  end


  it "Allows accessions to be created with a date" do
    accession = Accession.create_from_json(JSONModel(:accession).
                                           from_hash({
                                                       "id_0" => "1234",
                                                       "id_1" => "5678",
                                                       "id_2" => "9876",
                                                       "id_3" => "5432",
                                                       "title" => "Papers of Mark Triggs",
                                                       "accession_date" => Time.now,
                                                       "content_description" => "Unintelligible letters written by Mark Triggs addressed to Santa Claus",
                                                       "condition_description" => "Most letters smeared with jam",
                                                       "dates" => [
                                                         {
                                                            "date_type" => "single",
                                                            "label" => "creation",
                                                            "begin" => "2012-05-14",
                                                            "end" => "2012-05-14",
                                                         }
                                                       ]
                                                     }),
                                           :repo_id => @repo_id)

    Accession[accession[:id]].dates.length.should eq(1)
    Accession[accession[:id]].dates[0].begin.should eq("2012-05-14")
  end


  it "Allows accessions to be created with an external document" do
    accession = Accession.create_from_json(JSONModel(:accession).
                                           from_hash({
                                                       "id_0" => "1234",
                                                       "id_1" => "5678",
                                                       "id_2" => "9876",
                                                       "id_3" => "5432",
                                                       "title" => "Papers of Mark Triggs",
                                                       "accession_date" => Time.now,
                                                       "content_description" => "Unintelligible letters written by Mark Triggs addressed to Santa Claus",
                                                       "condition_description" => "Most letters smeared with jam",

                                                       "external_documents" => [
                                                         {
                                                           "title" => "My external document",
                                                           "location" => "http://www.foobar.com",
                                                         }
                                                       ]
                                                     }),
                                           :repo_id => @repo_id)

    Accession[accession[:id]].external_documents.length.should eq(1)
    Accession[accession[:id]].external_documents[0].title.should eq("My external document")
  end


  it "throws an error when accession created with duplicate external documents" do
    expect {

      Accession.create_from_json(JSONModel(:accession).
                                 from_hash({
                                             "id_0" => "1234",
                                             "id_1" => "5678",
                                             "id_2" => "9876",
                                             "id_3" => "5432",
                                             "title" => "Papers of Mark Triggs",
                                             "accession_date" => Time.now,
                                             "content_description" => "Unintelligible letters written by Mark Triggs addressed to Santa Claus",
                                             "condition_description" => "Most letters smeared with jam",

                                             "external_documents" => [
                                                                      {
                                                                        "title" => "My external document",
                                                                        "location" => "http://www.foobar.com",
                                                                      },
                                                                      {
                                                                        "title" => "My other document",
                                                                        "location" => "http://www.foobar.com",
                                                                      },
                                                                     ]
                                           }),
                                 :repo_id => @repo_id)

    }.should raise_error(Sequel::ValidationFailed)
  end


end