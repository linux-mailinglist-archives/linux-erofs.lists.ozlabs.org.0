Return-Path: <linux-erofs+bounces-748-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E753DB185A0
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 18:21:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btrmC1ccfz2yfL;
	Sat,  2 Aug 2025 02:20:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=191.252.12.28
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754065259;
	cv=none; b=PnCPOtZ+WAPCToYBefD6ZuhdMwqoT1qWCz9tGNhO8n+r4nuhplJmSffwu4xYSY3BzM96oM1U57+/duLfv17o2kJIeGp18y12r+2xW9JFZEESLEkh8DicLK4ec9DLDwr4c8dEOLFv16bw84nvKxVy1L03zsexR27SkvKQclGHfy+oA0GZWt7JJU95dkVZoKBjO+q7YSWqokiTncqKn2inE1CwWHBqmBMSg22A42JFJZvueQxOhCVWcjqFlNNKE32tvXmDDzAVxQbk5Xbm6hvvOo7zuT0SrIwmbBWreMIwOAUJaw5CIoLirBT9KQw7oNgrGOzDGbKO09MeiZksZd9VgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754065259; c=relaxed/relaxed;
	bh=E5P0aQeX/lIvFzndYuhfi4Xqm+T8F20wSPbWoIMNagQ=;
	h=Date:From:To:Subject:Mime-Version:Content-Type:Message-ID; b=YDyFM/SOSyuY1WlAE7Ge0QKiTH/iuhMFQyERBvim7MVkyCkLqkyyW+MIjKtoDJvLvEKyfBFkM5WctMdhF6ZFfvt4Jcf76+kjRchE7jd+Z6tspgfAJwq/ZShsO6lIls7SNLLOFegJd+RZ0tGtFHMfu6xNkI6E0vkICD8pcQap4FWFF6nRG4Vjt4vP9dAmC0LeSY6ORal/rhZWhLOhcSKnToQLf6O6LBMDbM3bubrw3WGqaRxuS+OqTJVeNryHl6o0E+6ZpxQpqvI+i902U8F7DKB/DPrmfV5JbprwEnv+ZZWh1vslm/iVZ5bmtqYxzsWs2m/x/fV7QHX0dn84hEepGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=rhotelcentral.emktlw-02.com; dkim=pass (1024-bit key; unprotected) header.d=emktlw-02.com header.i=@emktlw-02.com header.a=rsa-sha256 header.s=emktlw header.b=EVvct8hm; dkim-atps=neutral; spf=pass (client-ip=191.252.12.28; helo=mail1228.delibird-emkt0001.lwdlv.com.br; envelope-from=199841@rhotelcentral.emktlw-02.com; receiver=lists.ozlabs.org) smtp.mailfrom=rhotelcentral.emktlw-02.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=rhotelcentral.emktlw-02.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=emktlw-02.com header.i=@emktlw-02.com header.a=rsa-sha256 header.s=emktlw header.b=EVvct8hm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rhotelcentral.emktlw-02.com (client-ip=191.252.12.28; helo=mail1228.delibird-emkt0001.lwdlv.com.br; envelope-from=199841@rhotelcentral.emktlw-02.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 601 seconds by postgrey-1.37 at boromir; Sat, 02 Aug 2025 02:20:54 AEST
Received: from mail1228.delibird-emkt0001.lwdlv.com.br (mail1228.delibird-emkt0001.lwdlv.com.br [191.252.12.28])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btrm66hgFz2xRs
	for <linux-erofs@lists.ozlabs.org>; Sat,  2 Aug 2025 02:20:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=emktlw; d=emktlw-02.com;
 h=Date:From:Reply-To:To:Subject:Mime-Version:Content-Type:List-Unsubscribe:
 Message-ID;
 bh=E5P0aQeX/lIvFzndYuhfi4Xqm+T8F20wSPbWoIMNagQ=;
 b=EVvct8hmJd/fCFGfTeMdpeq9CeOfmK4SCReGgMU1JsvWdDXTfJICAZX14p4LSZ0LtYXwp3ZIhKdS
   bmvLt8QfHLoq5ivmPZnOTzb/Ty2BQiF93lIgRaNGkG1/Z7Ewog4dgCH2DvKMyHp5d2qYstqiAfpI
   XK5IXHPID8I4oasMEs4=
Received: from localhost (191.252.190.4) by mail1228.delibird-emkt0001.lwdlv.com.br id hhjkka2n8lg1 for <linux-erofs@lists.ozlabs.org>; Fri, 1 Aug 2025 13:10:13 -0300 (envelope-from <199841@rhotelcentral.emktlw-02.com>)
Date: Fri, 1 Aug 2025 13:10:13 -0300
From: BRT <reservas@rhotelcentral.emktlw-02.com>
Reply-To: reservas@hotelcentral-ro.com.br
To: linux-erofs@lists.ozlabs.org
Subject: brtConsolidadora
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_688ce6f2ae0e6_1d8db3ff6470da45828145aa";
 charset=UTF-8
List-Unsubscribe: <mailto:6351-7ud-2-2-041d2daf123b189cb70bdf9c80ae013661048b35@unsubscribes.mktnaweb.com>,
 <http://emailmarketing.locaweb.com.br/accounts/199841/unsubscribes/2/8141?emkt_c=1754059914&emkt_v=bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw&envelope_id=2>
Precedence: bulk
x-account-id: 199841
x-contact-id: 8141
x-envelope-id: 2
x-message-id: 2
x-locaweb-id: 7JeUCgYehpPWjLrMV5PPTVFGrjCIgH8bLwkkBZe33e3yGLd-ZpSfSuCBKDmHSeaRrpSxyI17IWKezVIYM_rWlAZlRBTJYasl8Xm2xm1EvdyXrQinkDUCjA74Sz0JZ03XSlB_Y6yTdQx6wWtgDPVMEhS1NWlrwRqFPhRhuofO1Hr9PZ6Q_Y041diZG8wcf8_y
x-locaweb-id2: NDI1MjU0MjAzYzcyNjU3MzY1NzI3NjYxNzM0MDcyNjg2Zjc0NjU2YzYzNjU2ZTc0NzI2MTZjMmU2NTZkNmI3NDZjNzcyZDMwMzIyZTYzNmY2ZDNl
Feedback-ID: 199841:2:c:emktlw
Message-ID: <0.2.0.68.1DC02FEC34ABFB2.9AFC9@mail1228.delibird-emkt0001.lwdlv.com.br>
X-Spam-Status: No, score=2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,MIME_QP_LONG_LINE,RCVD_IN_SBL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


----==_mimepart_688ce6f2ae0e6_1d8db3ff6470da45828145aa
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Voc=C3=AA recebeu um documento para an=C3=A1lise e assinatura=0D
Documento enviado atrav=C3=A9s do sistema de assinaturas do Grupo BRT=0D
ANALISAR DOCUMENTO=0D
=C2=A0=0D
Prezados,=0D
Favor rubricar e assinar o Contrato de Presta=C3=A7=C3=A3o de Servi=C3=A7=
os, nos lugares indicados.=0D
Caso haja alguma informa=C3=A7=C3=A3o divergente, por favor nos informe p=
ara corre=C3=A7=C3=A3o antes de assinar.=0D
Solicitamos que seja assinado no prazo de 5 dias para regulariza=C3=A7=C3=
=A3o/abertura do cadastro.=0D
Obrigado!=0D
Depto. de Cadastro=0D
Grupo BRT=0D
Importante Este documento possui validade jur=C3=ADdica e deve ser tratad=
o com confidencialidade.=0D
N=C3=A3o compartilhe este e-mail=0D
Este e-mail cont=C3=A9m um link seguro para documentos do Grupo BRT. N=C3=
=A3o compartilhe este e-mail, link ou c=C3=B3digo de acesso com outras pe=
ssoas.=0D
Perguntas sobre o documento?=0D
Se voc=C3=AA precisar modificar o documento ou tiver d=C3=BAvidas, entre =
em contato diretamente com o remetente.=0D
=C2=A9 2023 Grupo BRT - Todos os direitos reservados=0D
Este e-mail foi enviado pelo sistema de assinaturas eletr=C3=B4nicas do G=
rupo BRT=0D
Se voc=C3=AA n=C3=A3o deseja mais receber nossos e-mails, cancele sua ins=
cri=C3=A7=C3=A3o atrav=C3=A9s do link %{link}=

----==_mimepart_688ce6f2ae0e6_1d8db3ff6470da45828145aa
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>=0D
<html xmlns=3D"http://www.w3.org/1999/xhtml" lang=3D"pt-BR" xml:lang=3D"p=
t-BR">=0D
<head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DU=
TF-8" /><meta charset=3D"UTF-8" />=0D
	<title>Documento para Assinatura - Grupo BRT</title>=0D
	<meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-scale=3D=
1.0" />=0D
	<style type=3D"text/css">body {=0D
      font-family: Arial, Helvetica, sans-serif;=0D
      margin: 0;=0D
      padding: 0;=0D
      background-color: #f5f5f5;=0D
      color: #333;=0D
    }=0D
    .container {=0D
      max-width: 640px;=0D
      margin: 0 auto;=0D
      background-color: #ffffff;=0D
      box-shadow: 0 0 10px rgba(0,0,0,0.1);=0D
    }=0D
    .header {=0D
      padding: 30px 20px;=0D
      text-align: center;=0D
      background-color: #003366;=0D
    }=0D
    .logo {=0D
      height: 50px;=0D
    }=0D
    .content-box {=0D
      background-color: #003366;=0D
      color: #ffffff;=0D
      padding: 30px;=0D
      text-align: center;=0D
      margin: 20px;=0D
      border-radius: 4px;=0D
    }=0D
    .btn-primary {=0D
      background-color: #FFCC00;=0D
      color: #003366;=0D
      text-decoration: none;=0D
      font-weight: bold;=0D
      padding: 12px 30px;=0D
      border-radius: 4px;=0D
      display: inline-block;=0D
      margin: 20px 0;=0D
      font-size: 16px;=0D
    }=0D
    .message {=0D
      padding: 0 24px 24px 24px;=0D
      line-height: 1.5;=0D
      font-size: 15px;=0D
    }=0D
    .footer {=0D
      background-color: #f0f0f0;=0D
      padding: 30px 24px;=0D
      font-size: 12px;=0D
      color: #666;=0D
    }=0D
    .signature {=0D
      margin-bottom: 20px;=0D
      padding-bottom: 20px;=0D
      border-bottom: 1px solid #eee;=0D
    }=0D
    .signature-name {=0D
      font-weight: bold;=0D
      margin-bottom: 5px;=0D
      font-size: 15px;=0D
    }=0D
    .signature-email {=0D
      color: #0066cc;=0D
      font-size: 15px;=0D
    }=0D
    .blue-bg {=0D
      background-color: #003366;=0D
      color: white;=0D
      padding: 5px 10px;=0D
      border-radius: 3px;=0D
    }=0D
	</style>=0D
</head>=0D
<body>=0D
<div class=3D"container"><!-- Cabe=C3=A7alho com logo -->=0D
<div class=3D"header"><img alt=3D"Grupo BRT" class=3D"logo" src=3D"https:=
//grupobrt.com.br/wp-content/uploads/2023/01/brt-consolidadora-2048x276.p=
ng" /></div>=0D
<!-- Bloco principal -->=0D
=0D
<div class=3D"content-box">=0D
<h2 style=3D"font-weight: normal; margin: 0 0 10px;">Voc=C3=AA recebeu um=
 documento para an=C3=A1lise e assinatura</h2>=0D
=0D
<p style=3D"font-size: 14px; margin: 0;">Documento enviado atrav=C3=A9s d=
o sistema de assinaturas do Grupo BRT</p>=0D
<a class=3D"btn-primary" href=3D"https://emailmarketing.locaweb.com.br/ac=
counts/199841/messages/2/clicks/8141/2?envelope_id=3D2" target=3D"_blank"=
>ANALISAR DOCUMENTO</a></div>=0D
<!-- Conte=C3=BAdo -->=0D
=0D
<div class=3D"message">=0D
<div class=3D"signature">=0D
<div class=3D"signature-name">&nbsp;</div>=0D
</div>=0D
=0D
<p>Prezados,</p>=0D
=0D
<p>Favor rubricar e assinar o Contrato de Presta=C3=A7=C3=A3o de Servi=C3=
=A7os, nos lugares indicados.</p>=0D
=0D
<p>Caso haja alguma informa=C3=A7=C3=A3o divergente, por favor nos inform=
e para corre=C3=A7=C3=A3o antes de assinar.</p>=0D
=0D
<p>Solicitamos que seja assinado no prazo de 5 dias para regulariza=C3=A7=
=C3=A3o/abertura do cadastro.</p>=0D
=0D
<p>Obrigado!</p>=0D
=0D
<p>Depto. de Cadastro<br />=0D
<strong>Grupo BRT</strong></p>=0D
=0D
<p style=3D"font-size: 13px; margin-top: 30px; color: #666"><span class=3D=
"blue-bg">Importante</span> Este documento possui validade jur=C3=ADdica =
e deve ser tratado com confidencialidade.</p>=0D
</div>=0D
<!-- Rodap=C3=A9 -->=0D
=0D
<div class=3D"footer">=0D
<p><strong>N=C3=A3o compartilhe este e-mail</strong><br />=0D
Este e-mail cont=C3=A9m um link seguro para documentos do Grupo BRT. N=C3=
=A3o compartilhe este e-mail, link ou c=C3=B3digo de acesso com outras pe=
ssoas.</p>=0D
=0D
<p><strong>Perguntas sobre o documento?</strong><br />=0D
Se voc=C3=AA precisar modificar o documento ou tiver d=C3=BAvidas, entre =
em contato diretamente com o remetente.</p>=0D
=0D
<div style=3D"border-top: #ddd 1px solid; margin-top: 30px; text-align: c=
enter; padding-top: 20px;"><img alt=3D"Grupo BRT" height=3D"30" src=3D"ht=
tps://www.grupobrt.com.br/wp-content/uploads/2021/07/logo-brt.png" style=3D=
"margin-bottom: 10px;" />=0D
<p style=3D"font-size: 11px; color: #999; margin: 5px 0;">=C2=A9 2023 Gru=
po BRT - Todos os direitos reservados<br />=0D
Este e-mail foi enviado pelo sistema de assinaturas eletr=C3=B4nicas do G=
rupo BRT</p>=0D
</div>=0D
</div>=0D
</div>=0D
<div style=3D"text-align:center;"><p><span style=3D"color:#ffffff;"><span=
 style=3D"font-family:arial,helvetica,sans-serif;">Se voc=C3=AA n=C3=A3o =
deseja mais receber nossos e-mails, </span></span><span style=3D"font-fam=
ily:arial,helvetica,sans-serif;"><a href=3D"http://emailmarketing.locaweb=
.com.br/accounts/199841/unsubscribes/2/8141?emkt_c=3D1754059914&amp;emkt_v=3D=
bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw&amp;envelope_id=3D2"><span style=3D"color:#ffffff;">cancele a su=
a inscri=C3=A7=C3=A3o.</span></a></span></p></div><img src=3D"http://emai=
lmarketing.locaweb.com.br/accounts/199841/messages/2/openings/8141?envelo=
pe_id=3D2" width=3D"1" height=3D"1" border=3D"0" alt=3D"" /></body>=0D
</html>=0D

----==_mimepart_688ce6f2ae0e6_1d8db3ff6470da45828145aa--

