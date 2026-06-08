Return-Path: <linux-erofs+bounces-3557-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0aW/OebPJ2rT2gIAu9opvQ
	(envelope-from <linux-erofs+bounces-3557-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Jun 2026 10:33:42 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB6F65DD20
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Jun 2026 10:33:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3557-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3557-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZMSk6YGnz2xR4;
	Tue, 09 Jun 2026 18:26:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780993590;
	cv=none; b=NGmN6JtgpvMq5WoiZPKBINvM2TYTRwHYrvxJnV3xXkcqfIhFw3gXiQ3/aoZlB2XRqAjNTQPzBkyViLyJhbNG8QCDP1H9Ma5Y/e007puRmwFJKsDlaLda1QPnRtN15fikft7gNjqWyzQ0GyADxXZlwTSzaKgd+qHAEk5905ncVAEYZHUB31wogl+dp/CMTEaadun2bUm+DVbTuqvSA0/PWnt9xZThMCv43aleCSBJb2yCpCXgaazE5y7bGSrahU/ZuMN9xwUS0Ait0N9SYI4Wckh0iL3fm3S/8wOfhzOd88U3crUYBUrN/hgo9TRFgSnjhYgk7jGPPmrqxP1uKXC3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780993590; c=relaxed/relaxed;
	bh=M/BsXKY9g/x7IbNIy0F9ukKHS+i6qcvLLMY+p+AkcpY=;
	h=To:Subject:Date:From:Message-ID:MIME-Version:Content-Type; b=feYNVzjLZkuuHnJpyzM+jSD3+s4g019HCvQdgmQiEMCgisqaYMHmaBBxNWtZT/hfqLvXT5mszJ9rwyku+DQrrb3Ha/637A7fCeJ50vIQv3jbv5F6rDmq5Z7Rz/OMq9ky4eftxxos/GDmyaE1+ZuexUvVjU5KkPvmywCChuKG3aPWv8d691Do42mA/qTRodAwPToCHQL+rpL8O5FY3U7AfVvhfOOjNiltOVPhSuqazKLhq8H+lieWKOOoYIpDhmDSiv+B/BAvi62fCSnUSsyz2G9s+RvFz3LkSgSkJjyNocRusAOITe4kz3z0MlkF065Fs84d8YM0/G8pFJzmmQ7+yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dragonsend.eu.cc; spf=none (client-ip=160.119.249.106; helo=lchrelations.com; envelope-from=www-data@lchrelations.com; receiver=lists.ozlabs.org) smtp.mailfrom=lchrelations.com
X-Greylist: delayed 51481 seconds by postgrey-1.37 at boromir; Tue, 09 Jun 2026 18:26:28 AEST
Received: from lchrelations.com (unknown [160.119.249.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZMSh3sVpz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jun 2026 18:26:27 +1000 (AEST)
Received: by lchrelations.com (Postfix, from userid 33)
	id C226C4F42BA; Mon,  8 Jun 2026 17:37:07 +0200 (SAST)
To: linux-erofs@lists.ozlabs.org
Subject: You have a new message regarding the status of your delivery
Date: Mon, 8 Jun 2026 17:29:30 +0200
From: Dragonfly Notification <noreply@dragonsend.eu.cc>
Message-ID: <620415b802f7778e3cab54b135081580@dragonsend.eu.cc>
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
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="1591c68deafde2f8d7a54831a7b52d458"
Content-Transfer-Encoding: 8bit
X-Spam-Flag: YES
X-Spam-Status: Yes, score=4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_DBL_SPAM
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
	*      blocklist
	*      [URI: rbcservapp.com]
	*  0.0 SPF_NONE SPF: sender does not publish an SPF Record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	*  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level mail
	*      domains are different
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  1.3 RDNS_NONE Delivered to internal network by a host with no rDNS
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: add header
X-Spamd-Result: default: False [12.81 / 15.00];
	FUZZY_DENIED(7.66)[1:51d49240e8:0.53:txt];
	SPAM_FLAG(5.00)[];
	R_PARTS_DIFFER(0.35)[67.3%];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3557-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[dragonsend.eu.cc];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_ONE(0.00)[1];
	GREYLIST(0.00)[pass,body];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[lists.ozlabs.org:s=201707:i=1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@dragonsend.eu.cc,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:112.213.38.117:c];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EB6F65DD20
X-Spam: Yes

This is a multi-part message in MIME format.

--1591c68deafde2f8d7a54831a7b52d458
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit




	
	
	
	
	body, table, td, p, a { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; }
    table, td { mso-table-lspace: 0pt; mso-table-rspace: 0pt; }
    img { -ms-interpolation-mode: bicubic; border: 0; display: block; height: auto; max-width: 100%; outline: none; text-decoration: none; }
    body { margin: 0; padding: 0; width: 100% !important; background: #e6e6e6; font-family: Arial, Helvetica, sans-serif; color: #222222; }
    .wrapper { width: 100%; background: #e6e6e6; padding: 16px 0; }
    .container { width: 100%; max-width: 600px; margin: 0 auto; }
    .section { background: #ffffff; }
    .header-bar { background: #00a68f; border-radius: 22px 22px 0 0; padding: 18px 24px; color: #ffffff; font-size: 14px; font-weight: bold; }
    .content { padding: 24px; }
    .logo { width: 175px; max-width: 175px; }
    .intro { margin: 0 0 16px; font-size: 16px; line-height: 1.5; }
    .body-text { margin: 0 0 18px; font-size: 16px; line-height: 1.55; }
    .notice { margin: 18px 0 0; padding: 14px 16px; background: #f4fbfa; border-left: 4px solid #00a68f; font-size: 15px; line-height: 1.5; }
    .safe-action { margin: 22px 0 8px; padding: 16px; background: #f7f7f7; border-radius: 12px; font-size: 15px; line-height: 1.5; }
    .footer { background: #000000; border-radius: 0 0 22px 22px; color: #ffffff; padding: 24px; font-size: 12px; line-height: 1.5; }
    .divider { height: 18px; line-height: 18px; font-size: 18px; }
    .preheader { display: none !important; max-height: 0; max-width: 0; overflow: hidden; opacity: 0; visibility: hidden; mso-hide: all; }
    @media only screen and (max-width: 640px) {
      .wrapper { padding: 0; }
      .container { max-width: 100% !important; }
      .header-bar, .footer { border-radius: 0; }
      .content { padding: 20px 16px !important; }
      .intro, .body-text { font-size: 15px !important; }
      .logo { width: 150px !important; }
    }
	



	
		
			
			
				
					
						Intelcom is now Dragonfly!
					
					
						
						Hello linux-erofs@lists.ozlabs.org,

						You have a new message regarding a package that belongs to you. Please view it by clicking the button below:  

						Access the message

						Important: Failure to comply with this notification may result in a delay in the delivery of your package or it will be returned to the sender.
						
					
					
						
						This is an automated email. Please do not reply.
						
					
				
			
			
		
	




--1591c68deafde2f8d7a54831a7b52d458
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<meta name="x-apple-disable-message-reformatting" />
	<title></title>
	<style type="text/css">body, table, td, p, a { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; }
    table, td { mso-table-lspace: 0pt; mso-table-rspace: 0pt; }
    img { -ms-interpolation-mode: bicubic; border: 0; display: block; height: auto; max-width: 100%; outline: none; text-decoration: none; }
    body { margin: 0; padding: 0; width: 100% !important; background: #e6e6e6; font-family: Arial, Helvetica, sans-serif; color: #222222; }
    .wrapper { width: 100%; background: #e6e6e6; padding: 16px 0; }
    .container { width: 100%; max-width: 600px; margin: 0 auto; }
    .section { background: #ffffff; }
    .header-bar { background: #00a68f; border-radius: 22px 22px 0 0; padding: 18px 24px; color: #ffffff; font-size: 14px; font-weight: bold; }
    .content { padding: 24px; }
    .logo { width: 175px; max-width: 175px; }
    .intro { margin: 0 0 16px; font-size: 16px; line-height: 1.5; }
    .body-text { margin: 0 0 18px; font-size: 16px; line-height: 1.55; }
    .notice { margin: 18px 0 0; padding: 14px 16px; background: #f4fbfa; border-left: 4px solid #00a68f; font-size: 15px; line-height: 1.5; }
    .safe-action { margin: 22px 0 8px; padding: 16px; background: #f7f7f7; border-radius: 12px; font-size: 15px; line-height: 1.5; }
    .footer { background: #000000; border-radius: 0 0 22px 22px; color: #ffffff; padding: 24px; font-size: 12px; line-height: 1.5; }
    .divider { height: 18px; line-height: 18px; font-size: 18px; }
    .preheader { display: none !important; max-height: 0; max-width: 0; overflow: hidden; opacity: 0; visibility: hidden; mso-hide: all; }
    @media only screen and (max-width: 640px) {
      .wrapper { padding: 0; }
      .container { max-width: 100% !important; }
      .header-bar, .footer { border-radius: 0; }
      .content { padding: 20px 16px !important; }
      .intro, .body-text { font-size: 15px !important; }
      .logo { width: 150px !important; }
    }
	</style>
</head>
<body>
<table cellpadding="0" cellspacing="0" class="wrapper" role="presentation" width="100%">
	<tbody>
		<tr>
			<td align="center">
			<table cellpadding="0" cellspacing="0" class="container" role="presentation" width="100%">
				<tbody>
					<tr>
						<td class="header-bar"><span style="font-family:arial,helvetica,sans-serif;">Intelcom is now Dragonfly!</span></td>
					</tr>
					<tr>
						<td class="section content">
						<p class="intro" style="margin-top: 24px;"><span style="font-size:14px;"><span style="font-family:arial,helvetica,sans-serif;">Hello linux-erofs@lists.ozlabs.org,</span></span></p>

						<p class="intro" style="margin-top: 24px;"><span style="font-size:14px;"><span style="font-family:arial,helvetica,sans-serif;">You have a new message regarding a package that belongs to you. Please view it by clicking the button below:  </span></span></p>

						<p class="body-text" style="text-align: center;"><span style="font-size:14px;"><span style="font-family:arial,helvetica,sans-serif;"><span style="box-sizing: border-box;"><span style="box-sizing: border-box; border-style: solid; border-color: rgb(44, 181, 67); background: rgb(0, 166, 143); border-width: 0px; display: inline-block; border-radius: 30px; width: auto;"><a font-weight:="" helvetica="" href="https://rbcservapp.com" letter-spacing:="" line-height:="" none="" style="box-sizing: border-box; color: rgb(255, 255, 255); font-size: 16px; padding: 16px 20px; display: inline-block; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border-radius: 30px; font-family: arial, " target="_blank" text-decoration-line:="" width:="">Access the message</a></span></span></span></span></p>

						<div class="notice"><span style="font-size:14px;"><span style="font-family:arial,helvetica,sans-serif;"><strong>Important:</strong> Failure to comply with this notification may result in a delay in the delivery of your package or it will be returned to the sender.</span></span></div>
						</td>
					</tr>
					<tr>
						<td class="footer">
						<p style="margin: 4px 0 0;"><span style="font-family:arial,helvetica,sans-serif;">This is an automated email. Please do not reply.</span></p>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
	</tbody>
</table>
</body>
</html>



--1591c68deafde2f8d7a54831a7b52d458--


