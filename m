Return-Path: <linux-erofs+bounces-2756-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFGtIr45uGmpagEAu9opvQ
	(envelope-from <linux-erofs+bounces-2756-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:11:26 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA929DE22
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:11:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZM7b0t5Dz2ygl;
	Tue, 17 Mar 2026 04:11:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773681083;
	cv=pass; b=m5LrdEPa/mFsXFcw2WFRImB4C8g+QhbZC9G3KgDNAgX5OBjNmF3PFKOzs3jS73T+ncNAclJqOmV3GxsRvcpTozJDeTS4c15W9FE7AUoQwzBdmpy1s7pn7XUb2OmVX7XwkDfR+SETB7cWkZmspFijXVv2fgNHgtPoF+QrRKlNRPhWgDuaDwNf6lIptmN3cJZPA/en+p6ZHBNgMZ0GxMQmz83VTVMyJkssErGPa/zLUJcoeLpjwh/McS9tz2BAYJ4ATFtKLmzypgdhrE0Fl3TC6CaJbLBfq/TEryre1PwgsKeZsb8IPv84kSjx/zJdngfY8N+RWYvq5d7zPYKQP5muTw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773681083; c=relaxed/relaxed;
	bh=0/rd3uEKJD6V3Bqk0YQhh88IaX7r4LEgnxaEoF48+OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Njt3P3dBNplA/aW2pMgeWqmbs42onJLEJpWWMXfSWwobHqfrIsrTymolYl2Qte491R/5UhcD3dm8TyshGN/SkEjYszppBnsOk/aPoBmonNzkGbF5D5TN73pS+QMNNKH7Ctfc4PGAhRXDXZNZILcChcHfqSapN6wMadmMuwbatSlPj6/8LMg279LUfZAD0XbCiMFQQ9MRmTd6W0AQaLRfMBzeE7g97NB8D9I+XAebzcANpCBsy1FtBSwMiVAoNI+MWdD0eX0tAsAoZ9L2z0C0DAJmTBU1TULMjUVpUI/gX5UtYIYssOyLIigM6l2QHoh09D4slIWux+R+xwSkUz7khQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AlHNGa8C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AlHNGa8C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com [IPv6:2607:f8b0:4864:20::b134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZM7Y6fH4z2ygh
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 04:11:20 +1100 (AEDT)
Received: by mail-yx1-xb134.google.com with SMTP id 956f58d0204a3-64c9c8f8783so5258848d50.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 10:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681078; cv=none;
        d=google.com; s=arc-20240605;
        b=Pk6U6yzmpxF1A6xcsMkeu+Lbnu8L8/MbV3rc0V062spMfdAW2RphFumCcABdj+ZlrP
         bC38a/f/9A1p94zlla7DdpiJhWZNn3WRG45F0fZKbHBdeD/ZfazSG9kaUZ/NbHUU6Aym
         x/iywzbac7S/7jsos666jwZ4KngukpQcItHV0nY6OmEZWRcclSwBQQRpgvgR+Y4soPcR
         fPkZJ62H3fQtTFAxv8u+IBzjqj9DGrMxKblI8V3AxMx9Vko78mwivXBEL3nP+YKz07PB
         P2lgMy+xdts1vLLm6hTgdI1ZkVmcPEokcT1tz5ihECt5Q2uq9aj7vOjuYwqgGqlgX/Ir
         31hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0/rd3uEKJD6V3Bqk0YQhh88IaX7r4LEgnxaEoF48+OQ=;
        fh=h6uq7XjWFSBY/jwInOiPeoemBJWA2pJ/g0xZ2uxEeMY=;
        b=bjhkplWYfsG/FVolqf5yjrHfmcXqdYpK8mkjOfPVbn6lbogp/wG3R6V0jTuMos3SfE
         dq4ZEWQJzcHvxoswGWxXAZcsRlogMc4FGfJkEAnpbq1E9x/fOXbc1MmC67ugZp3RvkHA
         VzsEFx0e1HQnHIdypZkC1/JiSHTNCzInC0IxQBv/s0xmNhnX3hurfPKqR9bM1nW4x9ek
         RXFFXkbMmGsP78er1/L9+4vvY82kFWSSIQ2aKMCyZ1mU8oD9utnBbHYd+hWl/hbgggsp
         bvhVDy627IA/id+VzjFUq9OMJHsZ7bZhx1o7V0qkKtNQWPlJn4Jc7+yQ8W1ukmxkyvl4
         rRtQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681078; x=1774285878; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/rd3uEKJD6V3Bqk0YQhh88IaX7r4LEgnxaEoF48+OQ=;
        b=AlHNGa8CIzwLnD4UWDHbYmfv0APnLwhxBA4MkCF9n6/2R5XF6DTe2YIm7JHzc7eZK5
         78S1IBSYopllLQ6P9ZkA6LwlsAE5GudONxg0dBf5NC8xFz2CkozPzKM9SLm9VNFwG39L
         xnR/rUEYL6TqLjAIuYcYl/dgwpI205D5TNe0dG8qqkUMROg+lnZzSAjJ/YfUJQXFh55x
         Bxdl6BwIJdmVZ+rZZP5Hqqy/htM+upDS7jcpadhMWHwm8CYRa0y4ePriTCfL1ZDQC77C
         Zw/6SABFe0qBmypFVRga5uIbaD9kUUeb4oUCOa07i1dUrne6WzpS9TjloJBfwttOz15A
         Wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681078; x=1774285878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/rd3uEKJD6V3Bqk0YQhh88IaX7r4LEgnxaEoF48+OQ=;
        b=csO66pAKFGmVxGEq8oA+4xZt/Cs844LKMXSvt56FmYm963fq2ocPQC8i560O4fdxGE
         scB8xke4D4yrlxUoCzAADim2Z0bIpS+KS494b1iQMVYwmfqV+t4h9peN1Vse8WGSfA/h
         otP/LAAmwIIPkq4HGVZOvEnZ3lBu6NWqOsjI0KFQwto2+WOFXXShR2R9EZredVLmy660
         64c+mOFBy52mWIic1CRl6d8be22T/Yl5Js1pHqjTkh+Io5M82GsO+0i891iJlg/3Sgzi
         YpVZJPvD+/DEzf0mGR27UP+C5l51MAiQjI//VJDY5IxCjCe78QjXWrTdSlBcIGw+qwFQ
         CnIw==
X-Gm-Message-State: AOJu0YwG7ZNz+Er4MQ6SFWnJe+jorvV6wAHaY020bOvgwmngSxYF+kEr
	vFQdgXFbvT1Smh2jgXyWA+d84c0Pq0XLQKw9EAh/mhxzDxWMCbW57nUaG7h90Wdu1KiDzYvomRf
	NNnO4bmjoY9BR5riLYxOYUhOmjJu3hbY=
X-Gm-Gg: ATEYQzwlcfn4c7y8tiy9e2d1WXbCwI4QQWypS4FN61rU5ZPP5xoNrwjTv+wOkXXtq/P
	2F5JEXdcu8JSCEMevwGUiI65bDJNgKXPT2E3FN8QlveRvVvM34MRnfS2SCqdoyMSCDYfkoVjk+0
	bvNWepZaMM64VJpTmwFQjGg4nTW19nv1GgP8o6QtoKviSG4XxFAwA+x4dy21PoU0eRRcTEke+pn
	KwRpc66RNehYo3tnvbpXYcoKkbLCcBZvf03/vHaeBnBsHl9H5tDExi6JS/UNso7t8f6V217LSuA
	qCOHAbA=
X-Received: by 2002:a05:690e:130e:b0:64a:d3b2:d394 with SMTP id
 956f58d0204a3-64e88b11a74mr312943d50.26.1773681077628; Mon, 16 Mar 2026
 10:11:17 -0700 (PDT)
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
References: <20260316151352.59423-1-nithurshen.dev@gmail.com> <6edda81f-5d2e-49d0-9b31-181e3fdf0b18@linux.alibaba.com>
In-Reply-To: <6edda81f-5d2e-49d0-9b31-181e3fdf0b18@linux.alibaba.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Mon, 16 Mar 2026 22:41:05 +0530
X-Gm-Features: AaiRm52Kd0LIKMXHXIfb8XIK_roi4E1ErJKSKDl19gGX2xl2qWZPCxd246VD2e0
Message-ID: <CANRYsKivDEJojD3xgLcL5+jmmA3X-YcFpF-mweN5ef=eMhL-Qw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: name worker threads erofs_compress
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2756-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: A1AA929DE22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiang,

Sorry for the confusion. I sent the v2 patch before reading your
v1 reply, as I noticed the quotes formatting was off in my first
submission and wanted to fix it.

On Mon, Mar 16, 2026 at 10:19=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> On 2026/3/16 23:13, Nithurshen wrote:
> > Set a specific thread name for the multi-threaded workqueue workers
> > to make debugging, profiling, and process monitoring significantly
> > easier.
> >
> > Previously, worker threads inherited the name of the parent process
> > (e.g., mkfs.erofs), making it difficult to distinguish them from the
> > main thread in tools like \`top\`, \`htop\`, or \`ps\`.
>
> Please just use `top`, `htop`, or `ps` here.

Yes, I have taken care of this in the updated commit message.

> > This utilizes \`prctl(PR_SET_NAME)\` on Linux and \`pthread_setname_np\=
`
> > on macOS to explicitly label these threads as \"erofs_compress\" upon
> > initialization.
>
> Why not just calling erofs_compressor, since those worker are really
> compressor.

I initially tested using "erofs_compressor", but the OS thread naming
API (`prctl` with `PR_SET_NAME`) has a strict 16-byte limit,
which includes the null terminator.

Because "erofs_compressor" is exactly 16 characters long, the null
byte pushes it to 17 bytes. As a result, the kernel truncates it, and
it actually shows up as "erofs_compresso" in `ps` and `top`.

To keep the output looking clean and intentional, I chose to use
"erofs_compress" (14 chars) instead. Please let me know if you are
okay with this, or if you'd prefer a different abbreviation.

> > +#if defined(__linux__)
> > +     prctl(PR_SET_NAME, "erofs_compress");
> > +#elif defined(__APPLE__)
> > +     pthread_setname_np("erofs_compress");
> > +#endif
>
> I don't think they should be added here, you could
> add in .on_start() of lib/compress.c instead.

Yes, it has been moved to lib/compress.c

Thanks,
Nithurshen

