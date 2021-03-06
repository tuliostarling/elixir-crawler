import React from 'react';

import PropType from 'prop-types';

export const MovementCard = (props) => {
  const { movements } = props;

  return (
    <div className="card">
      <div className="card-content movements_content">
        <span className="card-title">Movimentações</span>

        {movements.map((movement) => (
          <div className="movement_wrapper" key={movement.id}>
            <p className="movement_wrapper__date">{movement.movement_date}</p>
            <span className="movement_wrapper__move">{movement.movement}</span>
          </div>
        ))}
      </div>
    </div>
  );
};

MovementCard.propTypes = {
  movements: PropType.arrayOf(
    PropType.shape({
      id: PropType.number.isRequired,
      process_id: PropType.number.isRequired,
      movement: PropType.string.isRequired,
      movement_date: PropType.string.isRequired,
    }),
  ).isRequired,
};
