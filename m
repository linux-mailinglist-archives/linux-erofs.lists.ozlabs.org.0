Return-Path: <linux-erofs+bounces-2490-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPsyDcL3p2mtmwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2490-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 10:13:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537E61FD5DA
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 10:13:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQn5p4qY3z3bt9;
	Wed, 04 Mar 2026 20:13:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::22d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772615614;
	cv=pass; b=Pv7dBq8c4lqxnvwiwnrt5Lcb2Vj6ifCKMYU69dK19VjkkUU6ugIiKYeELd94HdmRwwMLxd7CGUwkkM0AvqOFUVSrxJcXA3d5OGaxSoZSImdeQ0nvHJncVBNZbdH0vuo4EZbUbNwSKLBTJMKSPaFtwt2rj60wZ3mcCp+cg1/QbPONVaKaZhS7ELdzuCan/hnuwsavwjY1D3XPNYffmHlVEILSx/P8x5lXhoMCahU08m0+pW5r+H2c4o4kglPAonI2WkpN2QyX0aoRmXTTKPvlsWeH5gyjMWYCNy9CANTNp4sftrwxxC3+570N/z6HYg57qMQ7qSYReZRVrGKYIcpsxg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772615614; c=relaxed/relaxed;
	bh=mlpzgMoITKvmfvrP75KHKwl6CilV/tJTLnr8Xd3tEj8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L+Kz0uLmXV/YG1TAI7/gWqzMwj7JQLVBmeEjlgqzMA58MIbh4Fx+Dstc4F8F5OSzqRuX+islt2dzGsFljFBNdP9SG+WJztvgcMC/dpt/H0p19aaM1zxteZt7/jhJFqZ2S4iIwoXzcnpab3uLp8g76zIaf1IroFcefbYTdrDSD4vEb+S161zQbVUJlsL6JQQTHwO3GKYvQskL5bgv2eXBSRy0JprG9IsOuwRJZBvxV79ebWFtmRtsZ9k3qLrn7A77sgK0Mt+hmo3ycJSlXX4h9YbWCxNePYaBCuh9SDeeMx5/CkmSnwclVfcCzO7bjnbA6gREwNnaI602DRuzTrAa4g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Mq5qLCAj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Mq5qLCAj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQn5k62f5z3bp0
	for <linux-erofs@lists.ozlabs.org>; Wed, 04 Mar 2026 20:13:30 +1100 (AEDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-389ff6e5885so49300991fa.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Mar 2026 01:13:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772615602; cv=none;
        d=google.com; s=arc-20240605;
        b=SO4vXtSirL8miuPzonaD/7tXtRJebqgP21NJkNAlciUmPsCsAMGo82NsnWM+nq+oZM
         4jkp3Bu+ZAL0frX/gyC1tZA/Kv/QNFx/YSkIts8J/HzjotvWxy4BsVuEvwZG3No1RFLR
         ELltk1zRIo16W9wb4QZUQGhjYx3eOIg4O+7kB6RxIbM3hP5C3FBP6nXRdHJC9JS2+CDa
         Ji7houvMtxto+8oea1skVg33dtl6qJMPQlMCebAw9tk3jXHR9Bilkig7l40v6PtuQVbF
         SrTB9Pu8v3GaN935upvKNQFmJcOW4g6muTnyrUaKrNlSabiBEsJ9nBtqdaTl5KaiTNLl
         MkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mlpzgMoITKvmfvrP75KHKwl6CilV/tJTLnr8Xd3tEj8=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=EGfM758b0psmvGg4YzLJNpIAuYyH1089fk2C7l8ofvaO7u/0U2UBnJwVpR994b2wp7
         YRSF+rnIbIT1DqN4WQ0o2WSBWKMG1W6kOF3Q8durmSGqutt09QXklU1dRehsp+bsuEM6
         kuWjlqtUdyPE2DqWkhmLdFmpA8a81S16kTkDGu1Hvk1E9FBtAqiJOytui+2FxKHND+Wl
         ZeD5g0TjAaDe41mZPymstI5iOCD03/4pkzFniIhl6S3HVHU1wWQwhiTHCoCEY1TTyLYz
         nlqk5/JD5judifz1OY7qMw4VHgBemghETGrBz6w263N4EI9uSSTght5REd0EFf1i5w0W
         CS6w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772615602; x=1773220402; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mlpzgMoITKvmfvrP75KHKwl6CilV/tJTLnr8Xd3tEj8=;
        b=Mq5qLCAj31a6K7P0wBlNlP+QKPlvR+/TdwegMR9sJv/9jt3KU4Hz1RzSbqiaS4LbMb
         QFu5IuBC19O7zLQVS/ZImaUPscXO8vgP+hGKjzY27aU7R3F7fn5mhd+NUqoKyP9E2Nht
         CIb9l92eFIP+zufEWRQzbXMhKGqDC9Irb31FzC6cHYuKxulWzBRo10UnTrxzPfCl13Sh
         qH4Yf9iSGmeXEFrnkQeA/c0xd4BHL6/kw3v2dlFE7k9J4L27k9FgLTp8/3Csgj+N3TZl
         Cs8Cx6IMklMFygpDRKhR3G42ZsUcpQnS7tc1XjgzTE/FfSQMJ2NKACCZzay+Eem9wA87
         s6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615602; x=1773220402;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlpzgMoITKvmfvrP75KHKwl6CilV/tJTLnr8Xd3tEj8=;
        b=lr9/ct62p8ZVuG14OUeUZVP3E/spuO+mSuHRe7rg5RMo7Zil7/baF7b3mWUBq6EG2x
         YgonZeE66Twc5/jWMde0D/ChYm9UOdeDiQrYbLQtbxJKUn7m5n1XxqwGdnfgU5FBkD5S
         bx3vk+2waeuUAhmg9PY3opyHinXgjv9mLgyNv+994Qd01QODfsfO7SIMztwWxjVxHbHT
         yANKm9a+cP02CYv765vfFdIgTn7RYWnaFDvBPPHJryGEzg33FoOdkK/LH4+54/bAtEmE
         X3RXk+bPo84Y4hosbnQPhuEMYOImTWUjCIibdQlAhzOSMcV4+vYjDP8fGRk2bbt8jXiJ
         IS2g==
X-Gm-Message-State: AOJu0Yz6TkcUFGz0HOmzGRnVjS4qqnk6k1lNKqwfUz0vPl4zVFKno9pz
	wQPhXo4r2UZOGTb9ZePasVCGRHZr5XR+ml07Bnl0oWBSs+j7ElMacWfa9znPe0qgUTAKuB9bf2y
	sM++Knq8F8AymzMlmuK3+paO2d7CDpSMPml/rU4E=
X-Gm-Gg: ATEYQzxu0Zcf+s6r7BjEGHL2b/ARac+BNSPrksp/iEBFgd/wojdZhEQlHGSK4NFzdPQ
	9gT89A/eb2V45+spA1WFIeR1C2h0ayHwLvipIv3hQMZ0ppT9XTdpLBxgRdGuwoPjT2WNqhRw2uF
	TWmM2UdOuhqJn61QtPbz4IR1taCfIu/rBVWLhyuMk1gw2lmFgpcvmntQ8nyDp81mC2muRfCXAwi
	1jSczLtmHIDbeBTnbiRKsJ5AbWQeM6IF0f5SIq9oj5LS4TBZVVtgW/Lu+tO81SzLQGueuRrsL6L
	W273tg==
X-Received: by 2002:a05:651c:509:b0:389:e501:41bd with SMTP id
 38308e7fff4ca-38a2d010f8fmr11517211fa.6.1772615601668; Wed, 04 Mar 2026
 01:13:21 -0800 (PST)
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
From: Aayushmaan Chakraborty <aayushmaan.chakraborty@gmail.com>
Date: Wed, 4 Mar 2026 14:43:10 +0530
X-Gm-Features: AaiRm50YDEmYQCFICulMau4Tg61o6UKdD8H_2Reu3o2fK0BoMeuQa3xCFkPh5wo
Message-ID: <CABCXVcn-vY+d4s9HGd9Y_jP2y8Trm1rzPvwWvYRf4qctDAwtoA@mail.gmail.com>
Subject: Re: [PATCH] README: Add Quick Start section with beginner
 build/test/mount guide
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000042c50c064c2f3bc2"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 537E61FD5DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.20 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2490-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aayushmaanchakraborty@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

--00000000000042c50c064c2f3bc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gao Xiang and linux-erofs team,

Gentle follow-up on the README Quick Start patch I sent on Feb 28.

It adds a beginner-friendly section to README.md (deps install, build, mkfs
test image, fsck verification, erofsfuse mount, cleanup, compressed
example) =E2=80=94 all tested on Debian/Crostini.

No rush =E2=80=94 just checking if there's any feedback or if it needs adju=
stments
before consideration.

Happy to help test or refine anything else!

Thanks for your time and for the great project.

Best regards,
Aayushmaan Chakraborty
GitHub: Aayushmaan-24
Email: aayushmaan.chakraborty@gmail.com

--00000000000042c50c064c2f3bc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif">Hi Gao Xiang and linux-erofs team,<br><br>Gentle follow-up=
 on the README Quick Start patch I sent on Feb=C2=A028.<br><br>It adds a be=
ginner-friendly section to README.md (deps install, build, mkfs test image,=
 fsck verification, erofsfuse mount, cleanup, compressed example) =E2=80=94=
 all tested on Debian/Crostini.<br><br>No rush =E2=80=94 just checking if t=
here&#39;s any feedback or if it needs adjustments before consideration.<br=
><br>Happy to help test or refine anything else!<br><br>Thanks for your tim=
e and for the great project.<br><br>Best regards,<br>Aayushmaan Chakraborty=
<br>GitHub: Aayushmaan-24<br>Email: <a href=3D"mailto:aayushmaan.chakrabort=
y@gmail.com">aayushmaan.chakraborty@gmail.com</a></div></div>

--00000000000042c50c064c2f3bc2--

