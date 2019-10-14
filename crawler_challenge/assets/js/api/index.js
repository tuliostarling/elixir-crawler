const request = async (path, method, params = {}) => {
  const response = await fetch(path, {
    method,
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    },
    credentials: 'same-origin',
    ...params,
  });

  if (!response.ok) {
    const errors = await response.json();
    throw errors;
  } else if (response.redirected) {
    return { redirect_to: response.url };
  }

  return response.json();
};

export default {
  get(path) {
    return request(path, 'GET');
  },

  post(path, body) {
    return request(path, 'POST', { body: JSON.stringify(body) });
  },

  put(path, body) {
    return request(path, 'PATCH', { body: JSON.stringify(body) });
  },

  delete(path) {
    return request(path, 'DELETE');
  },
};
