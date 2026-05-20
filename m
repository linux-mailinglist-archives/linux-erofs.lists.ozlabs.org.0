Return-Path: <linux-erofs+bounces-3473-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD1vBMUcDmpT6AUAu9opvQ
	(envelope-from <linux-erofs+bounces-3473-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 22:42:45 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38015599F9E
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 22:42:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLNlN2Jbwz2xrC;
	Thu, 21 May 2026 06:42:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779309760;
	cv=pass; b=YpT3q6oRfYggVlxtiGZ/sT52RFSA/30bhlvUeO+9ViZEpAVvJKZKGjZIYRm8WY2rlRJUed4Hi/+14DXSCSpaLrseScveFVMEBHwPHa9h8fJ8BNd9xo2VHTrAPy6sECUxoLxlOJeoG8MDa4fEeTq9a8BzPIBI408ckeptcsIG3MJr0e/9NTI2mJ3pd+VsKYhJ/vo4OxzHly209rE+x7J5mPy9UsmLSydNPI7bSRsvHuuI+gF/3cHKFWy1pux3iw62r+INRA0qIFEzqoG26wp1d2fg4Yl0eqaMRVSES5ffyRjSACUv8Vki6SPOohpqOlB9IWuP4sKmo4oJZVh+OxPWZw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779309760; c=relaxed/relaxed;
	bh=dDZJv7UlUn74A/Z+OhfVHmGeZ/3pnTEAEt/ElPY3xUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll6eYXxR13cy+/kCVhwo8tBh0AINk/1g8qTDQ22VD69wJ93PM/D3Ebnk92Cby/99HlYPvhsNOTIw1dQsPpbNeA/W2w2l8eXdQofIRi3Xh6lWQDbyTCwK5zmQpueV+Q3Y3KrzfP9AN7KAdsllqcPjjvJZxfoV99S49uaSVogA3r3nIWoy/FtNy5Eq3kT8/r86SFDnMQDa5z2L2Ow4E7+0Zo7RkvMM+K7BDYtxtF8XYm7w7iruEyUIKEuGJSTh71+fU9lsSYMBdp7BPyFOijbVuGVGNAf1V9sBLGtJh6jjjtNqjTCQCEOiuRFZDWAGd+f4rO0rzintDOst0ubfwWFKrQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UFfhuTdo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UFfhuTdo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLNlL6lKnz2xqv
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 May 2026 06:42:37 +1000 (AEST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-bd8f9889a8cso567785366b.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 13:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309754; cv=none;
        d=google.com; s=arc-20240605;
        b=IB5/0CU0oR0gGVTPie60ahwb6PHTtiYSsC7tNkJpDbvRFCRPfVrxJv3b043aE5dm/y
         RKtiazFzN373zo4f/My8t3tLRz/8pIdITaDz6KUlBmP9tOGM8Di9+S8cnkIUfqRbZY96
         u62G2ubwsOADkVov3kytumkGE9t7qC+yi1wUPTAkamaVAtKx91fdMFhGZSjC5vVE+gXl
         poQcs86Ru4kAI0B9778zSvv9lkFUopUvJyLTZIDLGNZh43GKk/6cEUgcdzPQufbpwHk1
         qYlNjvED8MW96RfZBcz+OrmwIfJ0mQjiMUyo09CWk9ha49WV5tzcnYDWVTUW8nFRbRQj
         KmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dDZJv7UlUn74A/Z+OhfVHmGeZ/3pnTEAEt/ElPY3xUE=;
        fh=40sfRs0i0puvBtJ9z8AfTc3bV4gLHdNbA3K1N7FqTT8=;
        b=fq09fBud+3T/OCULbmBhI4Of1VwEjAKvDkJL4gPztW3zgXbX3JB8IHQ7FSYWz5LmjI
         M9nFek+bn4oaivGwycNY40c/RdWbmkvVl4FJoEMY1ugYtwbdkVkgvVD+iuB25L/3lJEv
         K6yUgBO8kZQUPRCppiNd3lQ4x4HOnNuvhT+SD9GQDOl6izsFUW+CEJPCyVer9z/7Qb+T
         sNJs+grcxO9dy+CqXrTdoPVLLh2mxcsIDYc8Dk2qDiIZmFcs6zCBK2RutgIX9tWA2LJz
         ofLD3NjXLqcMVEIVGu69XS15xUkuWOgHeOsBw4ZFVFjqbmeW3BEW8tyhNC+3DDGztIgH
         tFPQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779309754; x=1779914554; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dDZJv7UlUn74A/Z+OhfVHmGeZ/3pnTEAEt/ElPY3xUE=;
        b=UFfhuTdoc7Uu/YgIUAO06I5lUeF931je3o0JmwJHcwK6rWmfbGdKuWbfLY8XERv/JM
         kKnFozFLOM99SC7s9YCIRIHlN2uBysEmWWAYLpCD13jiaIg61OigKO1POG/vceAqCxjh
         Pr+wBl2B5p88Cf9bhW7w+JU2iGWrGAQ+yxZNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309754; x=1779914554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDZJv7UlUn74A/Z+OhfVHmGeZ/3pnTEAEt/ElPY3xUE=;
        b=OfnbPIQVG1FhFXAxcKeM+g1784dFmdv/diyvjR/TzFa3rK865fJmNOeCu17+f0/OHD
         B9KynXMhNtdDRmG4EuEyeEigwTb+5jBjHwMOJUPiUqIPK67fXNFKjBd24uPpmAVrouHX
         O+IQ8+yWdBVYLZ6klIYEHX2DT0aVX67q4t/8qoVFj6GwMb/RvhmC0LcO80uqcXISDCAU
         4iUd5kkEBuz1dA54GNxWfE/BUcscwqTQ6A4v3tAYQa8gWzL0Xd3vjLVlNVYs+0k3pUkP
         WTNNtDL28JNySHoa7oOM+v4EEjha0qypy+ASDl0M0GtmCvYh02b5EUnhy3qDyNM4UX0x
         TDMA==
X-Forwarded-Encrypted: i=1; AFNElJ9S1bgP+VhJq42m0isrGrsJuFs0/vP5OEc8iN/Rhpg5UxBl5NdGLi/UqyLQvEheLPuPYmj67m3A7dpfIA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVmMq3g36M3+/zn1Uv/4/IU17tC0KZtnd1wIqBgf5O2a5u/NUg
	ZKCILOK5uZUDrtNM6F9/2JuN0d6fBNVRmR5NPvkDmtT/8wQlGt4072yG58J6lKq84AQRlFUMbYe
	Vyj3TPY+ZWm/I4Tu7S7AJ5NzRdcWib4+26Wri2cDS
X-Gm-Gg: Acq92OHChaaJ4zTcsWY8HdTVPpQ9H0Phipt3xFRD4GL1qji+UzL5nad6dJ8nnKVAfuW
	f/8rUTVN2V9uvHDLFzEQiNWsenZvO9V0e3BKp/Iw2qyO7tsF0Okt2vCuQBbSe0as5K/oFsU+NG0
	DePe6sv1DLlCUAeHZOcyqkszTh2LXMNT6WGC38DyjH05fRSAxinFKrdG0TGqqANp4H3xKqYZbgw
	2O12z+vAw8grvt+MbzPJyL9xx1HcC6+Q/5zkfWBe4dSyN38wWuEa0yNaQ7t4zrojgkMPB/N76xk
	OWBDJg==
X-Received: by 2002:a17:907:7295:b0:bce:259:3d64 with SMTP id
 a640c23a62f3a-bd51795b057mr1406996266b.37.1779309753854; Wed, 20 May 2026
 13:42:33 -0700 (PDT)
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
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com> <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 15:42:19 -0500
X-Gm-Features: AVHnY4LDiDqOlen9UUrA2bhfoboGGdOX8RI-NTpbl0URCz40H9NEbYtHKc4rZus
Message-ID: <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com>
Subject: Re: [PATCH 3/9] fs: ext4: print change date in directory listing
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Huang Jianan <jnhuang95@gmail.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>, 
	=?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:heinrich.schuchardt@canonical.com,m:trini@konsulko.com,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-3473-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[konsulko.com,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,mail.gmail.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 38015599F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heinrich,

On Mon, 18 May 2026 at 00:57, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
> displays the modification date alongside the file size:
>
>  4096 2024-03-15 09:30 filename.txt
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/fs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index f8e4794c10e..482a5523712 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -261,6 +261,9 @@ static struct fstype_info fstypes[] = {
>                 .fstype = FS_TYPE_EXT,
>                 .name = "ext4",
>                 .null_dev_desc_ok = false,
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +               .caps = FS_CAP_DATE,
> +#endif
>                 .probe = ext4fs_probe,
>                 .close = ext4fs_close,
>                 .ls = fs_ls_generic,
> --
> 2.53.0
>

I would prefer having a head-file macro which expands to nothing for
xPL builds, rather than adding preprocessor macros.

Regards,
Simon

