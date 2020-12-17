Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF182DD07D
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Dec 2020 12:38:33 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CxVPL2LpGzDqSV
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Dec 2020 22:38:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mandrillapp.com (client-ip=198.2.136.3;
 helo=mail136-3.atl41.mandrillapp.com;
 envelope-from=bounce-md_14313403.5fdb3f98.v1-92cc2071699e4a4e85eebe31230d7ada@mandrillapp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=travis-ci.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=travis-ci.com header.i=support@travis-ci.com
 header.a=rsa-sha256 header.s=mandrill header.b=FpZPQKaH; 
 dkim=pass (1024-bit key;
 unprotected) header.d=mandrillapp.com header.i=@mandrillapp.com
 header.a=rsa-sha256 header.s=mandrill header.b=qoA8xg3n; 
 dkim-atps=neutral
X-Greylist: delayed 907 seconds by postgrey-1.36 at bilbo;
 Thu, 17 Dec 2020 22:38:17 AEDT
Received: from mail136-3.atl41.mandrillapp.com
 (mail136-3.atl41.mandrillapp.com [198.2.136.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CxVP50pjfzDqSd
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Dec 2020 22:38:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill;
 d=travis-ci.com; 
 h=From:Subject:Reply-To:To:Message-Id:Date:MIME-Version:Content-Type;
 i=support@travis-ci.com; 
 bh=HRmNFprQDjfTf7GYVrQGn6cKwj+I6a3XsnQx/rSXkdM=;
 b=FpZPQKaHXncnPN0QGOvR9y/LSY9TziWlSUP/Kxy+S/cMR4+vRVOQrOT2RdkRTqL4DDoBkYyLzyXS
 S+ccbsEx78UivzNoWGj6rxpC4NQR5kqZ/TDZ/tuT2aNUTad7bDsEupqpwHLUbUbdy30358hX/fZa
 h0twx51wYMWzFm49jng=
Received: from pmta04.mandrill.prod.atl01.rsglab.com (127.0.0.1) by
 mail136-3.atl41.mandrillapp.com id hrd1ii1sb1k5 for
 <linux-erofs@lists.ozlabs.org>;
 Thu, 17 Dec 2020 11:23:05 +0000 (envelope-from
 <bounce-md_14313403.5fdb3f98.v1-92cc2071699e4a4e85eebe31230d7ada@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1608204185; h=From : 
 Subject : Reply-To : To : Message-Id : Date : MIME-Version : 
 Content-Type : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=HRmNFprQDjfTf7GYVrQGn6cKwj+I6a3XsnQx/rSXkdM=; 
 b=qoA8xg3nm/5mBzZP4dmAhiMMWicuS9rrLcvIj98HAmTNkCrIPPUSnESaQWyWLcTCkepytV
 CTgAJ4jOHDwoC6wp8WrcGUI1m2lUBF2XIX1W1sTTIPDGD6dUnspXsgplhHJ70ScaNbfouuvJ
 FSfJjV38uKOG2oCAZDH6OGw6KWqmk=
From: Travis CI <support@travis-ci.com>
Subject: Welcome to Travis CI!
Received: from [35.227.68.105] by mandrillapp.com id
 92cc2071699e4a4e85eebe31230d7ada; Thu, 17 Dec 2020 11:23:05 +0000
To: linux-erofs@lists.ozlabs.org
Message-Id: <5fdb3f98a03e1_13fcaff3c56046875b6@travis-pro-tasks-778b5d7645-t2h29.mail>
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here:
 http://mandrillapp.com/contact/abuse?id=14313403.92cc2071699e4a4e85eebe31230d7ada
X-Mandrill-User: md_14313403
Date: Thu, 17 Dec 2020 11:23:05 +0000
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="_av-L6frnaDZhDCrC_01AoZuSQ"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Reply-To: Travis CI Support <support@travis-ci.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_av-L6frnaDZhDCrC_01AoZuSQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

 <http://travis-ci.com>                  =3D  Welcome to Travis CI, erofs! =
 =3D

  You are on Free. 

  You have 10,000 credits left - these will begin counting down
automatically as soon as you run your first build. 

  You can use your credits to build on both private and open-source
repositories using Linux, macOS, and Windows OS. 

  Use the `Sign up now` button below to sign up for a bigger plan to ensure
the builds for your private repositories continue uninterrupted. 

  If you're building open-source public repositories and want to signup for
an open-source plan, please contact <mailto:support@travis-ci.com> Travis
CI. 

       You have 10,000 Credits left for building on Travis CI!

      To ensure uninterrupted service, sign up for a suitable plan before
you run out of credits.

       *Note: *You must be an *owner of the account* to sign up for a
subscription.

      SIGN UP NOW <https://travis-ci.com/organizations/erofs>      Thank
you and have a great day!

  *The Travis CI Team* <http://www.twitter.com/travisci>            Have
any questions?  We're here to help. <mailto:support@travis-ci.com>
<https://travis-ci.com>     Travis CI GmbH, Rigaer Str. 8, 10427 Berlin,
Germany | GF/CEO: Randy Jacops | Contact: contact@travis-ci.org
<mailto:contact@travis-ci.org> | Amtsgericht Charlottenburg, Berlin, HRB
140133 B | Umsatzsteuer-ID gem=C3=A4=C3=9F =C2=A727 a Umsatzsteuergesetz: D=
E282002648

--_av-L6frnaDZhDCrC_01AoZuSQ
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.=
w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns=3D"http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
    <meta http-equiv=3D"X-UA-Compatible" content=3D"ie=3Dedge">
    <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-scale=
=3D1">
    <title></title>
    <style>
      body {
        min-width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
      }

      p {
        margin: 0;
      }

      #travis-ci-email-container {
        height: 100%;
        width: 100%;
        padding: 10px;
        font-family: 'Source Sans Pro', 'Helvetica Neue', Helvetica, Arial,=
 sans-serif;
        font-size: 18px;
        line-height: 150%;
        text-align: center;
        color: #333333;
        background-color: #F4F5F9;
        background-image: url("#{Travis.config.s3.url}/Travis-Email-Backgro=
und.png");
      }

      #email-content-container {
        max-width: 500px;
        padding: 0 10px;
        background-color: #FFFFFF;
      }

      #travis-ci-logo-section {
        padding: 20px 0;
      }

      #travis-ci-logo {
        max-width: 150px;
        cursor: pointer;
      }

      #travis-ci-logo-border-section {
        background-color: #FFFFFF;
        padding-bottom: 20px;
      }

      #travis-ci-logo-border {
        width: 90%;
        border-top: 1px solid #DCDFE2;
      }

      #plan-message-section {
        padding-bottom: 40px;
      }

      #plan-message-section h1 {
        font-size: 45px;
        line-height: 1;
      }
      @media only screen and (max-width: 480px) {
        #plan-message-section h1 {
          font-size: 30px;
        }
      }

      #plan-message-github-name {
        font-size: 18px;
        color: #15B75E;
      }

      #service-interrruption-warning-section {
        padding-bottom: 10px;
      }

      #owner-of-account-note-section {
        padding: 0 20px 52px;
        color: #9EA3A8;
        font-size: 13px;
        text-align: center;
      }
      @media only screen and (max-width: 480px) {
        #owner-of-account-note-section {
          font-size: 10px;
          padding: 0 5px 52px;
        }
      }

      #sign-up-section {
        text-align: center;
        padding-bottom: 52px;
      }
      #sign-up-section a:active {
        color: #FFFFFF;
      }
      #sign-up-section a:hover {
        color: #FFFFFF;
      }
      #sign-up-section a:visited {
        color: #FFFFFF;
      }

      #sign-up-button {
        font: bold 11px Arial;
        color: #FFFFFF;
        background-color: #32D282;
        text-decoration: none;
        padding: 12px 50px;
        border-radius: 2px;
      }

      #need-more-builds-section {
        padding-bottom: 40px;
      }

      #closing-message-section {
        padding: 0 30px 20px;
      }

      #travis-ci-twitter-section {
        text-align: center;
        padding-bottom: 20px;
      }

      #travis-ci-twitter-logo {
        width: 35px;
      }

      #questions-section {
        color: #0068FF;
        font-weight: 300;
      }

      #questions-section a {
        color: #0068FF;
      }
      #questions-section a:active {
        color: #0068FF;
      }
      #questions-section a:visited {
        color: #0068FF;
      }
      #questions-section a:hover {
        color: #0068FF;
      }

      #travis-ci-footer-logo-section {
        text-align: center;
      }

      #email-footer-section {
        font-size: 10px;
        line-height: 200%;
        text-align: center;
        color: #9EA3A8;
      }
      @media only screen and (min-width: 768px) {
        #email-footer-section {
          max-width: 500px;
        }
      }

      #email-footer-section a {
        color: #9EA3A8;

      }
      #email-footer-section a:active {
        color: #9EA3A8;
      }
      #email-footer-section a:hover {
        color: #9EA3A8;
      }
      #email-footer-section a:visited {
        color: #9EA3A8;
      }

    </style>
  </head>
  <body style=3D"min-width: 100%;height: 100%;margin: 0;padding: 0;">
    <table
      id=3D"travis-ci-email-container"
      align=3D"center"
      border=3D"0"
      cellpadding=3D"0"
      cellspacing=3D"0"
      height=3D"100%"
      width=3D"100%"
      style=3D"height: 100%;width: 100%;padding: 10px;font-family: 'Source =
Sans Pro', 'Helvetica Neue', Helvetica, Arial, sans-serif;font-size: 18px;l=
ine-height: 150%;text-align: center;color: #333333;background-color: #F4F5F=
9;background-image: url(#{Travis.config.s3.url}/Travis-Email-Background.png=
);">
      <tr>
        <td align=3D"center" valign=3D"top">
          <table id=3D"email-content-container" border=3D"0" cellpadding=3D=
"0" cellspacing=3D"0" style=3D"max-width: 500px; padding: 0px 10px; backgro=
und-color: #FFFFFF;">
            <!-- Travis CI Logo Section -->
            <tr>
              <td id=3D"travis-ci-logo-section" align=3D"center" valign=3D"=
top" style=3D"padding: 20px 0px;">
                <a href=3D"http://travis-ci.com" title=3D"Travis CI" target=
=3D"_blank">
                  <img id=3D"travis-ci-logo" src=3D"https://gallery.mailchi=
mp.com/2c4f451f4059350287b951060/images/d6414c84-6c05-4793-a036-fdc7fec2e08=
8.png" alt=3D"Travis CI Logo" style=3D"max-width: 150px;">
                </a>
              </td>
            </tr>
            <!-- Travis Logo Border Section -->
            <tr>
              <td id=3D"travis-ci-logo-border-section" align=3D"center" val=
ign=3D"top" style=3D"background-color: #FFFFFF; padding-bottom: 20px;">
                <table id=3D"travis-ci-logo-border" border=3D"0" cellpaddin=
g=3D"0" cellspacing=3D"0" width=3D"100%" style=3D"width: 90%; border-top: 1=
px solid #DCDFE2;">
                  <tr>
                    <td>
                      <span></span>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
                        <!-- Welcome Message Section -->
            <tr>
              <td id=3D"plan-message-section" align=3D"center" valign=3D"to=
p" style=3D"padding-bottom: 40px;">
                <h1 id=3D"plan-message-header">
                  Welcome to Travis CI, erofs!
                </h1>
                <p id=3D"plan-message" style=3D"margin: 0px; font-size: 18p=
x; margin-bottom: 10px;">
                  You are on Free.
                </p>
                <p id=3D"plan-message" style=3D"margin: 0px; font-size: 18p=
x; margin-bottom: 10px;">
                  You have 10,000 credits left - these will begin counting =
down automatically as soon as you run your first build.
                </p>
                <p id=3D"plan-message" style=3D"margin: 0px; font-size: 18p=
x; margin-bottom: 10px;">
                  You can use your credits to build on both private and ope=
n-source repositories using Linux, macOS, and Windows OS.
                </p>
                <p id=3D"plan-message" style=3D"margin: 0px; font-size: 18p=
x; margin-bottom: 10px;">
                  Use the `Sign up now` button below to sign up for a bigge=
r plan to ensure the builds for your private repositories continue uninterr=
upted.
                </p>
                <p id=3D"plan-message" style=3D"margin: 0px; font-size: 18p=
x;">
                  If you're building open-source public repositories and wa=
nt to signup for an open-source plan, please <a href=3D"mailto:support@trav=
is-ci.com">contact</a> Travis CI.
                </p>
              </td>
            </tr>
            <!-- Builds left Section -->
            <tr>
              <td id=3D"builds-left-section" align=3D"center" valign=3D"top=
" style=3D"padding-bottom: 20px;">
                <img id=3D"build-crane-logo" src=3D"https://gallery.mailchi=
mp.com/2c4f451f4059350287b951060/images/7120d93f-1748-4517-874e-67a3c36f5eb=
f.png" alt=3D"Build Crane">
                <p id=3D"plan-builds-remaining" style=3D"margin: 0px; paddi=
ng: 10px 0px 20px 0px; font-size: 26px; font-weight: 300; line-height: 125%=
;
                          letter-spacing: normal; color: #0068FF;">You have=
 10,000 Credits left for building on Travis CI!</p>
              </td>
            </tr>

            <!-- Service Interruption Warning Section -->
            <tr>
              <td id=3D"service-interrruption-warning-section" align=3D"cen=
ter" valign=3D"top" style=3D"padding-bottom: 10px;">
                <p style=3D"margin: 0px; font-size: 18px;">To ensure uninte=
rrupted service, sign up for a suitable plan before you run out of credits.=
</p>
              </td>
            </tr>
            <!-- Owner of Account Signup Note Section -->
            <tr>
              <td id=3D"owner-of-account-note-section" style=3D"padding: 0p=
x 20px 52px 20px; color: #9EA3A8; font-size: 13px; text-align: center;">
                <p style=3D"margin: 0px;">
                  <strong>Note:
                  </strong>You must be an
                  <strong>owner of the account</strong>
                  to sign up for a subscription.</p>
              </td>
            </tr>
            <!-- Sign Up for Travis CI Section -->
            <tr>
              <td id=3D"sign-up-section" align=3D"center" valign=3D"top" st=
yle=3D"text-align: center; padding-bottom: 52px;">
                <a id=3D"sign-up-button" href=3D"https://travis-ci.com/orga=
nizations/erofs" style=3D"font: bold 11px Arial; color: #FFFFFF; background=
-color: #32D282; text-decoration: none; padding: 12px 50px; border-radius: =
2px;">SIGN UP NOW</a>
              </td>
            </tr>
            <!-- Closing Message Section -->
            <tr>
              <td id=3D"closing-message-section" align=3D"center" valign=3D=
"top" style=3D"padding: 0px 30px 20px 30px;">
                <p style=3D"margin: 0px; font-size: 18px;">Thank you and ha=
ve a great day!</p>
                <p style=3D"margin: 0px; font-size: 18px;">
                  <strong>The Travis CI Team</strong>
                </p>
              </td>
            </tr>
            <tr>
              <td id=3D"travis-ci-twitter-section" style=3D"text-align: cen=
ter; padding-bottom: 20px;">
                <a href=3D"http://www.twitter.com/travisci">
                  <img
                    id=3D"travis-ci-twitter-logo"
                    src=3D"https://ci6.googleusercontent.com/proxy/u_GkY0vP=
n3zh6k_Iocra5_P1V00M-TFRNu-P7gPciI_J5CkDABrV1urf2QfoLPirfH6tojEO6P2xe9jKJeB=
ggB6N-SRbbfN1ecrcfw=3Ds0-d-e1-ft#https://s3.amazonaws.com/travis-ci-dzone/t=
witter2x.png"
                    alt=3D"Twitter Logo"
                    style=3D"text-align: center;">
                </a>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <!-- Email Footer Section -->
      <tr>
        <td align=3D"center" valign=3D"top">
          <table id=3D"travis-ci-email-footer-container" border=3D"0" cellp=
adding=3D"20" cellspacing=3D"0" style=3D"max-width: 500px;">
            <tr>
              <td id=3D"questions-section" align=3D"center" valign=3D"top" =
style=3D"color:#0068FF; font-weight: 300;">
                <span>Have any questions?</span>
                <span>
                  <a href=3D"mailto:support@travis-ci.com" style=3D"color: =
#0068FF">We're here to help.</a>
                </span>
              </td>
            </tr>
            <tr>
              <td id=3D"travis-ci-footer-logo-section" style=3D"text-align:=
 center;">
                <a href=3D"https://travis-ci.com" title=3D"Travis CI" targe=
t=3D"_blank">
                  <img
                    src=3D"https://ci3.googleusercontent.com/proxy/4F3vZYJT=
hQv1w7W1nKjQ-gIe7Ht98nXwYqz1L2LWfB8Fuhx1dz4EflRiIfghnf8n9QgMiDIXun4qfcutU4U=
PMctwWQX2V8vW4xi0VePgsa-UKS8=3Ds0-d-e1-ft#https://s3.amazonaws.com/travis-c=
i-dzone/TravisCI-Logo-BW.png"
                    alt=3D"Travis CI Footer Logo">
                </a>
              </td>
            </tr>
            <tr>
              <td id=3D"email-footer-section" style=3D"color: #9EA3A8; font=
-size: 10px; line-height: 200%; text-align: center; color: #9EA3A8; padding=
-top: 0px;">
                <p style=3D"margin: 0px;">Travis CI GmbH, Rigaer Str. 8, 10=
427 Berlin, Germany | GF/CEO: Randy Jacops |
                  <span>Contact: <a href=3D"mailto:contact@travis-ci.org" s=
tyle=3D"color: #9ea3a8;">contact@travis-ci.org</a>
                    | Amtsgericht Charlottenburg, Berlin, HRB 140133 B | Um=
satzsteuer-ID gem=C3=A4=C3=9F =C2=A727 a Umsatzsteuergesetz: DE282002648</s=
pan>
                </p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>

    <style data-ignore-inlining>@media print{ #_t { background-image: url('=
https://28cle9hp.emltrk.com/28cle9hp?p');}} div.OutlookMessageHeader {backg=
round-image:url('https://28cle9hp.emltrk.com/28cle9hp?f')} table.moz-email-=
headers-table {background-image:url('https://28cle9hp.emltrk.com/28cle9hp?f=
')} blockquote #_t {background-image:url('https://28cle9hp.emltrk.com/28cle=
9hp?f')} #MailContainerBody #_t {background-image:url('https://28cle9hp.eml=
trk.com/28cle9hp?f')}</style><div id=3D"_t"></div>
    <img src=3D"https://28cle9hp.emltrk.com/28cle9hp" width=3D"1" height=3D=
"1" border=3D"0" alt=3D"" />
  </body>
</html>


--_av-L6frnaDZhDCrC_01AoZuSQ--

