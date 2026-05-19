Return-Path: <linux-erofs+bounces-3462-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJphLIbBDGqJlgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3462-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:01:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636658469D
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:01:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKlsv3zs9z2yF7;
	Wed, 20 May 2026 06:01:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779220867;
	cv=pass; b=kY64e/AmLTHmaS3mi6FtB2j/PBQHd4hh5Zf08fiWUhU/YXj3F4uB+gGjXVZ4PuVVpx8otUE2nVFu/r4NdQR+palJrd5RgR4KarGlBjNQBpJbrsjLAkiao0JArv8mTZwuMZheevDq38UNOS0lDGdBhf0ZpGwE5TlyRqxmNKgAObaJ7u63qCmi4Y0TmO3ufWL6I785ZbEaZP/HLSVY2wkTJdy4vE8CPaNGvBrmVolycSSs0UhRBNNNYMzky5xq0SoMczQ2TSU52VpaaWT4AkF45hbweAEJDxPdYJq9GkzjckPdnuy9xbApt2oWrnOIj+1Ujof+CXe8mbnlef3X8GFNYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779220867; c=relaxed/relaxed;
	bh=Vbh0NFfYO4h9OFTgpkaMR9KjOE/0yqKQ6RL9bFCncmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nehlIaFapP4rYZAZCXXSw8x2pkr8ddapI8wnfL6bGWjWRHYHQFLeL89meDUUq1TigxEim6wB9Zuj0ZE2tJNPz4DqEnla5Oj/7au72uiMzT73A26zwPfcJxTJ8K80o7k7dRfCpT9awjisaG/Ged4VrRzrZsR1lOD8JRbc5xaWCtYzvhsHfIFkG3F0G3F7hFiG1NbKDTHEtPHe7Q0bWzWL5jugRcPjtC8/rYiv31vEe4To8FpQ8F1Ti9DmP/MdVVaV0cU4qzyphQWlMOSb373Pua72XckQ/fLHfdMYLCi5yjWG+4ECFPdkAN8wnGn/jLwecHkar6gcZrmq96geW/Z9lQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aUGqcVRp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aUGqcVRp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKlss2Q90z2xwH
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 06:01:05 +1000 (AEST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-67e2498f3a7so8825843a12.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 13:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220862; cv=none;
        d=google.com; s=arc-20240605;
        b=GLfkMEO6d4V+feMJU4hN2k0bnflgILbGHOiLhgnZ/kdKzStS6oz2LbK9IreQVVTn+7
         PxBESI06UpAuuseLGBGUFan92s30yFxR0wsW0ZqQR2eXTkMhrCBOuuH1R58dpPat6cgc
         sFacvYFd4zgPuOHtCzQVPEHalcMt2a1HaO5It3RsSciUorFRL5zhbmq+oynNbO6coufk
         RHZQ4z43frG4j0S41sovuwWvrK6AgkcoZlSOzw128LH2cDLysITDg2JFqzbo6hXZiCB9
         aTo4ydztP5Zuv/Fjw2e4rLC7VTLd085t9knGqNPr22/bvleIWwc4n9dZKu7FHn34nWg+
         xNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Vbh0NFfYO4h9OFTgpkaMR9KjOE/0yqKQ6RL9bFCncmA=;
        fh=OIb2tOlLb1pgOSgjYJOOY4RUMBxQln8r5Opjze3waP8=;
        b=jupJMx0E7C7SmX2JD87Dbu+76SlffUijMEshwKjsNIZZySUKH2aidRnAbBRT5h1F72
         Mx6y+gesKcLIwrw/32TqHiVBhDA+DhnpzLYNyTtYbXQHc2EHYUdUcRACnjCoiJEHYsKe
         ffmmAuLDnPMMqrOs1qcnM9icoNpYKrKlvI52Wr89QGY1BC9xgJWO+ao0QzbcyIOILDUr
         y4g1NJTNH4ljjRjd0dft+MmcHLLs9dlhu7sQXiDAnvEGqlaIbl9KRQKQay2mk8SOMM3L
         OPMihpJDa0kkZHUcG4HyKy5mRxWDx5FI69u+77+zfif1ls81hNxH/K33yZsMxKj1tDeF
         XMSA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779220862; x=1779825662; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbh0NFfYO4h9OFTgpkaMR9KjOE/0yqKQ6RL9bFCncmA=;
        b=aUGqcVRpt9anHsnBAR/3KoRkpP0+ksBQ0fqjFdkVB+GdrmkYRxPDdfqQSAYl5viMoc
         I7JH8ILgk31G493zjDGpaqDjsJxUl6lEWlyznL0GE7IzryQd/E7zaiu7r4HfkGC/q2hk
         Zy6L6H7I+Pu7OAu9F6ksJMlcGOIofraCHYTrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220862; x=1779825662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbh0NFfYO4h9OFTgpkaMR9KjOE/0yqKQ6RL9bFCncmA=;
        b=EuvzDMeEXCOSB0V88x8yGWvTUxHrlx41CnR68iO7e3Vr+C2Yfs2275hMTo6niQUzk5
         M0asX5O2Wxd3+3t+UHfR9Nc6FggxFcds3nqFJQtdbXSjH0e/KJzdz27lf2NYkhYoEptc
         n0YutJENxhP2rnCWO7XqRTu+XbuJCbnqGAdCAT+kl8KfBnM9Ox87ZqyxJ+Wv/TrpK/RQ
         9ReUGKC8w14k0VwZs3+iJTGtXZVIaSjVQMMv3ISdPa5/NDIlRzbhcdQSaYMeMrZJ86xl
         wPm3onIh0QT3UJARTKggkfAXIyBxLe+4m+MFam8cNuQWTfaoY9QZ/5ljonoGH0QVJ0/o
         xLLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ugScP58F7I1lNVbK0Q42JRb+Ja2WVsVylvwYXY9gdmag3E5eWI5/bfeqS6WlkrEj6qMK79Prb89ZFEQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwoRraJvFPkGIY6G2PMV3EhtIr4GA1Yk7ZBSurwJ2+YZEWJ7t6C
	x+fHoFL+qlPy/kyukn70PRxd1dK9fgZoOz9TKO/RM1x3BLNFwWJfedahptR+LH2X2/hdiOa3xlI
	e18JM8pcaqt8dAsXA1qG1INTLRV2qEGNebVWY3IOJ
X-Gm-Gg: Acq92OHqpRr7mSWpvHTqhRKIsL+khsGgEywHbnRnWYFbNZIzE/Fx+CGCNjgF4zP2oM6
	dNi5PPCuJLUQDbFp/Dc6ba+HNQdcmwqjxT57UN7XTGEqKCdqnzA1jSoiBV1qi4mrxfmqJ1y6s/M
	aryJ2A3FqJ8jZF28De8PYA3nbe55MwaweXgsFfjrsfXSHZ9mRjGYou1zAhuaFcMaRQkINr7Hv6a
	tCtaAtQgrK3ZYRa2yCS+TT/+K++/ZwpWtG1z6pHWL8nd4GtU6S+k63a5PbyU68zfZKC/kCIxfXm
	sL3Gblg4lnv8D1k4
X-Received: by 2002:a17:906:ba85:b0:bd4:a849:b13d with SMTP id
 a640c23a62f3a-bd51787314amr1335676566b.22.1779220862148; Tue, 19 May 2026
 13:01:02 -0700 (PDT)
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
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com> <20260518055728.178507-10-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-10-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:49 -0600
X-Gm-Features: AVHnY4J9Zgg1_OX6BrYTeki33IX99RL9jRjB2_ATcCFyrhat1Hva9VzwJeraCtQ
Message-ID: <CAFLszTgsRzmqmfP2Xa3bOqqEBeL+riN50vMgZJT2LXcebmwt6w@mail.gmail.com>
Subject: Re: [PATCH 9/9] test: test_erofs: adjust expected ls output
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
	Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Tony Dinh <mibodhi@gmail.com>, =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
	Francois Berder <fberder@outlook.fr>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
	Daniel Palmer <daniel@thingy.jp>, 
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
	Sughosh Ganu <sughosh.ganu@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
	linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3462-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:heinrich.schuchardt@canonical.com,m:trini@konsulko.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[konsulko.com,chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chromium.org:dkim,canonical.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 9636658469D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: test_erofs: adjust expected ls output
>
> With the addition of the date field the space between columns in the ls
> output has been reduced. Reflect this in the expected lines of the erofs
> test.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/py/tests/test_fs/test_erofs.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
> @@ -73,8 +73,8 @@ def erofs_ls_at_root(ubman):
> -    expected_lines = ['./', '../', '4096   f4096', '7812   f7812', 'subdir/',
> -                      '<SYM>   symdir', '<SYM>   symfile', '4 file(s), 3 dir(s)']
> +    expected_lines = ['./', '../', '4096 f4096', '7812 f7812', 'subdir/',
> +                      '<SYM> symdir', '<SYM> symfile', '4 file(s), 3 dir(s)']

Patches 7 and 8 took the flexible-regex approach (' .*' / ' +') so the
assertion does not need touching again next time the column layout
shifts. Since EROFS goes through fs_ls_generic() too, please do the
same here rather than hard-coding the single-space layout.

Regards,
Simon

