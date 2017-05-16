namespace 'Users', () ->
  class @Form extends Shared.Form
    recordName: 'user'
    defaultAttributes: { email: '', password: '' }

    formInputs: () ->
      html = []
      html.push @renderInput('email', autoComplete: 'off')
      html.push @renderInput('password', type: 'password', autoComplete: 'off')
      html.concat super
