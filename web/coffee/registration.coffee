recaptchaPublicKey = ""

reloadCaptcha = ->
  apiCall "GET", "/api/user/status", {}
  .done (data) ->
    console.log(data.data.enable_captcha)
    if data.data.enable_captcha
        grecaptcha.reset()
    ga('send', 'event', 'Registration', 'NewCaptcha')


setRequired = ->
    $('#user-registration-form :input').each () ->
        if not $(this).is(':checkbox')
            if not $(this).is(':radio')
                $(this).prop('required', $(this).is(":visible"))


checkEligibility = ->
    is_us = $("#country-select").val() in ["BR", ""]

submitRegistration = (e) ->
  e.preventDefault()

  registrationData = $("#user-registration-form").serializeObject()
  registrationData["ctf-emails"] = $("#checkbox-emails-existing").is(':checked')
  submitButton = "#register-button-existing"
  logType = "JoinTeam"

  apiCall "POST", "/api/user/create", registrationData
  .done (data) ->
    switch data['status']
      when 0
        $(submitButton).apiNotify(data, {position: "right"})
        ga('send', 'event', 'Registration', 'Failure', logType + "::" + data.message)
      when 1
        ga('send', 'event', 'Registration', 'Success', logType)
        document.location.href = "/team"

$ ->
  apiCall "GET", "/api/user/status", {}
  .done (data) ->
    if data.data.enable_captcha
        grecaptcha.render("captcha", { "sitekey": recaptchaPublicKey })

  $("#user-registration-form").on "submit", submitRegistration

  $("#registration-new-team-page").hide()
  $("#registration-join-team-page").hide()
  $("#registration-adviser-page").hide()

  pageTransitionSpeed = 200

  # Note that this height/auto sillyness is specific to the known height relationship
  # between these pages. If one gets longer or shorter, we need to tweek it

  $("#country-select").on "change", checkEligibility
  $("#background-select").on "change", checkEligibility

  $("#country-select").html('
        <option value="BR">Brazil</option>
        ')

  $("#team-select").html('
        <option value="team1">Team1</option>
        <option value="team2">Team2</option>
        <option value="team3">Team3</option>
        ')