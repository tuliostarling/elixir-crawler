import React from "react";

export const DetailsList = props => {
  const { details } = props;

  const detail_list = Object.entries(details).map(([key, value]) => {
    return (
      <div className="detail_wrapper" key={key}>
        <p className="detail_wrapper__value">
          {value == null ? null : `${key}: `}
          {value == null ? null : value.toString()}
        </p>
      </div>
    );
  });

  return detail_list;
};
