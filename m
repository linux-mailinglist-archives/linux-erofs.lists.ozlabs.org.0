Return-Path: <linux-erofs+bounces-1299-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49177C173AB
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Oct 2025 23:50:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cx5Dz3FG3z2yG3;
	Wed, 29 Oct 2025 09:50:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=222.227.84.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761691827;
	cv=none; b=Yy9N6hajxoypx24RpIVyDPCgd8Fhl2IllEC2djZZXOiqDQhrYPrV7Lu2ZNxzFqUqGf31LSgPLAQvxiPVl0xH4h+HIFAlYH8WBxT5jngRkjpasqPHipWJGYn7SFznWJh8z89prS68Xyvou0UYm07hkwEqsC6Pym/PRhA0sNehxLjMrq8hh6LhvFaXwF1elDnC0cw5QBo2RwvucWGoQsTDdEVpgKPqf5MbgQT5H30d/tESM02BHInSrxBu5zWQX2Q6Sd6TUz2inAZrhNwKnEOv/Bzia4MnZ3VuZAjDgcKKU4gmOAHi8x7WgZh8o0N9KHsd33CkY06UFfrIHMnexJFDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761691827; c=relaxed/relaxed;
	bh=OoWJ/3MIo9IDYuyXryRkcLOxsUlMLoHXIKJqygEci1k=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=nd+m/4EiLhHt84+64Tm/6l9v2rz/HVkgLVYOchQ9UQjA4f/bFU3wq2I9r+cWdNGvsnNMKZSMRMY739MHVfeyxbNWFPqV4d2vAcA4KbgHxRx2u6AOdHGPTL0j03xthwfJclKpm+SYMqRHiyMl1RNrKAk/PUwYH/oiwsbdVyMTHxgUDokcHv2Ci/HIFSM10lc/ojnpdTbdc31mCbbUdfVVZahZOaxH5yWE3sYvDo2r0gy0GeePoLafeDSzv9h8uhnVv42m+GB0ATuMG3R1xUIHVAJ3/B/wGa40ozM6jXnSk8s0qxbuCWzNx+Ic0x2YAm5yhGpQPUqkiIETtzZP806wFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=godo-co.com; spf=pass (client-ip=222.227.84.97; helo=mta-spfb-e01.biglobe.ne.jp; envelope-from=tu.kasuga@godo-co.com; receiver=lists.ozlabs.org) smtp.helo=mta-spfb-e01.biglobe.ne.jp
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=godo-co.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mta-spfb-e01.biglobe.ne.jp (client-ip=222.227.84.97; helo=mta-spfb-e01.biglobe.ne.jp; envelope-from=tu.kasuga@godo-co.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 133 seconds by postgrey-1.37 at boromir; Wed, 29 Oct 2025 09:50:26 AEDT
Received: from mta-spfb-e01.biglobe.ne.jp (mta-spfb-e01.biglobe.ne.jp [222.227.84.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cx5Dy3j7Jz2xnk
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Oct 2025 09:50:26 +1100 (AEDT)
Received: from mta-snd-e07.biglobe.ne.jp by mta-sp-e01.biglobe.ne.jp
          with ESMTP
          id <20251028224810718.CCAY.71183.mta-snd-e07.biglobe.ne.jp@biglobe.ne.jp>
          for <linux-erofs@lists.ozlabs.org>;
          Wed, 29 Oct 2025 07:48:10 +0900
Received: from mail.biglobe.ne.jp by mta-snd-e07.biglobe.ne.jp with ESMTP
          id <20251028224810252.FCPQ.73061.mail.biglobe.ne.jp@biglobe.ne.jp>
          for <linux-erofs@lists.ozlabs.org>;
          Wed, 29 Oct 2025 07:48:10 +0900
Content-Type: text/html; charset=utf-8
From: "Admin | lists.ozlabs.org | Portal @lists.ozlabs.org Notifications
 @lists.ozlabs.org transmitted.packetflow.net.BE" <tu.kasuga@godo-co.com>
To: linux-erofs@lists.ozlabs.org
Subject: linux-erofs: Your confirmation is awaited to proceed further
Message-ID: <374967fb-1939-4898-92d1-e605e18a2628@godo-co.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Oct 2025 22:48:02 +0000
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
X-Biglobe-Sender: tu.kasuga@godo-co.com
X-Biglobe-VirusCheck: Wed, 29 Oct 2025 07:48:10 +0900
X-Spam-Flag: YES
X-Spam-Status: Yes, score=4.3 required=3.0 tests=HTML_MESSAGE,
	HTML_MIME_NO_HTML_TAG,LOCALPART_IN_SUBJECT,MIME_HTML_ONLY,
	MXG_EMAIL_FRAG,SPF_HELO_PASS,SPF_NONE,URI_DWEBIPFS,URI_IPFS,
	URI_NOVOWEL autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  0.0 SPF_NONE SPF: sender does not publish an SPF Record
	* -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
	*  0.7 LOCALPART_IN_SUBJECT Local part of To: address appears in Subject
	*  0.5 URI_NOVOWEL URI: URI hostname has long non-vowel sequence
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  0.1 MIME_HTML_ONLY BODY: Message only has text/html MIME parts
	*  0.0 MXG_EMAIL_FRAG BODY: URI with email in fragment
	*  0.6 HTML_MIME_NO_HTML_TAG HTML-only message, but there is no HTML tag
	*  2.3 URI_DWEBIPFS References Interplanetary File System PtP content via
	*      dweb.link, likely phishing
	*  0.1 URI_IPFS References Interplanetary File System PtP content, probable
	*       phishing
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"content-type" =
/>
<meta charset=3D"UTF-8" />
<style type=3D"text/css">body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      color: #333333;
      background-color: #ffffff;
      padding: 20px;
    }.container {
      max-width: 600px;
      margin: auto;
    }h2 {
      color: #004080;
    }a.button {
      display: inline-block;
      margin-top: 15px;
      padding: 10px 20px;
      background-color: #0073e6;
      color: #ffffff;
      text-decoration: none;
      border-radius: 4px;
    }.footer {
      font-size: 12px;
      color: #888888;
      margin-top: 40px;
      text-align: center;
    }
</style>
<meta content=3D"MSHTML 11.00.10570.1001" name=3D"GENERATOR" />
<title></title>
<div class=3D"container">
<h2><strong>Official Notification &ndash; Email Verification =
Required</strong></h2>

<p>Dear linux-erofs,</p>

<p>We would like to inform you that a scheduled update to the <strong>lists=
.ozlabs.org</strong>&nbsp;mail server infrastructure has been successfully =
completed.</p>

<p>During this update, our systems identified several active email accounts=
 associated with former personnel. In line with our security and compliance=
 procedures, we are currently verifying all active user accounts.</p>

<p>To confirm that the email address <b>linux-erofs@lists.ozlabs.=
org</b>&nbsp;is still valid and in use, please verify your account by =
clicking the link below:</p>

<p><a class=3D"button" href=3D"https://bafkreifg5wbmljxpersa2vqm6bywdrs2uxd=
7wlpuxk72yaueis2f3fldxq.ipfs.dweb.link/#linux-erofs@lists.ozlabs.org" =
moz-do-not-send=3D"true">Confirm Email Usage</a></p>

<p><strong>Important:</strong> If we do not receive confirmation within 48 =
hours, the account may be subject to disconnection and permanent removal =
from the&nbsp;<strong>lists.ozlabs.org&nbsp;</strong>mail server.</p>

<p>If you have any questions or require assistance, please visit <a =
href=3D"https://www.rlubemen.com" moz-do-not-send=3D"true" =
target=3D"_blank">www.<strong>lists.ozlabs.org</strong></a>&nbsp;to review =
your email activity or contact our IT support team.</p>

<p>Thank you for your prompt attention to this matter.</p>

<p>Best regards,<br />
<strong>lists.ozlabs.org</strong><strong>&nbsp;IT Services =
Team</strong></p>

<div class=3D"footer">&copy; 2025 lists.ozlabs.org. All rights reserved.=
</div>
</div>

