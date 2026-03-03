Return-Path: <linux-erofs+bounces-2485-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGHRFzCVpmnmRQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2485-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 09:00:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9671EA7B1
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 09:00:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ7X63Qgpz30Lw;
	Tue, 03 Mar 2026 19:00:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::836" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772524838;
	cv=pass; b=iHm+/nkIXMoJhkawYYHIj3qrD8Efis3tjksxpwUX/ag0nSnPGAzImaLmug3kxqK1vJJShvI0ZMMVghKNKelNvXo5l6U8GD2vRpmjxiTMSSIWURIIx0NNRIVTyq5kcjx0FmYy/5YkyvLitd202+iBeyiEGf66e2vbOQqUU9P42W5jnOdCEpDzx7B+zxKKNOc21he2MTvJ0uwg/Ybfnxt0dsEcVAeQSxnw1eefeesI3PvdOhOs8TZ7I6zuEg6nuylpORjbMkvkVzcARutVG4afU2v7xBITXVaWqdoqEYfmgYFRq1fi2FrdngkqXjIPYy4a0NnW0XOw1HodsHeEfusCwA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772524838; c=relaxed/relaxed;
	bh=ESk47PW7WGBa7MuxLoGtL+kM3vhSegSs0lRtzlMgVSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo530Smuq5iPitDSRQbPeMfpc+ZXGgKJBFI1WZw6QZ0J5JhPW7AGrWx6j6j1z1ne05tj96/L7KMx65kyJNL2M5BRf+PfpaahE6WhCeG9sYs6iOvwMxcGyHdSg303kvlNLjygM91bmpyTMTQUBPcaRlmxxM6tId10n8kVXMDGT/FzyBX8FJjSu3n9NpNro+6bpsWMLrrsbSYLdfDZYGeruiFTdkD3AwBa2Ws35UXNR8Fh2plfvMQF+kqnTDoWlPd0BT+D3CwduHQOPvP5mttAASazbqdYgKareR9Vo+gYjLJ6WP6rWc26bWdJnroSY94JYAYt1DCV6TBDEXTb5jZhzw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MRwtDjCL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MRwtDjCL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ7X471yxz2xpk
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 19:00:35 +1100 (AEDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-505a1789a27so32309841cf.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 00:00:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772524833; cv=none;
        d=google.com; s=arc-20240605;
        b=WfOa8nBrxrhbugIYEsFqH2gk9gKjtRCTxWai/dYa23Qg4yJr5PBrpXzlodMmwDADWz
         +hW0t4yRrWsqxCy7W5O3PjtVtxVbdI/IERjG6jzHDHmtdz/Vn45QZ+qrze/pRvNDOrc4
         H4YWkNnumBP+OjzprLyvuf8nUMkCAytQzRFNZ+CHtFg4XhDZo30MaPyAD/8lHFiwHANb
         TWUl7n0qoUIxrwNiVjXFG6HQOymY+dt6/ZsCEotFsC2cMmpHq1H7/WpJ5cd7bW5+ru8w
         /5PsmT86Z/pbduKXQDSyGTY/gXgrk0MPg0EeepiUEYA9vMYm/A22yx8jk2Vzfg+gFQgT
         4avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ESk47PW7WGBa7MuxLoGtL+kM3vhSegSs0lRtzlMgVSQ=;
        fh=QluyP0FdpeJFkfT67GY/InXbqh06tJ5tFVm1coXUHKg=;
        b=lSfd4h3VTTom/WoRzrSHhThOX283oVcAzPIGPN9ggeQQRVNO1wzb/9OnCqMGZdnUAn
         I/MeYIlg5XCPrgj7bd+PpD9ztUwdWrzsnFLEvWbAwAISpyhOBDa6hCbVKpH1sCkismeB
         ziwUUMHXL8eVCdqdgX+LB01RQv4IPzmwxvw5AkxeYFj0P8rtRpJd4RkJWxprawlev3ln
         lJ9fksPvwGWvFpnYHmtip9ltcvrJzEusDy83XQBu346KNW1SXB0Q31RKzV6lDAGFBDrb
         R9MkjZ0IaCZ/z4ZSzA2/YYTBD/zRCuId9JVWESicAiIRz29s12ZJiR7OX2MeReDpyP1k
         AhWA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772524833; x=1773129633; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESk47PW7WGBa7MuxLoGtL+kM3vhSegSs0lRtzlMgVSQ=;
        b=MRwtDjCLCcEYSCiiQG6U313Gk/WejvdEwiyn0DPjX+v/PT4i4bCixNYW2kykx5Cx+J
         mCX87PM8AoP2oQw0g4j+uNwu+ZFiVrMzMx5PrdSs9XMRKMpSDLKABuBUgdlEoo9kXuL3
         BV9vo6pimhUwZECkVZ+7FyoGVZmlQaGkPC9BSLarDbtKDD8JQy8IhpaEPDyh9uLYiDpy
         PE9fokrjt1DZ19oOoN1hNFYLGxfmfKIFwi0e9djkSDSSU6ezBzWdbImUGm2T3d3teZfv
         9gVuiV0YDjoXEQPjTuK9GT9g63WkPES0aGvfFirYQf0qBiO40gkC6A4ljbTBpDi18CaK
         Kkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772524833; x=1773129633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESk47PW7WGBa7MuxLoGtL+kM3vhSegSs0lRtzlMgVSQ=;
        b=HV4MZf01SsNivDbODMES1xdekCu9ZaDUMFemKfRkynW9gxuS/0sBVCSkb7s2/hkgzB
         39Tw7I1qC31WD6c25Ez8069kivw0pFhPHfQFw+vddg8mdp3wWWh2FBzhbIcN6LCr0duc
         Ojv6ysuf4ZAyqCYcZCaeHw/UYK1+D74puek4j+EgX75sLqKGnNuHONAJqaffLdzKwSQY
         O515qwemLtwbSyy/FGRotEjnheCYylfm69WkHNscTG2agFYNGspvxUGB4fSSX4KpIKS1
         KaK9vUNlj/HkIV5ONYGsPS/yeKOZm9U0KUlALUgfKhxktyQ4RgQZH50Za1yoeh2Ve/vp
         rrbA==
X-Forwarded-Encrypted: i=1; AJvYcCXgtSjECwAdOCeBWJOn3ZeHHjdZmPT5AknhLf4MNQvOZgsyD6VW69QpGgmQx7KWCks+VTliumhGRKWwQg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwuziOf5rWJCeizW08Rq1gqN+M+kdOzgSD3TtHtmgbVOQIg9qHB
	GvTez9mNy6MRqzb8gCGiEkDK+JTpsU1uV1VHmODYfztVUWHto8+JeRwte1YGWUXfizKZXe4A8Bq
	BmMmRrSIJRLtA+aFhRNtY5sxMQJLNlXk=
X-Gm-Gg: ATEYQzxn3lp1FXJAN1Mgh3O65fJFFv3LsknN2nniGmUIF3BzPm3Dp02BWOo8c1fI/Oo
	tjXjXfmrk3w3mrH4xKihjJhBN4UbPNmPYwAl0kzsgjuRS6sH8mWXNq+MHtfnJpZMYG2Rkp3rqOB
	GHtBkb7moTrQIpfGk8/silEXpvaGXRmnjZNHsVCgSrCiCHS00rzY6v+uIjoZj2Ted9/tbp61R2O
	e1SrZGSPlBxK3ZDFZgxynx5sDgfXRaUmxHka6/BaR78Kf6/RZDN2mxil6RJuXdChuk6
X-Received: by 2002:ac8:7c44:0:b0:4ee:49b8:fb4b with SMTP id
 d75a77b69052e-507529db97amr181608791cf.66.1772524832778; Tue, 03 Mar 2026
 00:00:32 -0800 (PST)
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
References: <20260302073216.94384-1-nithurshen.dev@gmail.com>
 <1415c632-7a4f-40e6-af3d-09ca2c02244c@linux.alibaba.com> <CANRYsKh4ZYYiJxd2S11crsyt6G57L_3nmWmFEp4iMQ7use0+1Q@mail.gmail.com>
 <165cb173-f8bb-4d80-950f-6ab87b58ceb8@linux.alibaba.com>
In-Reply-To: <165cb173-f8bb-4d80-950f-6ab87b58ceb8@linux.alibaba.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Tue, 3 Mar 2026 13:30:21 +0530
X-Gm-Features: AaiRm526Iuq8REnPsJ_57tD7sl09y3E4p0XUKpIB90dGTKY6YrYQjNN5pDmopaI
Message-ID: <CANRYsKjF9ck6v5FsVvvTbyUvA8xSYGVnUKNVFp-bon=oqS7Gng@mail.gmail.com>
Subject: Re: [PATCH] fsck.erofs: introduce multi-threaded decompression PoC
 with pcluster batching
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 4F9671EA7B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2485-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RSPAMD_EMAILBL_FAIL(0.00)[hsiangkao.linux.alibaba.com:query timed out];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 12:06=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> For the part 3), The linux kernel already has dirty page throttling
> and it will block the worker thread if there is enough dirty page
> cache.
>
> So I wonder if it's really necessary since apart from that, the
> remaining memory (incluing memory allocated in the compressors) are
> all temporary buffers and should correlate to the number of workers.

Okay. I will drop it.

> For the part 1,2, I think they are good.
>
> Also there is another thing about metadata/directory decompression,
> I think in order to make these faster, we need to implement caching
> for these, much like what we did for fragments now.

Sure. I will look into how the fragment caching is currently
implemented, and see how I can model the metadata caching after it.

Is there anything else you would like to add to the overall roadmap?

Thanks,
Nithurshen

