Return-Path: <linux-erofs+bounces-3459-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHF9CXPBDGqJlgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3459-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:00:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB05584687
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:00:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKlsW5s73z2yCM;
	Wed, 20 May 2026 06:00:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::635" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779220847;
	cv=pass; b=Zztxj5I4CyXfGcXRZYpJ5xK6DhxC5pjC3PrzuT8lPwHvHXxteyIRxUF51SRlPwNzgJc3Zp6RvE2122j7Vv6EHubHK3FFXKrCgKiSDZUkFSxNptRPjD/bCaelEy9s7UpsaJqd0GjGIhJzEqbSXOSLfQM0JWCDLNUWGwhjRcpPfOMOxce0KhZD/H1O7/ifG2VXGJpuCR+hOVHoIMWFSMWWqewH90xvkPllXEkzedjXeASeqqEsQ4WjhOEzPitGOyW6JEu1Icpel9icV70wz8pM1l67ayN0Hf/I6OEDQ90qhYt1FilFJbE2aJnBK/YtYhWxbCbaIvF60Wm7fre2SaPDkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779220847; c=relaxed/relaxed;
	bh=ZCZ3JqoysNE9TiYNsF5liZsuZ03stCANBEnkx2eZ5uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlIGKU2w5OLdv1JfN0a3yuhOIN9YAZMF2Bp94levVnLpgYsXeMyaRNddhc3p7ofiagcMpdnYgFUgEptyQtdVRlVnb8y+B0LcAqRxIePL0X4aign9Rp5E+Ak/NpLuOs8H++O7IHve/fHN9Ye4FAqw/ZL9AJ82NnnhhyHdFRoQpp5M2wX0ogU9sK+CoPZ5Q7kSwLsPCFa/wwr+7YN5q//VyWQHpI3/EDZ8tV/iVBqjO7k7FX+AhKS3afAoVSRsrzoTeDy1Ky06TPd2PpAyYodLQuZfTFfRl8MRKh3Wr7Re0Z2ggP83t8SkQiuuCXWMOEjMZmxxAfyLBPQYXO3ZyufeKQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WBsOalB9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WBsOalB9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKlsV6Xy3z2xwH
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 06:00:46 +1000 (AEST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-bd11a3729e8so671619766b.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 13:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220844; cv=none;
        d=google.com; s=arc-20240605;
        b=FWVP/JAPxzNZ4uuSbI2tDq0FuRNYlqaRAVfcSQmS3vGVJSVkH++9nw4aVhEGU9Lx0l
         LOKuCr/ix/i2dM0N6NSk40GGGhOpTGNdgo0c5cYOM5y+wqc7oTE6XisXBi8bxmR2rSPu
         oBxEOE2ISOzKrQQjhBXhgqXNOqbPnLdas4lsFMK4JXF/LV66IAxCYVnn5wefoQhPYsb+
         ILFcazcq8mg5xDvUthfdWbqZHyJ8o8Y2q43bFenviO40gfn7Pwrkiduy8px0J8nEPA1a
         DW4ciGReWpUDRZrS6fM0XZdlf73mDIagwdgxR7+8TIlAi+lARRjXXLt+0sRkn6Tm8lBu
         Wx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZCZ3JqoysNE9TiYNsF5liZsuZ03stCANBEnkx2eZ5uw=;
        fh=iiuz88X67pheBe8S0ev/cxqFQHx6AeiuXCPke4Kx0xs=;
        b=YP212iO9tC0x/XYcUoiTxBE0ikhHGvOscBwl8OMj1A5CMB5fwTnN5WJq/oQ5/KJJ5S
         CgkpTKdL6DsTcPFZc0xPm+99XO7fOJcGETLU2OOCpEsAgZCbRDBvWobWGHXonkTcJ9vy
         FybsKsMQG9aPBQTL8YeX7hx8FtkHolSqdElEi3vBN3J8EBA2KOM21/EMff6d3drDkSry
         I92KfuyZISBK9pQL335F3HYWHixHW3siDMz6aUuItPUG1ffNQckshfe8OY1F7OzWfNL3
         ivj8YB5xr8Lg3JlpRAZxF8tpEGv1WeZY5mQ8hHzzefmXqG6q8Bo5z2Px4eiQQfD2wy48
         GS4w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779220844; x=1779825644; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCZ3JqoysNE9TiYNsF5liZsuZ03stCANBEnkx2eZ5uw=;
        b=WBsOalB9WX6ZCoyvxH6xJOSXY1zYdUnE8U4KOi9WzXVOh1NUtwdbGomn9kK/AvxEMn
         KnyOjz88onDtLRPbcQNzy8a+SKja8eLeKAk+rxvZHPI+c7rkr7FwOLPIpNXDwAwdsW8w
         JqRLH2aQGeW5NOKG6KnshlwDETw/F1ytH9uHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220844; x=1779825644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCZ3JqoysNE9TiYNsF5liZsuZ03stCANBEnkx2eZ5uw=;
        b=hhO/mivbmdGojfr3o8zldiuJgMCYS8tbYEE4I/idjU+nWELez756Ktq5CJ2N0OoJtZ
         om+bFNRaxPvbkKM2QWTj3BVgPlY6Y92xL0cYhrqUve1YGtEpDJheTYVgPFRN2JoO76X1
         eFh1H2Qfp0qDPF5XygececXZl7K63y/ARJWHgUM3sJ0kLhS44+jKePY5F6a8+FZyqb+I
         ajDd9Rd2b9nGlMlDaG/qGGiqGGL2L2Gr3PIEqHOq4Dbm6LvGPCtxPxFA5J7ORbPFRPHC
         VIa+ViV8T/K9eJurKTOgCOjq0ZSaPRzZ6A78BVbRwceP0LWLU2fjUGsq7J6A+706CW9U
         e+Rg==
X-Forwarded-Encrypted: i=1; AFNElJ9427vOX1t+jRy44zeAQJyc0bNTg9NPzZTsCFZ0IJOnur1q7EYwVR4E+ditDZYFWy3AG7mqx4fhsGNkcA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwcDHif0IfKqe55PECRtKbOMZV8NBLL+lfsW0SM5T8K8NrP4fnG
	POQ66+t9WIlDtcYoDjT4Z4TMaPlhN/JXNqFcOthQJ0keqUj41bJqqTmtibw1dL2Hhcja1RRwIED
	hrUkCyyGV55tcl7Imki0nD0Ly8rMem6u0JSc0TwYV
X-Gm-Gg: Acq92OFXCIfyr1R+qgiUbUfVcXr+Nvz8T+x/ntbNodDklOoGLMiEyktfyLKRIKdE9La
	64jgxBYjB0Gk0TjP9zvvPWf+kFuJnFuAARInlT5Hwg4Mb3nZM4+tZUMts7uSe69JGqCmE6xCgAQ
	n6tDcoPc8DnQTsppL0MSjg15WVK4dgJxdA8beeA8aor2jfKnNLzXx7R5bF7mSJaqUmpwJsUgcVH
	5JqoTE00nM+0OawRq35Kzc5mDRg3rMsvEAlQRZPgQziGeFzVFQTzazd5PU5KFTCRekm0/0+tO4i
	T96BD5WlCV9DTB4j
X-Received: by 2002:a17:907:7ba9:b0:bd0:783c:9dd0 with SMTP id
 a640c23a62f3a-bd517966ab4mr1142839366b.40.1779220843826; Tue, 19 May 2026
 13:00:43 -0700 (PDT)
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
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com> <20260518055728.178507-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-7-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:31 -0600
X-Gm-Features: AVHnY4JXKoQbnUnIF8QmMjGYjI09x77nd-7tujmANE4GPST_yWO1UPjFAykUn_U
Message-ID: <CAFLszThEXe_dskFi4nNCnEq6-75GcRo6YNA2CCgt1tmacs_S7g@mail.gmail.com>
Subject: Re: [PATCH 6/9] test: Probe RTC early in dm_test_host()
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
	TAGGED_FROM(0.00)[bounces-3459-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 6FB05584687
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: Probe RTC early in dm_test_host()
>
> The ext4 driver probes and reads the RTC which allocates memory.
>
> Ensure that the device is already probed and read once in dm_test_hook()
> to avoid false positives.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/dm/host.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

> diff --git a/test/dm/host.c b/test/dm/host.c
> @@ -26,6 +27,18 @@ static int dm_test_host(struct unit_test_state *uts)
>       ulong mem_start;
>       loff_t actwrite;
>
> +     /*
> +      * Probing and first read from the RTC allocates memory.
> +      * Do it before the measurement.
> +      */

Please mention here (and in the commit message) which call inside this
test ends up touching the RTC. It is non-obvious that fs_write()
further down now reaches into the RTC via patch 5, and a future reader
will not understand why an RTC probe belongs in a host test.

> diff --git a/test/dm/host.c b/test/dm/host.c
> @@ -26,6 +27,18 @@ static int dm_test_host(struct unit_test_state *uts)
> +     if (CONFIG_IS_ENABLED(DM_RTC)) {
> +             struct rtc_time tm;
> +
> +             uclass_first_device(UCLASS_RTC, &dev);
> +             if (dev)
> +                     dm_rtc_get(dev, &tm);
> +     }

Since this is a DM test you should assert each of these calls.

Also, would it be simpler to take a second mem_start sample after the
warm-up, so the RTC allocation is naturally outside the measured
window without needing to know it exists?

> Ensure that the device is already probed and read once in dm_test_hook()
> to avoid false positives.

Should be dm_test_host(). Also spell out that it is the
ut_check_delta() leak check at the end of the test that gets fooled by
the RTC's one-shot allocation.

Regards,
Simon

