class Api::V1::DocumentosController < ApplicationController
  skip_before_filter :authenticate_usuario!   # skip devise authentication
  before_filter :restrict_access              # apikey authentication (private method, below)
  respond_to :json
  # decent exposure and strong parameters block
  expose( :documentos ) { params[ :documentos ] }
  expose( :documento )

  def restrict_access
    unless Rails.env.test?
      authenticate_or_request_with_http_token do |token, options|
        if ApiKey.exists?(access_token: token)
	        @apikey = ApiKey.find_by_access_token(token);
	        #athlon
	        @cli = Cliente.find(@apikey.cliente_id)
	        @cli.has_remarketing?
	    end
      end
    end
  end

  def index
  	@docs = Documento.where("pdf_file_name is null").order("fecha_recepcion DESC");
  	respond_to do |format|
  		format.json { render :json => @docs, :only => [:id,:bastidor,:concesionario,:ficha_tecnica,:contrato,:fecha_recepcion,:observaciones]}
  	end
  end

  def show
  	if Documento.exists?(params[:id])
	  	@doc = Documento.find(params[:id])
	  	respond_to do |format|
	  		format.json { render :json => @doc, :only => [:id,:bastidor,:concesionario,:ficha_tecnica,:contrato,:fecha_recepcion,:observaciones,:upload_pdf]}
	  	end
  	else
		respond_to do |format|
       		format.json { render :json => {:message => "Documento not found"}}
		end
	end
  end

  def update
  	if Documento.exists?(params[:id])
  		@doc = Documento.find(params[:id])
	  	if @doc.pdf_file_name.nil?
		  	if params[:doc][:file]
				pdf = Tempfile.new('doc-', :encoding => 'utf-8')
				File.open(pdf, 'wb') do |f|
			  		f.write Base64.decode64(params[:doc][:file])
			 	end
			  	@doc.pdf = pdf
			end
		  	if params[:doc][:comentarios]
		  		@doc.observaciones_cliente = params[:doc][:comentarios]
		  	end
		  	if @doc.save
		  		respond_to do |format|
		       		format.json { render :json => {:message => "Success"}}
		   		end
		   	end
	    else
	    	respond_to do |format|
		       	format.json { render :json => {:message => "Ya editado"}}
	   		end
	    end
	else
		respond_to do |format|
	       	format.json { render :json => {:message => "Documento not found"}}
   		end
	end
  end
end