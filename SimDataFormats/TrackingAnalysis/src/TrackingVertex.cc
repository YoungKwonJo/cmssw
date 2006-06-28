#include "SimDataFormats/TrackingAnalysis/interface/TrackingVertex.h"

typedef edm::RefVector<edm::HepMCProduct, HepMC::GenVertex > GenVertexRefVector;
typedef edm::Ref<edm::HepMCProduct, HepMC::GenVertex >       GenVertexRef;

// Constructors

TrackingVertex::TrackingVertex() : 
    position_(HepLorentzVector(0,0,0,0)), inVolume_(false), signalSource_(0) {}

TrackingVertex::TrackingVertex(const HepLorentzVector &p, const bool inVolume, 
                               const int source,          const int  crossing) : 
    position_(p), inVolume_(inVolume), signalSource_(crossing*4+source)  {}

/// add a reference to a Track
void TrackingVertex::add( const TrackingParticleRef & r ) { tracks_.push_back( r ); }

/// add a reference to a vertex

void TrackingVertex::addG4Vertex(const SimVertexRef &ref) { 
  g4Vertices_.push_back(ref);
}

void TrackingVertex::addGenVertex(const GenVertexRef &ref){ 
  genVertices_.push_back(ref);
}
    
/// Iterators over tracks
TrackingVertex::track_iterator TrackingVertex::tracks_begin() const { return tracks_.begin(); }
TrackingVertex::track_iterator TrackingVertex::tracks_end()   const { return tracks_.end(); }

/// position 
const HepLorentzVector & TrackingVertex::position() const { return position_; }

const SimVertexRefVector TrackingVertex::g4Vertices() const {
  return  g4Vertices_;
};

const GenVertexRefVector TrackingVertex::genVertices() const {
  return  genVertices_;
};

const TrackingParticleRefVector TrackingVertex::trackingParticles() const {
  return  tracks_;
};

const bool TrackingVertex::isSignal() const { return (signalSource_%4 == 0); }; 
const int  TrackingVertex::source()   const { return (signalSource_ % 4);    }; 
const int  TrackingVertex::crossing() const { return (signalSource_ / 4);    }; 
const bool TrackingVertex::inVolume() const { return (inVolume_);            }; 
