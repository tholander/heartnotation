import * as a from './api';

export const API_URL = process.env.REACT_APP_API
  ? process.env.REACT_APP_API
  : '';

export const api = a;
