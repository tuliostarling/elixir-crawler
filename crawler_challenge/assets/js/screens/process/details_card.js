import React from "react";

import { DetailsList } from "./details_list";

export const DetailsCard = props => {
  const { details } = props;

  return (
    <div className="card">
      <div className="card-content details_content">
        <span className="card-title">Detalhes do processo</span>
        {details.map(detail => (
          <DetailsList key={detail.id} details={detail} />
        ))}
      </div>
    </div>
  );
};
