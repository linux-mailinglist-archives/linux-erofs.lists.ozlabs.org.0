Return-Path: <linux-erofs+bounces-3157-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBEzIT4czWnOaAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3157-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 15:23:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE1537B25D
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 15:23:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm5Jp67czz2yhY;
	Thu, 02 Apr 2026 00:23:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::22d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775049786;
	cv=pass; b=HHV5xorjRQC9DnmpDHl+ugQ+dDhEK2W0fVI7OtJsgbAJI6+ZYOC6ZhrR2wmJbirgLt4rCXU0zbViefY+Hwfkwul+JqcntB/x7TWvvFul+R2nzFOXGvWHpEIEP6uKL3kHJAhz2P9MWFzbd4qvUyNZMod2U3D3y+98IarOt3IAcTVq/AOCvyVFIPdhI9GYWgilOz24abUZYwuEqvWsdydb1plwZEMzN4MFUwMxN2cAvubDpv93PN5ZzNDBhVi0GpTT41fPhCn697B2ue0hTiFgY4wSWYjxetI+gkbkdlXgK8hoe+OJgKgIEl90pBYjNi5C+7zMDuCWJP9Qy3iXFWfPNA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775049786; c=relaxed/relaxed;
	bh=5/jnEXMVz4lRcmCKrAwmHim3afZfPiJsO6kYIwlu4K4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hkAJKBWeZcBQg/8IWs3WZIHIUH+mXsNou5LdFX0suv3paoyjRvUYEwh2ZSNxE1I9qGOB/gsMgORJP7eAtcbHu4Ps77/igCVX+VhID0OIDGlonONyjYjqmJCIG/giU5vYYeUhSjtGXvDztXh52ECk4JUy7Z2qEsELBCrK4XCVgnpdCdKRDVuBLYcmH+NFFIe58E3C8p0Vb8qApSlUdI/yK3aElnyk2v5IC/bgua9dg891vb/v5vWQKA+MbokzXS5XjVyMGzk+70mOGF2gMKOFrsC5vsK+4TTIet/EKkH+E/8uTPLe+zlxvvKrXy5TsokVE1RPMSYLNskNhEB8JIEKpA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W8fz3276; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=bushrahz.giki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W8fz3276;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=bushrahz.giki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm5Jn1bFkz2xd6
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 00:23:04 +1100 (AEDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-38cbb1ad0b6so14932941fa.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 06:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775049776; cv=none;
        d=google.com; s=arc-20240605;
        b=Exrvx7s0IUxnUIv7ep3TBGahPK12+L+ltC2GfwolbJGEa1yZkEI+SEF3GNsBC1hW3z
         AOmYKXeib+iUTf8RLq4h+7+Q5SmtwGq2VhGN9wo0Nn80ixY0CgxWinioX+frKLq7Yk87
         5aJhq9equ5+LOyBzyo/8OInz7myFrCMsisZYFOrH0SlGmOePFQTPtKizSyJ3diIK6hZ1
         J029NEJXkYx+KwMo94II7CwqmIsw3GN+DF+NJSGjNqHljF4cqj1BAl9OsjlR8/e7DUAt
         ng5ddev1e6gyI+zkXsmlB8e6+r+IqlapURJQJfeF8R8ngyUV3awFGeZ1MmC4307KQovp
         e/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5/jnEXMVz4lRcmCKrAwmHim3afZfPiJsO6kYIwlu4K4=;
        fh=U22QJ9eosVoFHyND/2V/7IWE0M67KzX7AQrFwN++k0I=;
        b=D5xlqn/xSXIWABF4Z8HBkgiZSQA+iAZTaC0e7xD8eSQB4NKK74BJT50QRA0ZLThux3
         CK5vGcmrBsJ1sSiCW7ZMTKHUWiwcUYwwZQswkvthD6G0vFLpXvVK0cdhGVSyrP5+GZb4
         4DSGw65Lu0kygf44gaeQcLEw8G1b3k03XobhRwj/LTyYOA1OqyJ8Csk56c4IS+9d+F1x
         mF2gAq9Y3ZCX7fzlh9fgTSxE2vXaCnvhW6YAnYB/7lxjg8ZnRdAfCqd1opYgk9w7c3W4
         y46q+R15HVySvz4gIQE3suohePlRWDUv9xiOMK5RiipHM2/r9udCgNJRZDLOCLRyj37C
         l1bQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775049776; x=1775654576; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5/jnEXMVz4lRcmCKrAwmHim3afZfPiJsO6kYIwlu4K4=;
        b=W8fz3276TZizYNef4YW5/YLxASlGmd6VAWZeATOwiWsiTpclaBKtFpK04CFlxVgzUX
         cCx7jevN5s1+F3xgcsjwJBooUksvy3+YCKgSpJo+ULEMdcU8JaFuphSmbv9jKG6x060Z
         flIZDDbcqs7XWdfnOZBMW4DyujFLb5L43hcKViZxq9q2O218Ol246h0L54srThdtBRmE
         dlXIDhTh7WbBEQbWimyewC3fGRYySpgILvZ3DdZ0purLPb/KA969eWTW9xILXHBRySDW
         Em708gjdoYM+u+1L0mrc/5Qpa9+7wXa4JhBmE6P3vgZNAO/R7ymy6mgsLhFtBJSLOHbY
         SCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775049776; x=1775654576;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/jnEXMVz4lRcmCKrAwmHim3afZfPiJsO6kYIwlu4K4=;
        b=bjNBa7R5OxrLb6u1RPcdvKzFm5pzor9ZccwIXL2jx3zztKN5dGiCO0oj2uY88zIA9X
         xAWuZgJwhozNZkrSnYCsU7B8GtJnlmBR5O2WoUpHafakDlu9Zhnur3yNXa2nkCjq/+j6
         Us8X+1GjpPm/gvy/lLJe2RZd2lToTTq7eqDE8wvF7+3H9tojgaVrz93isRxeaJk8wksN
         R7ykUKP/1JXT0CvkIswlbHh7rLclkuQPCtcTELXgmUXQoZ/lCOWCsyrQbuZ+14lxocVA
         hbuu0cREifMifgGNzPkjXu8A05pRBoMNbgcyKX/R3HG3KYoZlhz5MoiiK46cXxf1l5vM
         vDyg==
X-Gm-Message-State: AOJu0YwKu8SjDYUrESqliyoUBcyHusbhAAXxvHu1MJJYbu87GK6dEReT
	/X6JPCBY+SVNyIW5qT7gB62eX3c2tPr6chuCy3TtPwFMPal0q5l3hKtuJ0ii0ODvuk2LIMwtKT0
	I5M0kYZVTeAVrxwZZuzv1b/ojgvf+yjsFRrBmtLU=
X-Gm-Gg: ATEYQzw0CVHD1n/zES7vwrye+V0QymXyIKl+siQFUjouao9a5eguxolQ821iE44cfnj
	CwKDevkOFy9f8r0kpapNJE9NEe9Tdp6zeqEmUbt1BqtH/nfqoWsTaHZvr5R113LTqLVxhtJSrkB
	XUWzKCeGVeglRuQKdkeT1A1cVv2S9xlawac3QW6IDJYcUFSmsI4vv7g3g3FQEA56J9kF8fNWhZV
	qhRhxi5NBt45YnlootITBox1kDEYDKAQxWzAAlAlX1SstN8j7idbZV4ufCfXRrJOAhw0Cgd1ZWL
	MyTcy8jCTN/mIHPi/tBo1b9BwrTUsLpc2vTloK0ziKvEZYOyYpzdNgLPvKMjAUA1vdcMhEMYZcU
	W8w==
X-Received: by 2002:a05:651c:1066:b0:385:e82b:5ae8 with SMTP id
 38308e7fff4ca-38cc3062fdfmr9210651fa.22.1775049775242; Wed, 01 Apr 2026
 06:22:55 -0700 (PDT)
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
From: Bushrah Zulfiqar <bushrahz.giki@gmail.com>
Date: Wed, 1 Apr 2026 18:22:39 +0500
X-Gm-Features: AQROBzDYRclH6x9AE_v4QR9YmhLGyLCeVzlk1i7-0YCuxSeu4t4GlUon8jdL8bo
Message-ID: <CA+ug3icM1dnMfjtesxSFtM9yJWCxzfG6oyeur1KGPQ8384G-Qw@mail.gmail.com>
Subject: =?UTF-8?Q?Request_for_Late_Proposal_Submission_=E2=80=93_Medical_Eme?=
	=?UTF-8?Q?rgency_During_Application_Period?=
To: linux-erofs@lists.ozlabs.org, gsoc-support@google.com
Content-Type: multipart/alternative; boundary="0000000000004fe4c3064e65fb4b"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3157-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bushrahzgiki@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 7EE1537B25D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000004fe4c3064e65fb4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Google Summer of Code Admissions Team,

I hope this message finds you well. I am writing to respectfully request
your consideration for a late proposal submission for GSoC 2026, due to an
unforeseen medical emergency that prevented me from submitting my
application before the deadline.

During the final days of the application window, I was hospitalized due to
a medical emergency that required immediate attention and several days of
recovery. Unfortunately, this coincided directly with the submission
deadline, making it impossible for me to finalize and submit my proposal in
time.

I want to emphasize that this was not a case of poor planning or
procrastination. I had been actively preparing for months and was well on
track to submit before the deadline. Specifically:

=E2=80=A2 I identified my target organization and project well in advance a=
nd had
been studying the codebase for over two weeks to deeply understand the
architecture, design patterns, and contribution workflow.
=E2=80=A2 I made code contributions to the repository, demonstrating both m=
y
technical ability and my commitment to the project.
=E2=80=A2 I prepared detailed documentation and notes on my understanding o=
f the
codebase, the problem space, and my proposed approach.
=E2=80=A2 My proposal was substantially complete and only needed final revi=
ew
before submission.

I fully understand that deadlines exist for good reason and that making
exceptions is not taken lightly. However, I am humbly requesting that you
consider my situation and, if at all possible, allow me to submit my
proposal late. I am happy to provide medical documentation to verify the
nature and timing of my emergency.

This opportunity means a great deal to me. GSoC has been a goal I have been
working toward with genuine dedication, and I would be deeply grateful for
any accommodation that might be possible.

Thank you sincerely for your time and consideration. I completely
understand if the policy does not allow for exceptions, but I wanted to at
least reach out and explain my circumstances.

Warm regards,
Bushrah Zulfiqar
bushrahz.giki@gmail.com

--0000000000004fe4c3064e65fb4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Google Summer of Code Admissions Team,<br><br>I hope =
this message finds you well. I am writing to respectfully request your cons=
ideration for a late proposal submission for GSoC 2026, due to an unforesee=
n medical emergency that prevented me from submitting my application before=
 the deadline.<br><br>During the final days of the application window, I wa=
s hospitalized due to a medical emergency that required immediate attention=
 and several days of recovery. Unfortunately, this coincided directly with =
the submission deadline, making it impossible for me to finalize and submit=
 my proposal in time.<br><br>I want to emphasize that this was not a case o=
f poor planning or procrastination. I had been actively preparing for month=
s and was well on track to submit before the deadline. Specifically:<br><br=
>=E2=80=A2 I identified my target organization and project well in advance =
and had been studying the codebase for over two weeks to deeply understand =
the architecture, design patterns, and contribution workflow.<br>=E2=80=A2 =
I made code contributions to the repository, demonstrating both my technica=
l ability and my commitment to the project.<br>=E2=80=A2 I prepared detaile=
d documentation and notes on my understanding of the codebase, the problem =
space, and my proposed approach.<br>=E2=80=A2 My proposal was substantially=
 complete and only needed final review before submission.<br><br>I fully un=
derstand that deadlines exist for good reason and that making exceptions is=
 not taken lightly. However, I am humbly requesting that you consider my si=
tuation and, if at all possible, allow me to submit my proposal late. I am =
happy to provide medical documentation to verify the nature and timing of m=
y emergency.<br><br>This opportunity means a great deal to me. GSoC has bee=
n a goal I have been working toward with genuine dedication, and I would be=
 deeply grateful for any accommodation that might be possible.<br><br>Thank=
 you sincerely for your time and consideration. I completely understand if =
the policy does not allow for exceptions, but I wanted to at least reach ou=
t and explain my circumstances.<br><br>Warm regards,<br>Bushrah Zulfiqar<br=
><a href=3D"mailto:bushrahz.giki@gmail.com">bushrahz.giki@gmail.com</a><br>=
<br></div>

--0000000000004fe4c3064e65fb4b--

