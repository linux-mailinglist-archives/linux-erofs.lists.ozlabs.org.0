Return-Path: <linux-erofs+bounces-1442-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E3C8DBC6
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Nov 2025 11:24:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dHCFp4L1Fz2yrX;
	Thu, 27 Nov 2025 21:23:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=149.72.126.143
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764239038;
	cv=none; b=GTTyDLITNJ3MjLduflPF+fKBMkomvXKoo7ESiaFgubiuY/jjt5BkC0U1qGxkZButMjmq55bdrHMDC2xflw/0/nXBrOgfW74IYRwd9xUtsNj7O3Q+MRtuL4ZroGrIHAlNPcTFtlEViXxxj7ZgxAqyTmIhAGuTvhTG353Mq1djn9nw+dzU86zyrZ+Tlnzf2SNFSiB4WOD8esh1a1Y9DFN+QMXgH0t8CBk3moEWZJIaacYEphtpH+Jwu+5KUv+qcMHsOn+gWnCOUSILRg3m9xoqVm3KrpZE3mpfFxAqKZeeRvJ//0op+bHkdcKquyfB84pN2xu9ukznOrnaIBEnidLL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764239038; c=relaxed/relaxed;
	bh=+Tw2JdQwqaMV3hOWdiA7PY1wbaRMBWPRcIALkfrUbRU=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject:To; b=Ai2uyoJeeHKNkbdPFPdC2FRyZOOIUcRf+C31z8g4at2+4K3CbfGy5iuGW4Umey+FXDXDzJJtPJBk4Jzr1RFE1JS0zK0xUagMBaKwTDZkVarmniQlWWZsz/qQqlyE8GzTm7NSfuNAiREhOUirr9EQeEzJ+MZ9s+26cKhKfrtUHecIp9mYxDbVJlxMaxnJ2poKXW0iTPQgqDMkT7udgnrmL6aosOZhGCUoPN6qSL4RT6KO3iPfED2eojEUp2Cdd+MGHpdEmD13UVTq05/XZ3vUOpzA7d/CNIkmL8UJGFWlbzQWiYx/qpgbKobd2VHR15msMbpPRxlHLH6LvL10GyQP1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=batelnet.bs; dkim=pass (1024-bit key; unprotected) header.d=sendgrid.net header.i=@sendgrid.net header.a=rsa-sha256 header.s=smtpapi header.b=GMlo2etm; dkim-atps=neutral; spf=pass (client-ip=149.72.126.143; helo=s.wrqvtzvf.outbound-mail.sendgrid.net; envelope-from=bounces+56943592-7e9b-linux-erofs=lists.ozlabs.org@sendgrid.net; receiver=lists.ozlabs.org) smtp.mailfrom=sendgrid.net
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=batelnet.bs
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=sendgrid.net header.i=@sendgrid.net header.a=rsa-sha256 header.s=smtpapi header.b=GMlo2etm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sendgrid.net (client-ip=149.72.126.143; helo=s.wrqvtzvf.outbound-mail.sendgrid.net; envelope-from=bounces+56943592-7e9b-linux-erofs=lists.ozlabs.org@sendgrid.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 71 seconds by postgrey-1.37 at boromir; Thu, 27 Nov 2025 21:23:55 AEDT
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dHCFl0Tffz2xP9
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Nov 2025 21:23:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
	h=content-type:date:from:mime-version:subject:reply-to:list-unsubscribe:
	list-unsubscribe-post:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=+Tw2JdQwqaMV3hOWdiA7PY1wbaRMBWPRcIALkfrUbRU=;
	b=GMlo2etmOVsmIKF/l7eAhESH+rOY0HSnCylXsGcdkxgP3jjR9qIMOzj0WexMcNOBJ+In
	ibQUOgPu8KbGMhKtAUZf/KoErdn2z3Bgb7OVWVr1rYLXZA+CED56XJNdVZ9cYmG0BA5w1K
	Qb4nKH1RNcLKYj16KS2IQLdgU+K8yNHiE=
Received: by recvd-79cc5f8dff-wbrsg with SMTP id recvd-79cc5f8dff-wbrsg-1-69282671-6
	2025-11-27 10:22:41.242357744 +0000 UTC m=+15183501.579426378
Received: from NTY5NDM1OTI (unknown)
	by geopod-ismtpd-66 (SG) with HTTP
	id lFggu0HwSXSuys81oxKymg
	Thu, 27 Nov 2025 10:22:41.226 +0000 (UTC)
Content-Type: multipart/alternative; boundary=ea8d6175559f23eb3e2119d287da65629d0bba735330518403757a4fae90
Date: Thu, 27 Nov 2025 10:22:41 +0000 (UTC)
From: Account Payable <steelpan@batelnet.bs>
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
Message-ID: <lFggu0HwSXSuys81oxKymg@geopod-ismtpd-66>
Subject: EFT payment successfully released
Reply-To: steelpan@batelnet.bs
List-Unsubscribe: 
 =?us-ascii?Q?=3Chttps=3A=2F=2Fu56943592=2Ect=2Esendgrid=2Enet=2Flu=2Funsubscribe=3Foc=3Du001=2EVddY?=
 =?us-ascii?Q?ppWW=5FlePoOa6ea9iYCCItYq7f58VDfFiqUfxSAy?=
 =?us-ascii?Q?XsgWPBtpmJ6xWm56lZROFvyAiPRLQdMg4tOpAjh?=
 =?us-ascii?Q?h=5FlZb2UScQPj0dWeX5yOpFWtV4j88dE2cY-ymA6?=
 =?us-ascii?Q?s4=5FGoK7RNTgsz5HmhPVQIYdMylvpYML6k7oW-kX?=
 =?us-ascii?Q?FNifRnsQBHPMVACO1lSD=5F4cmIuIkV6WkzCbQ6JU?=
 =?us-ascii?Q?anDfpebRdFfvhbXgPW9jC3Su0sWHDPL1=5FxCf08k?=
 =?us-ascii?Q?c55O9jQxng770xhRXNGExybCCVX0HVX4nojGtfs?=
 =?us-ascii?Q?8EJaFQsFyUlgnq=5FhWg8S51yMXNFhJrXS3OMi0pf?=
 =?us-ascii?Q?3180T3RRed1R6QLn8ELqrvBsbdFJtvdlWVvArWW?=
 =?us-ascii?Q?qWLLeCTbTHYEmZbwg6Y9=5F=5Fz8v6lRbZ5VdFDverb?=
 =?us-ascii?Q?LbBMkJPIKFCTwFW5Df8Lg1iDPyKoUsvipAMB5D9?=
 =?us-ascii?Q?U1bCYlw32kbkIyXLQ1HMPXRcaPwgE9h1atYQAWk?=
 =?us-ascii?Q?7sLPbAY2Bypg16fQgHukcbhV6n2iTjpAsaYpIhm?=
 =?us-ascii?Q?Uywg0aGyX1Ty1E4KlHS1MVwF51OH08dRN16ywRa?=
 =?us-ascii?Q?vm3HBFFm2bW8IHwEIB5vwPWttW5aDJ8SM8aA9Xe?=
 =?us-ascii?Q?64llFU1BXpvsaiXd-lHJlwUe9ghBbV048h1HZdO?=
 =?us-ascii?Q?dZDWZeNgqEqR0Llv3Km-bj2JFHcotZukIFD0pxc?=
 =?us-ascii?Q?zU28CHMBaYUWFOGpLEaP1FOXjYoGgoQY40UmWA1?=
 =?us-ascii?Q?sS0KGW3N8uZ249pxJLdsHEvd-MEZ6odFJDUKsLb?=
 =?us-ascii?Q?NmvwWmpbp8bOCf10ir2f1AVrNi6ft39PNhCXnXC?=
 =?us-ascii?Q?v4wsGdATnXpd0p9NdEzHg7uuuV3RCCRoLqR6LOT?=
 =?us-ascii?Q?WB0rrFBIOtNAO885Vu20DeFKkKOiA=5FFKj7epQsI?=
 =?us-ascii?Q?a=5Fnqx51ZxxiDW3K=5F1DRBNqiwv4P9Ne2QGCT5I9E?=
 =?us-ascii?Q?QuqB7GA=5FCxgiTQHIW0yYYXwBSDgCRX-QOO7DbGJ?=
 =?us-ascii?Q?kmtakbm80DJq1uhzgIKTQF3BUomfXX1Rg2aYolG?=
 =?us-ascii?Q?6WHNIINmyGokXR5JRuTSq0vuQBFBW1d4KPQN0PU?=
 =?us-ascii?Q?f7IQGgl8haKLhWpXBY05pgtMWPB6X1Ldx3fAZ-O?=
 =?us-ascii?Q?QW=5FLZwlsmwRxlKOyrKYTB8yFfo2kDxj47kbAy3x?=
 =?us-ascii?Q?SE8htMWQZZ2vMc4rKIgpBG1HeHU9CX=5FC-LNxRXf?=
 =?us-ascii?Q?-Ry-SixQjKs-ObE-8GKz16gp57WZkAQHpu2nffj?=
 =?us-ascii?Q?xnzSOv3E672Fys29dKuDH2xpFSPnf1C-OFHQg3g?=
 =?us-ascii?Q?9qcUBow-9xD=5F5UHt2NZM=5Fbrz=5FC9Bj6J7L2QNEqY?=
 =?us-ascii?Q?2J2zXoqr331eGAii0MS=5FCUxgV4RsCNhtAVVe81s?=
 =?us-ascii?Q?=5FUxTQdc1bsJlxCbAcGSJcrM35QFc2kn05fWNJ70?=
 =?us-ascii?Q?jBOpML32dEsXpzbj0f44VunzLXPzyJZ835Kg=3E=2C=3C?=
 =?us-ascii?Q?mailto=3Aunsubscribe=40sendgrid=2Enet=3Fsubject?=
 =?us-ascii?Q?=3Dhttps=3A=2F=2Fu56943592=2Ect=2Esendgrid=2Enet=2Fmt=2Fu?=
 =?us-ascii?Q?=2Fu001=2EIFldvd-OEMW6Re2a6hfYmpvUNNil5rzax?=
 =?us-ascii?Q?QNZ8Cd72vvMWJUINFCdArWfAeX2mitA=2F4ly=2Fu00?=
 =?us-ascii?Q?1=2EzrpwLBL8=2Fu001=2E-2FaiTRHUGyuhPmPZWT7a9z?=
 =?us-ascii?Q?7IVYUcsr44K5aCtNQvyiQFEv6Cfc5DgtbL-2Bdg?=
 =?us-ascii?Q?pu9-2Fa3SMyXy-2BDphFEHCVxnMbpvZLCtvsGGV?=
 =?us-ascii?Q?FTce9Rn8b0l69XfOvHEuG38BH22hJ0l-2B0b5xU?=
 =?us-ascii?Q?q-2FiDJX-2FKw29-2By82AZoaLgZBHQnHFI0Mct?=
 =?us-ascii?Q?gLv9Pi55XEf-2Bx8w-2FjO04LLC-2BGvZtFyF8w?=
 =?us-ascii?Q?h7FjjnZb2zyH-2FN2XeUxRIPxcaYH5c1lJhIb7o?=
 =?us-ascii?Q?GhCWC5Eawtv8U8Bcd-2BAw2CORWEXoa3ViZ1yDV?=
 =?us-ascii?Q?Co5FHpMAhe1fiA5LP5A8s4BuzPfumIs3sg070Dq?=
 =?us-ascii?Q?qH36feif0f-2F7UEMI3SzKmVsgxsbVDF2-2BdCq?=
 =?us-ascii?Q?9Cn0lmI-2F25HSTC5qyvQFQ7AcA8LKVo8i05s54?=
 =?us-ascii?Q?C3U5kcscJEQL-2Bl3W60sOFXFfquzTS9hjcqyB3?=
 =?us-ascii?Q?G4NDBhVX1rN2a5IKB19tDzmVjPZi8kMqq-2Fmzm?=
 =?us-ascii?Q?2mN06GlNxjYjHWavOEM2qx-2BK2eWZrMdXKp0-2?=
 =?us-ascii?Q?BEhiOhDPKDcxo90ONVcBDFGRHZjhaFWcmnTsyhC?=
 =?us-ascii?Q?zvxtWC7zVrkH0yZkC3koYrKHI34-2BEGiPo8mQa?=
 =?us-ascii?Q?ZgQzs8qRz-2BKu0WxujmHutldrPXVDIqvQDtjp5?=
 =?us-ascii?Q?yS3TkKExf-2BewILDdvRjofvWwXYf6-2BLlgSEn?=
 =?us-ascii?Q?8ccBcLzBouirewCQhfHAQOV7XFq0awQkWEDeOm0?=
 =?us-ascii?Q?n83y5yxwxYGFTwAt5RJhgLMA3NIiW9ReEdKlx1s?=
 =?us-ascii?Q?K5f6LgRMmkVjDNAV17-2Bwm-2F4vQSRDKcCQMx3?=
 =?us-ascii?Q?3Ct6YmpZJ6R60CKkMgg7-2FoCyKWmbRQ6XN6Mc-?=
 =?us-ascii?Q?2BrUv5y4zjYFLJnue-2FAoXppeEfYBrJIPHzlWi?=
 =?us-ascii?Q?1-2FspHURMhZD4bn8BTpcXaOPbI24L-2BQGUguD?=
 =?us-ascii?Q?xon3XkJqKJDzDK8Qmgxh10dq3953hrD5-2BQY1Y?=
 =?us-ascii?Q?p=2Fu001=2EWgVoah8Y=3E?=
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-SG-EID: 
 =?us-ascii?Q?u001=2EvmBzTggZXly+QgOyIxQ5CjwiI6AjLqoi5wZEdvyDzR2HJ6unO9nEq=2FCpQ?=
 =?us-ascii?Q?u7cZiYT5ugbuTsSX52mBa9XMDypcT=2Fedhds95Tw?=
 =?us-ascii?Q?yYl4ruxsOjgcZJ4w3pLbWmP6Gjcf5oMY1g2tzRE?=
 =?us-ascii?Q?BKmetQA7VewcQfy1T+9RvWvqmMKBgIAVib=2FX2dn?=
 =?us-ascii?Q?xgqLsH5zfYWWTEC6jAX0680DX2dLS4KQAQ3fINO?=
 =?us-ascii?Q?ajocA1WO7V0I0Nz7s99QFWEi7scTmdALvTvlGdw?= =?us-ascii?Q?qKv2?=
X-SG-ID: 
 =?us-ascii?Q?u001=2EXwhBPNhCejkv4+fVosb2QVfR16Qxp9CrA7PjDe5zzeI=2F0IZCBsPXtgHbA?=
 =?us-ascii?Q?oGIj+RskLxA4N2rJjSWrHfgX07tLOm0v5BUQcd6?=
 =?us-ascii?Q?w3knjorGi7Hwu0WCOA5AFSvy0=2FwlG32=2FliGCxkd?=
 =?us-ascii?Q?htQXnjd3hLnJ1apSO=2FDTk+1R2eMh0Bf2xE22gsM?=
 =?us-ascii?Q?NIZIOHnOHbnm7RlSp2W1WKHqOg5zl9OXfE3=2FGrR?=
 =?us-ascii?Q?cMPIh7TfCaKTGb0J7VDPPbvfMzB0S4LdicqHivY?=
 =?us-ascii?Q?ap+Nad4ZC89ePTjagqcGIqocyIdbw65eEZIlokR?=
 =?us-ascii?Q?OtXnYj2ac=2FzylhhlPF5fMOfB92EA=2Fyk6T09PS8l?=
 =?us-ascii?Q?uGCPjBHMtrijvMTpGg=2FUYnx27Y42LCZWDDKEesx?=
 =?us-ascii?Q?fuGN9+Bv0GYniG9wdh2=2FGJG0W6mdVZjUlNEvf0A?=
 =?us-ascii?Q?fFjU3r6lijFH8z6OWUUYZEVOkTVWQbow8Xt3WQF?=
 =?us-ascii?Q?mUR0jInNgTkzjfOUpzc=2Fwwy6KkpD6OhZ6vqSZBL?=
 =?us-ascii?Q?ueyL+w8Mb7HiaU6aRa+F=2Fec=2F83D=2F7eMjTsYW0sI?=
 =?us-ascii?Q?FEY1Nhd1hDU69BuGqCsILSBIB1mkX2bo0zV3CGC?=
 =?us-ascii?Q?dRKq0Phg8ICBUIBkb+1hatjjAMcohdbS6Tj5H=2FI?=
 =?us-ascii?Q?4vaRniMYYbkuzLzqKH9slyLhIFTpnByHL33sTkz?=
 =?us-ascii?Q?XoJwhvX3DvU9RqMa4XuG0qq6RGBbh+J+3FMk3uh?=
 =?us-ascii?Q?aHUXJkFrpXl9PF7j3fn4SDJ?=
To: linux-erofs@lists.ozlabs.org
X-Entity-ID: u001.B5AUULhrV6IdEa2KYM133w==
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_IMAGE_ONLY_24,HTML_MESSAGE,RCVD_IN_BL_SPAMCOP_NET,SPF_HELO_NONE,
	SPF_PASS,T_REMOTE_IMAGE,URIBL_GREY autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  1.1 URIBL_GREY Contains an URL listed in the URIBL greylist
	*      [URI: sendgrid.net]
	*  1.2 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in bl.spamcop.net
	*      [Blocked - see <https://www.spamcop.net/bl.shtml?149.72.126.143>]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.0 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level mail
	*      domains are different
	*  1.3 HTML_IMAGE_ONLY_24 BODY: HTML: images with 2000-2400 bytes of words
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  0.0 T_REMOTE_IMAGE Message contains an external image
	* -0.0 DKIMWL_WL_MED DKIMwl.org - Medium trust sender
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--ea8d6175559f23eb3e2119d287da65629d0bba735330518403757a4fae90
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0

*To whom it may concern*

*Your invoice payment has been completed via EFT.*

*Please review the details using the secure link below:*

*Payment summary ( https://hepatic124.nexanov.com.de/encouraging857/N0123Nl=
inux-erofs@lists.ozlabs.org )*

*EFT Payment ID: EFT20252211-895*

*Customer Account:*

*CUST-PI74144099*

*Let us know if you need any assistance.*

*Thanks for your continued collaboration.*

*
*

*Sincerely*

*Account payable*
--ea8d6175559f23eb3e2119d287da65629d0bba735330518403757a4fae90
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=us-ascii
Mime-Version: 1.0

<p><strong>To whom it may concern</strong></p>
<p><strong>Your invoice payment has been completed via EFT.</strong></p>
<p><strong>Please review the details using the secure link below:</strong><=
/p>
<p><strong><a clicktracking=3D"off" href=3D"https://hepatic124.nexanov.com.=
de/encouraging857/N0123Nlinux-erofs@lists.ozlabs.org">Payment summary</a></=
strong></p>
<p><strong>EFT Payment ID: EFT20252211-895</strong></p>
<p><strong>Customer Account:&nbsp;</strong></p>
<p><strong>CUST-PI74144099</strong></p>
<p><strong>Let us know if you need any assistance.</strong></p>
<p><strong>Thanks for your continued collaboration.</strong></p>
<p><strong><br></strong></p>
<p><strong>Sincerely</strong></p>
<p><strong>Account payable</strong></p><img src=3D"https://u56943592.ct.sen=
dgrid.net/wf/open?upn=3Du001.1UC-2FG1r4q2F7W-2BfmxQXtFQgQMMrnA3OBL05MxOQIlx=
KlOQTNjsKq7YvXwrhxud071uCIH5r245uUGZZ9YWGVAiMCsMKm-2BvlLEBT0JA4udYzjoWP7wSV=
lcAYGnKfWQvvpugV32JqvTguXguhuc921Y71zwq58iOdtVFgdZVC-2Ba7AULMRZi4qCIbx9GrB8=
qVxO8p0T2oy6vlhHFAC9bSnDRk2NpKI3giYGMoAF7nEViG3DeP-2Bl-2Btr9KiqX3XzbSGGv098=
gWUpYQ6-2FP7LCj0qWHfdQO6MUFDeeeneB2iAX28L4ic7lC-2BonklRb492dfWytFBeidWv0XGS=
oDTXCsmDRAoZC6H6fS0e4NTi9vL21GsVg3cSOKUo-2F2V8oOfCY-2BuwR1dcSrkUeo95O9pMZyi=
uNRneIxTIX9Og3gkrnPh8kb50PyQoDnddaB-2B7hwxQkhRUWbLRPo9aKKEZMkyj-2BQ9v9Q6Ya3=
1ajBrIJu-2Fp5gKK27fWvjPb1Jqd-2BTtdkgq14PlmTftCfGC8-2BqsO-2BMblb5d2im6PibKlb=
Pzu-2Bn9x-2BoIjyTwwxMV0pDHdjeP61GMm7BG3-2Bdnw-2Fmsp4vMt1yA-2FpPNtiBDjHbN7-2=
BWV-2FZuVcvF2481gRwVVxiVBw-2Fe0ZQH4HkTPtYVapyodbXnXKIk4H8I8BRlEkvwzJcyrlTzL=
7pcxEi62LObAfnB6KFE24onzCH-2FEFkXaZWQpzFsmtCzhZUCA0Eh1auFyjIe-2BgC-2BkU9rfl=
VCt1aDnv-2FgsPYBsQFQowkb3gcVVGFmWdFHdmeJ9hcQU3u2mVARbQfht6lXdGWlUyHzL-2FTUe=
NBw7Mt3Uy4D0w34-2FtepLxrJMmfQyoXMcYMp6Y0yjYD0q7yavDe-2BKX-2BjgkZI6aplqFlWTQ=
XznJ4CZF6mR-2BKB" alt=3D"" width=3D"1" height=3D"1" border=3D"0" style=3D"h=
eight:1px !important;width:1px !important;border-width:0 !important;margin-=
top:0 !important;margin-bottom:0 !important;margin-right:0 !important;margi=
n-left:0 !important;padding-top:0 !important;padding-bottom:0 !important;pa=
dding-right:0 !important;padding-left:0 !important;"/>
--ea8d6175559f23eb3e2119d287da65629d0bba735330518403757a4fae90--

