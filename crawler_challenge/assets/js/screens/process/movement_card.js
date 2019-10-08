import React, { Component } from "react";

export class MovementCard extends Component {
  constructor(props) {
    super(props);

    this.state = {
      movements: [
        {
          key: 1,
          date: "11/06/2018",
          move:
            "Suspensão ao Prazo Prazo referente ao usuário foi alterado para 18/07/2018 devido à alteração da tabela de feriados."
        },
        {
          key: 2,
          date: "11/06/2018",
          move:
            "Suspensão ao Prazo Prazo referente ao usuário foi alterado para 18/07/2018 devido à alteração da tabela de feriados."
        },
        {
          key: 3,
          date: "11/06/2018",
          move:
            "Suspensão ao Prazo Prazo referente ao usuário foi alterado para 18/07/2018 devido à alteração da tabela de feriados."
        },
        {
          key: 4,
          date: "07/05/2018",
          move:
            "Certidão de Públicação Expedida Relacão :0109/2018 data de disponibilização: 07/05/2018 Data da publicação: 08/05/2018 Número do diário: 2569 Página: 2488/2503"
        },
        {
          key: 5,
          date: "07/05/2018",
          move:
            "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        }
      ]
    };
  }

  render() {
    const { movements } = this.state;

    return (
      <div className="card">
        <div className="card-content movements_content">
          <span className="card-title">Movimentações</span>

          {movements.map(movement => (
            <div className="movement_wrapper" key={movement.key}>
              <p className="movement_wrapper__date">{movement.date}</p>
              <span className="movement_wrapper__move">{movement.move}</span>
            </div>
          ))}
        </div>
      </div>
    );
  }
}
