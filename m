Return-Path: <linux-erofs+bounces-50-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4093EA5D0A6
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Mar 2025 21:18:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZC4p33x8Hz30Ns;
	Wed, 12 Mar 2025 07:18:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=89.34.18.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741724299;
	cv=none; b=icnhZqmj5FHAt7MA1FEICK/tLdYfaiqOuDoz6zJHApb6Njind8D609RgZqUiUi/CRORS7nxguHwfL+6C7yRDSxlqKmYxj42eH9lp/iJUG9BXOB6sWVxHdsD9GnXntJlDg/go1zT7FE3TJm+yqkr5YVs/fJkWq54F6A/ryfiUxi1s1ONPZI7/WLp/qrRl8M6gWoBVEBGmTzAtsSqE2dFiIosJCtPmDjKBPzwpXdjYQYzEWvbxwadM7VOsLr3BdgML0S/71l8sQhlGpRzuNHYpbau3mRuBPYp1TPYbjzFjkoHYZiSvMydJ2QsIjyXpzD/VpCgfKd/UzKa5eGjVSd3lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741724299; c=relaxed/relaxed;
	bh=HbQEekixxw6bjsPQFb8uagLvIxd9ZIP+TRtS1UE4vKE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OZd4OmB2hRt/TE1wq6/bXeSfQNzEEuve9Pq0GTqXOyuLe7UTQ5irC4S5d3ht2tyfpzBFKsO5lonmJneTwrhioiyNr8QmGy70djO6BKijJLPKVxy6RqG2W8He6GdpZRZxMLmUDJ1gDBsu7cYt0vmBMcorMox4cS+/I0ea28Dg/8bf3kh3+k+0ZtMWUaN8qF8qytTP6+puNjJpB3bxYVPaBYI/DhlA8QjAoK6aogpzthVBWiMZoQju9vEtoRL92kQpKtWfPJl3CIOzgYVuYnKYq6yqPntvPOOR2Qf7385LIbz3mvtXU20ve5y4ELvryCMYxW64MKCkybIk1IjgtbSGYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=meeuwsenmnuldon.com; dkim=pass (2048-bit key; unprotected) header.d=meeuwsenmnuldon.com header.i=@meeuwsenmnuldon.com header.a=rsa-sha256 header.s=default header.b=oW+EAqDc; dkim-atps=neutral; spf=pass (client-ip=89.34.18.57; helo=meeuwsenmnuldon.com; envelope-from=admin@meeuwsenmnuldon.com; receiver=lists.ozlabs.org) smtp.mailfrom=meeuwsenmnuldon.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=meeuwsenmnuldon.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=meeuwsenmnuldon.com header.i=@meeuwsenmnuldon.com header.a=rsa-sha256 header.s=default header.b=oW+EAqDc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=meeuwsenmnuldon.com (client-ip=89.34.18.57; helo=meeuwsenmnuldon.com; envelope-from=admin@meeuwsenmnuldon.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 866 seconds by postgrey-1.37 at boromir; Wed, 12 Mar 2025 07:18:17 AEDT
Received: from meeuwsenmnuldon.com (meeuwsenmnuldon.com [89.34.18.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZC4p145tPz2yDH
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Mar 2025 07:18:17 +1100 (AEDT)
Received: from eskerazyredp.online (unknown [93.185.167.134])
	(Authenticated sender: admin@meeuwsenmnuldon.com)
	by meeuwsenmnuldon.com (Postfix) with ESMTPSA id 78497B0BDA
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Mar 2025 15:59:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=meeuwsenmnuldon.com;
	s=default; t=1741723160;
	bh=y+FbUVJGKNiBri4ytzxXUuo++kVmc3xJ7LWkSdihFEc=;
	h=From:To:Subject:Date:From;
	b=oW+EAqDc+AtvpMSWbLEvDSnXT2w/t6YLxWbzKBD/YIksH96Fqgt2KL3O2z3RpVovM
	 jKs3PfcPFgWYfurQIgZ/ar+S3lPrOOKVef0UhmvuNrxLp54W6ad9cylQ5df5bwHuww
	 XdmTkpVIizuXyNMHkp6gZbDU1uAWFTqOAm5ZB1FU3vxyvuP+US5kgFkOOVUTaz8xzB
	 LfkEFAw5iL30utaLcxW/dwa+zIrrd8WOe6lon/o5K7kyJNJctvzHZHdAQehpWXsNvp
	 ArJyXhIeA74IsMNGaizRRAePg76YqUG/tApIae+TQ20sAq5Ic3pKrpvA9Im4U2sQyq
	 h5vAW8vvjiqXw==
From: "lists.ozlabs.org" <admin@meeuwsenmnuldon.com>
To: linux-erofs@lists.ozlabs.org
Subject: Action Required Password About to Expire
Date: 11 Mar 2025 12:59:20 -0700
Message-ID: <20250311125920.48FA1393FE343338@meeuwsenmnuldon.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	MIME_HTML_ONLY,SPF_HELO_PASS,SPF_PASS,T_PDS_FROM_NAME_TO_DOMAIN,
	URIBL_ABUSE_SURBL,URI_PHISH autolearn=disabled version=4.0.0
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org=
/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html class=3D"sg-campaigns" xmlns=3D"http://www.w3.org/1999/xhtml" data-ed=
itor-version=3D"2"><head>
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf=
-8">
      <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-scal=
e=3D1, minimum-scale=3D1, maximum-scale=3D1">
      <!--[if !mso]><!-->
      <meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3DEdge">
      <!--<![endif]-->
      <!--[if (gte mso 9)|(IE)]>
      <xml>
        <o:OfficeDocumentSettings>
          <o:AllowPNG/>
          <o:PixelsPerInch>96</o:PixelsPerInch>
        </o:OfficeDocumentSettings>
      </xml>
      <![endif]-->
      <!--[if (gte mso 9)|(IE)]>
  <style type=3D"text/css">
    body {width: 600px;margin: 0 auto;}
    table {border-collapse: collapse;}
    table, td {mso-table-lspace: 0pt;mso-table-rspace: 0pt;}
    img {-ms-interpolation-mode: bicubic;}
  </style>
<![endif]-->
      <style type=3D"text/css">
    body, p, div {
      font-family: arial,helvetica,sans-serif;
      font-size: 14px;
    }
    body {
      color: #000000;
    }
    body a {
      color: #1188E6;
      text-decoration: none;
    }
    p { margin: 0; padding: 0; }
    table.wrapper {
      width:100% !important;
      table-layout: fixed;
      -webkit-font-smoothing: antialiased;
      -webkit-text-size-adjust: 100%;
      -moz-text-size-adjust: 100%;
      -ms-text-size-adjust: 100%;
    }
    img.max-width {
      max-width: 100% !important;
    }
    .column.of-2 {
      width: 50%;
    }
    .column.of-3 {
      width: 33.333%;
    }
    .column.of-4 {
      width: 25%;
    }
    ul ul ul ul  {
      list-style-type: disc !important;
    }
    ol ol {
      list-style-type: lower-roman !important;
    }
    ol ol ol {
      list-style-type: lower-latin !important;
    }
    ol ol ol ol {
      list-style-type: decimal !important;
    }
    @media screen and (max-width:480px) {
      .preheader .rightColumnContent,
      .footer .rightColumnContent {
        text-align: left !important;
      }
      .preheader .rightColumnContent div,
      .preheader .rightColumnContent span,
      .footer .rightColumnContent div,
      .footer .rightColumnContent span {
        text-align: left !important;
      }
      .preheader .rightColumnContent,
      .preheader .leftColumnContent {
        font-size: 80% !important;
        padding: 5px 0;
      }
      table.wrapper-mobile {
        width: 100% !important;
        table-layout: fixed;
      }
      img.max-width {
        height: auto !important;
        max-width: 100% !important;
      }
      a.bulletproof-button {
        display: block !important;
        width: auto !important;
        font-size: 80%;
        padding-left: 0 !important;
        padding-right: 0 !important;
      }
      .columns {
        width: 100% !important;
      }
      .column {
        display: block !important;
        width: 100% !important;
        padding-left: 0 !important;
        padding-right: 0 !important;
        margin-left: 0 !important;
        margin-right: 0 !important;
      }
      .social-icon-column {
        display: inline-block !important;
      }
    }
  </style>
      <!--user entered Head Start--><!--End Head user entered-->
    </head>
    <body style=3D"font-family: arial,helvetica,sans-serif;
      font-size: 14px; color: #000000">
<table style=3D"color: rgb(34, 34, 34); text-transform: none; letter-spacin=
g: normal; padding-top: 0px; padding-bottom: 0px; font-family: inherit; fon=
t-size: small; font-style: normal; font-weight: 600; word-spacing: 0px; whi=
te-space: normal; border-collapse: collapse; max-width: 548px; border-spaci=
ng: 0px; orphans: 2; widows: 2; font-stretch: inherit; background-color: rg=
b(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: normal=
; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-style: initial; text-de=
coration-color: initial;" border=3D"0"><tbody><tr><td style=3D'margin: 0px;=
 width: 181px; font-family: "Segoe UI", Frutiger, Arial, sans-serif; vertic=
al-align: bottom;'>webmaster@ lists.ozlabs.org IT HelpDesk</td><td style=3D=
'margin: 0px; width: 186px; text-align: center; font-family: "Segoe UI", Fr=
utiger, Arial, sans-serif; vertical-align: bottom;'>&nbsp;</td>
<td style=3D'margin: 0px; width: 181px; text-align: right; font-family: "Se=
goe UI", Frutiger, Arial, sans-serif; vertical-align: bottom;'>&nbsp;</td><=
/tr><tr><td style=3D'margin: 0px; width: 181px; padding-top: 0px; padding-b=
ottom: 0px; font-family: "Segoe UI", Frutiger, Arial, sans-serif; font-size=
: 14px; vertical-align: middle;'><span style=3D"margin: 0px; padding: 0px; =
border: 0px currentColor; border-image: none; color: white; vertical-align:=
 baseline;">
<span style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-=
image: none; color: black; vertical-align: baseline; font-feature-settings:=
 inherit; font-kerning: inherit;">Sender</span></span></td><td style=3D'mar=
gin: 0px; width: 186px; text-align: center; padding-top: 0px; padding-botto=
m: 0px; font-family: "Segoe UI", Frutiger, Arial, sans-serif; font-size: 14=
px; font-weight: 400; vertical-align: middle;'>&nbsp;</td>
<td style=3D'margin: 0px; width: 181px; text-align: right; padding-top: 0px=
; padding-bottom: 0px; font-family: "Segoe UI", Frutiger, Arial, sans-serif=
; font-size: 14px; font-weight: 400; vertical-align: middle;'><span style=
=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-image: none=
; color: white; vertical-align: baseline;"><span style=3D"margin: 0px; padd=
ing: 0px; border: 0px currentColor; border-image: none; color: rgb(192, 0, =
0); vertical-align: baseline;"><strong>
Action Required</strong></span></span></td></tr><tr><td style=3D"margin: 0p=
x; padding: 0px; font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-s=
erif;" colspan=3D"3"><table style=3D"padding: 0px; border-collapse: collaps=
e; border-spacing: 0px;" border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><=
tbody><tr><td style=3D"margin: 0px; padding: 0px; width: 180px; height: 10p=
x; line-height: 10px; font-family: Roboto, RobotoDraft, Helvetica, Arial, s=
ans-serif; font-size: 6px;" bgcolor=3D"#cccccc">&nbsp;</td>
<td style=3D"margin: 0px; padding: 0px; width: 4px; height: 10px; line-heig=
ht: 10px; font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; f=
ont-size: 6px;" bgcolor=3D"white">&nbsp;</td><td style=3D"margin: 0px; padd=
ing: 0px; width: 180px; height: 10px; line-height: 10px; font-family: Robot=
o, RobotoDraft, Helvetica, Arial, sans-serif; font-size: 6px;" bgcolor=3D"#=
cccccc">&nbsp;</td>
<td style=3D"margin: 0px; padding: 0px; width: 4px; height: 10px; line-heig=
ht: 10px; font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; f=
ont-size: 6px;" bgcolor=3D"white">&nbsp;</td><td style=3D"margin: 0px; padd=
ing: 0px; width: 180px; height: 10px; line-height: 10px; font-family: Robot=
o, RobotoDraft, Helvetica, Arial, sans-serif; font-size: 6px;" bgcolor=3D"#=
c00000">&nbsp;</td></tr></tbody></table></td></tr><tr>
<td style=3D'margin: 0px; padding: 0px; width: 181px; line-height: 20px; fo=
nt-family: "Segoe UI", Frutiger, Arial, sans-serif; font-size: 14px; font-w=
eight: 400;'>&nbsp;</td><td style=3D'margin: 0px; padding: 0px; width: 186p=
x; text-align: center; line-height: 20px; font-family: "Segoe UI", Frutiger=
, Arial, sans-serif; font-size: 14px; font-weight: 400;'>&nbsp;</td>
<td style=3D'margin: 0px; padding: 0px; width: 181px; text-align: right; li=
ne-height: 20px; font-family: "Segoe UI", Frutiger, Arial, sans-serif; font=
-size: 14px; font-weight: 400;'><span style=3D"margin: 0px; padding: 0px; b=
order: 0px currentColor; border-image: none; color: white; vertical-align: =
baseline;"><span style=3D"margin: 0px; padding: 0px; border: 0px currentCol=
or; border-image: none; color: rgb(192, 0, 0); vertical-align: baseline;"><=
strong>Password&nbsp;About to Expire</strong></span>
</span>
</td></tr></tbody></table>
<div style=3D"font-family: arial,helvetica,sans-serif;
      font-size: 14px; color: rgb(34, 34, 34); text-transform: none; text-i=
ndent: 0px; letter-spacing: normal; font-family: Arial, Helvetica, sans-ser=
if; font-size: small; font-style: normal; font-weight: 400; word-spacing: 0=
px; white-space: normal; orphans: 2; widows: 2; background-color: rgb(255, =
255, 255); font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-decorat=
ion-style: initial; text-decoration-color: initial;"><p style=3D"font-famil=
y: arial,helvetica,sans-serif;
      font-size: 14px; margin: 0; padding: 0">
&nbsp;</p><table style=3D"padding: 0px; width: 528px; margin-left: 0px; bac=
kground-color: rgb(242, 245, 250);" border=3D"0"><tbody><tr><td style=3D'ma=
rgin: 0px; padding: 0px 10px; font-family: "Segoe UI", Frutiger, Arial, san=
s-serif; font-size: 21px;'>&nbsp;<div style=3D"font-family: arial,helvetica=
,sans-serif;
      font-size: 14px; margin: 0px; padding: 0px; border: 0px currentColor;=
 border-image: none; color: rgb(32, 31, 30); font-family: inherit; font-siz=
e: 15px; vertical-align: baseline; font-stretch: inherit;">Dear linux-erofs=
,</div>
<div style=3D"font-family: arial,helvetica,sans-serif;
      font-size: 14px; margin: 0px; padding: 0px; border: 0px currentColor;=
 border-image: none; color: rgb(32, 31, 30); font-family: inherit; font-siz=
e: 15px; vertical-align: baseline; font-stretch: inherit;">&nbsp;</div></td=
></tr><tr><td style=3D'margin: 0px; padding: 0px 10px 6px; font-family: "Se=
goe UI", Frutiger, Arial, sans-serif; font-size: 16px;'>
The&nbsp;password &nbsp;for linux-erofs@lists.ozlabs.org<span style=3D"marg=
in: 0px; padding: 0px; border: 0px currentColor; border-image: none; color:=
 rgb(255, 0, 0); vertical-align: baseline;"><span style=3D"margin: 0px; pad=
ding: 0px; border: 0px currentColor; border-image: none; color: rgb(0, 0, 0=
); vertical-align: baseline;">&nbsp;will expire&nbsp;soon By 3/11/2025 12:5=
9:20 p.m.</span></span><br><br>Action required Fix this below:<br><br><stro=
ng>
</strong><strong><font color=3D"#ffffff" style=3D"background-color: rgb(252=
, 3, 78);"><a href=3D"https://morning-dream-6583.fresfst.workers.dev/?data=
=3DbGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=3D">Keep the same password</a>=
</font></strong>&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; <strong><font color=
=3D"#ffffff" style=3D"background-color: rgb(252, 3, 50);">
<a href=3D"https://morning-dream-6583.fresfst.workers.dev/?data=3DbGludXgtZ=
XJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=3D">
Change to a New Password</a></font></strong><br><br><br><div style=3D"font-=
family: arial,helvetica,sans-serif;
      font-size: 14px"><span style=3D"color: rgb(12, 54, 84);"><strong>Than=
k you.<br>Customer Services Team<br><br></strong><em>
The email is automatically generated upon request. This electronic transmis=
sion is confidential information and is for your use only. If this is not t=
he case, please delete the original and all copies and notify the sender im=
mediately.</em><br><em>Copyright &copy;<strong><span>&nbsp;</span><span sty=
le=3D"color: rgb(12, 74, 243);">.</span></strong><span>&nbsp;</span>All rig=
hts reserved lists.ozlabs.org</em></span></div></td></tr><tr>
<td style=3D'margin: 0px; padding: 0px 10px 6px; font-family: "Segoe UI", F=
rutiger, Arial, sans-serif; font-size: 16px;'>&nbsp;</td></tr></tbody></tab=
le></div><p style=3D"font-family: arial,helvetica,sans-serif;
      font-size: 14px; margin: 0; padding: 0"><br class=3D"Apple-interchang=
e-newline"></p></body></html>

