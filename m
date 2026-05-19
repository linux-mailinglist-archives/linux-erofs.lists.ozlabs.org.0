Return-Path: <linux-erofs+bounces-3460-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJkUDnnBDGqJlgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3460-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:00:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6484758468E
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:00:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKlsf2l5Qz2yD6;
	Wed, 20 May 2026 06:00:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779220854;
	cv=pass; b=fTq/O2xVevo6Woc2wxKPzG3g67oYof/Gu+5qifQm37YLoQ30ns/whywfMfWrwpwKN9YOH3J9thXgKQwJ27xriyPkFuw+3oHX0CmodZf77NxK5YxXXTz/jwP9LftF9gSIZnzH1Xlgi1AxjTT8N/UdZNqGDon0sWHIqZOf0X9q0TKr2ByZyVslv+z1OrADmua2XZE6dkUTv+CMGe/6S0dvpHix76oMt4xbdzKo6E9Pp/3cYjF687ffzfRSenXfcJqv/GX1ae9dO9yUyfZRyrLV0/JlpVtEPd9Xh81LtGe4fAalX1acpS+GcRQdMa1CMmjC5IXDsrG1MAzUBXpo9s8zUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779220854; c=relaxed/relaxed;
	bh=lwuzneXbvXgqa6Bkbu/2Ynh+GBSHRDdIshE+cuLXX+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsI3pKm2ZEgJMvhX+Ba5JuSQPuaWyyhbNUyXHwPre2s4eZsnX7eehBO/lx5X2+EHg4Q6PTzgpJEYUQH18d7LBa0SVrtiJ58whRHgBmzb1LgT9yrb+YFq7Pls8g9Yv9rASE6pbWC8S0UxWijZZumx8Yf8TEv233baqsQYq8PzghdWbAg1+Cj87IrdqdY0MrzJm/3czZxLkW4vYRKZJMZcBlLhOQ8zCrb1BlVl25dHWpYxIiq0vVu4qRFsgzFGbl44CgVvNqTmWh9c8QstHELhvn2yu2gFrxwxxQOMm0n/flNdRAsOukPvTtG1knoeYiE7l+7NiWwhCfgNFxM8csfatg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KeWTEb+e; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KeWTEb+e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKlsd4T0Zz2xwH
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 06:00:53 +1000 (AEST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso9253450a12.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 13:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220850; cv=none;
        d=google.com; s=arc-20240605;
        b=hH1W89w0AcwWxT0Sm8zdT0mV26k0rYrDrvpryPa12aJARIvSKfRJftMAe5mZaVofox
         uXkUgFw9MFyqjw9roGP9+SX1hdUp/PSCLrvHG+LkHc27hN4HZOf8zML6PbSSnEkmGYot
         1J4zYK4xi/mou6l4DF2yXSJS3K0PiQx3YLikwK1AeRs8PAyO16jzm4dw7XIV5ZQfEB/1
         9v+W9qRdlL6VJJiiadfAl/zqldcsFC9QdDzBZf3uMNmv8bjw1jmc/Si2AXvrFmemqGTL
         qXSPhzzCwIDYXZw98sbH2N6o5rX11FmtGlCzAm454vZG3NOSKUKxPPlvKUFab3j+EuOY
         ClXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lwuzneXbvXgqa6Bkbu/2Ynh+GBSHRDdIshE+cuLXX+A=;
        fh=uEmhZNLwAEaIoj0/Qn9qQydLCyaVsszjPGYvwQRko1s=;
        b=X0xKKAaj7oqxrlsKCTVEds3gjacnoLoOxuWrgwqv1UhOj33pXN+UjNh+eicLE60Mb8
         JDzbO3/nTKB9Bs6FNd03aTpy6XoBJfJBrMcboFvImVmkwwoDYmhyoAq2n6HT9qAsTiTm
         iR4pMktVcEXKhiLmn/4rdcrjBGfgorpHcj9cVuhBqB6fbmtOEwWDprPWq1czZ6k8Od/T
         9ZWkLCC3bCi93gPJblzzJOTA/EKQhNwpgG01jar/r4JASNvPtiKbsvq0ArvY/MiS2I3q
         R76B8ACFozzMt/QBoUTgf/DBcY6Y4weGeFPBCU2SWjPw8YMHhlt/2yn8pmwT1PYnmXo4
         77oA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779220850; x=1779825650; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lwuzneXbvXgqa6Bkbu/2Ynh+GBSHRDdIshE+cuLXX+A=;
        b=KeWTEb+e5PppNvnNW1yTUrALO2aXJ/6/VkkdNjXLrm9BaW/cuuxculzC9m9At7bIuA
         b0FcAiQ3p4/YMJLRaJBNfhC/Srtu60sQuoUTdXBDCFF9X9LLYU8G+jpZTeJq2+j4sopy
         yi/NQU4iFTPN/0LtbbD+Hcxf6t/fb8Ndba+k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220850; x=1779825650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwuzneXbvXgqa6Bkbu/2Ynh+GBSHRDdIshE+cuLXX+A=;
        b=tYFpUXu7yiPuiOhPKqbAE/ea5BDnj5hBxE06UNI/HKEUKAa+6ez1ssQbY9hIDettRh
         d/Co2IEhhJ6QhHDHCW85fLE183DyMkach45PVqgIB4UJrdEhTMQsPzJQaIKhTGQhocnz
         YHoCoofd4abzUmgnP6FoX97871lNuijsCupelzrHiAAXdmjhW6JJcqrqB+icdYezf+/w
         R2d/LXpn9els9kxKEh64bz24Lq/8WpKkGXLmN7xiL7v07V7PBudZvdxG3c7cTOZ5waac
         c9q2M9rP5je2oh4LkeU/DidLGT3mKMsWu4NOJeQecug3e2jdEthOij0p1ygKZZI0rFMb
         qglg==
X-Forwarded-Encrypted: i=1; AFNElJ+MdsIRxbUrEbj7lDLsongla2nhP2ecGcGCUFtktF8xvSOxGwwULPj9Pe58DPBotSq/dZPXYGFzE1JMVA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxXPIEDtB6PZR9fkd4mJ/tKg9uN9YWV5R3lXsf7hLmjuq7Tu9OJ
	ZuEDD6WgtMyxBaO2zM9BKsWGpuwjlpYT+0F5EXSse726brRP25011HsAGB3ZfVDenut67L9WhPh
	yT1Bwt2pf/nh4KdmZ4srtly4EdHpRyTbgy7uBY1eX
X-Gm-Gg: Acq92OF7uc6ybzVOCM99jH3tFomzTFTsZim41jKXVU9f3AizZMF/HpUzxb7OHrCC7TJ
	jScr1a2brpvMQArl52hvTauZrQ5CA+uEU21JQA8HTZUo0pN2v6Pom6lsi2O2DNql3MoPC9CDd+T
	sJVPz3p0PECKwD1YBi0HQTw6GBqAbBCoM+V1MVXvFYGPGGOqoLcPNbdKx9Tji8nfaCuZkjqi00L
	wYN6+/SR83rssVA/8YgdKIawYj8LJyXDu5q/KfeqLwJPIct9oOgLED26uTccAAP8tLF5gYjWKq6
	cN51zw==
X-Received: by 2002:a17:907:26c5:b0:bda:7a3a:b05c with SMTP id
 a640c23a62f3a-bda7a4a0d99mr21994866b.42.1779220850366; Tue, 19 May 2026
 13:00:50 -0700 (PDT)
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
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com> <20260518055728.178507-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-8-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:34 -0600
X-Gm-Features: AVHnY4LEd8HnuTfPu1Wx1zno3zaqntNzH3CitGLfmu9PDvntVnfPbTMaqGHoN9Q
Message-ID: <CAFLszTikKyaW+OUGuz8KRffyU8Mn3xCZ6AvJtpGPuFAhNqyqrg@mail.gmail.com>
Subject: Re: [PATCH 7/9] test: fs: allow optional date field in ls output assertion
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3460-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chromium.org:email,chromium.org:dkim,canonical.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 6484758468E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: fs: allow optional date field in ls output assertion
>
> fs_ls_generic() now prints a date between the file size and filename
> when the filesystem sets FS_CAP_DATE (currently FAT and ext4).  The
> two regex patterns in test_fs1 used ' *' (zero or more spaces) to
> match between the size and filename; that no longer matches when a
> date is present.
>
> Change ' *' to ' .*' so the pattern matches both the old format
> (size + spaces + name) and the new format (size + spaces + date + name).
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/py/tests/test_fs/test_basic.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

