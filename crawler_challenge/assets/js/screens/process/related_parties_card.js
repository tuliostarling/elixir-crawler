import React, { Component } from "react";

export class RelatedPartiesCard extends Component {
  constructor(props) {
    super(props);

    this.state = {
      relations: [
        {
          name: "Nelson Wilians & Advogados associados",
          part: "Parte envolvida - Exequente"
        },
        {
          name: "Construnelli IN Works Construtora",
          part: "Parte envolvida - Apelante"
        },
        {
          name: "Rafael Sganzerla Durand",
          part: "Advogado Envolvido"
        },
        {
          name: "Wilton Luiz de Carvalho",
          part: "Advogado envolvido - OAB 002337/BA"
        }
      ]
    };
  }

  render() {
    const { relations } = this.state;

    return (
      <div className="card">
        <div className="card-content related_content">
          <span className="card-title">Partes envolvidas</span>

          {relations.map(related => (
            <div className="related_wrapper">
              <p className="related_wrapper__name">{related.name}</p>
              <span className="related_wrapper__part">{related.part}</span>
            </div>
          ))}
        </div>
      </div>
    );
  }
}
