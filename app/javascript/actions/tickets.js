import {
  fetchCollection, fetchRecord, createRecord, updateRecord, deleteRecord
} from 'redux-crud-store/es'

const MODEL = 'tickets'
const PATH = '/tickets'

export function fetchTickets(params = {}) {
  return fetchCollection(MODEL, PATH, params)
}

export function fetchTicket(id, params = {}) {
  return fetchRecord(MODEL, id, `${PATH}/${id}`, params)
}

export function createTicket(data = {}) {
  return createRecord(MODEL, PATH, data)
}

export function updateTicket(id, data = {}) {
  return updateRecord(MODEL, id, `${PATH}/${id}`, data)
}

export function deleteTicket(id) {
  return deleteRecord(MODEL, id, `${PATH}/${id}`)
}
