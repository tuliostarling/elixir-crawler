import React, { Fragment } from "react";

export const RelatedPartiesCard = props => {
  const { parties } = props;
  return (
    <div className="card">
      <div className="card-content related_content">
        <span className="card-title">Partes envolvidas</span>

        {parties.map(partie => (
          <Fragment key={partie.id}>
            <div className="related_wrapper">
              <p className="related_wrapper__name">{partie.name}</p>
              <span className="related_wrapper__part">{partie.partie}</span>
            </div>
            <div className="related_wrapper">
              <p className="related_wrapper__name">
                {partie.person_name_position}
              </p>
              <span className="related_wrapper__part">{partie.position}</span>
            </div>
          </Fragment>
        ))}
      </div>
    </div>
  );
};
