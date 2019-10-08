import React, { Component } from "react";

export class DetailsCard extends Component {
  constructor(props) {
    super(props);

    this.state = {
      details: [
        {
          key: 1,
          value: "Cumprimento de Sentença - Honorários Advocativos"
        },
        {
          key: 2,
          value:
            "TJSP - Fórum João Mendes Junior - Balneário Camboriú - 4 Vara Civel"
        },
        {
          key: 3,
          value: "Processo Judicial - Rito Ordinario"
        },
        {
          key: 4,
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
            <div className="detail_wrapper" key={detail.key}>
              <p className="detail_wrapper__value">{detail.value}</p>
            </div>
          ))}
        </div>
      </div>
    );
  }
}
