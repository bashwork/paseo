require 'couchrest'

module Paseo
  class DB

    #
    # Initialize the database handle to the
    # specified |host| and |name|
    #
    def initialize(host='http://localhost:5984', name='example')
      @couch    = CouchRest.new(host)
      @database = @couch.database(name)
    end

    #
    # Attempt to find the requested seo data
    # represented by the given |url|.
    #
    def find(url)
      @database.get(url) rescue nil
    end

    #
    # Update or store the |seo| document in the
    # datastore.
    #
    def store(seo)
      @database.store(seo.update('_id' => seo[:url])
    end

    #
    # Return a list of the |count| most recent
    # seo documents.
    #
    def list(count)
      @database.documents['rows'].map {|doc| doc['id'] }
    end

  end
end
