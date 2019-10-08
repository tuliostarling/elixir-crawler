import React, { Component } from "react";

export class DetailsCard extends Component {
  constructor(props) {
    super(props);

    this.state = {
      details: [
        {
          value: "Cumprimento de Sentença - Honorários Advocativos"
        },
        {
          value:
            "TJSP - Fórum João Mendes Junior - Balneário Camboriú - 4 Vara Civel"
        },
        {
          value: "Processo Judicial - Rito Ordinario"
        },
        {
          value: "Processo julgado - 1 instância - Valor da caura R$ 1387,90"
        }
      ]
    };
  }

  render() {
    const { details } = this.state;

    return (
      <div className="card">
        <div className="card-content details_content">
          <span className="card-title">Detalhes do processo</span>

          {details.map(detail => (
            <div className="detail_wrapper">
              <p className="detail_wrapper__value">{detail.value}</p>
            </div>
          ))}
        </div>
      </div>
    );
  }
}
