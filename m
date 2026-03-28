Return-Path: <linux-erofs+bounces-3056-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AShApgnx2kJTwUAu9opvQ
	(envelope-from <linux-erofs+bounces-3056-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 01:58:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EDB34CD85
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 01:57:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjJyn5NBrz2yfs;
	Sat, 28 Mar 2026 11:57:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774659473;
	cv=pass; b=ar4XCC8+bsWRWUs/FFMX9C3pMTmZUBanmiAXPDobEye0/ZVBgrT14Uw6Orrtb0ypKL/uM3EIMzCp6iZtLUNxXm8Yqs7ZrliW2aIIgb/FFGhhtjDJtLrAHwfZd5jo1YYBn9KqPPkx3Sq2MtNTkaGgLZQn6C978vEc9YXvEvsDkvl6HWsvejpT//PHmPNplAPO76JrQj3KK/irtVbNwkFjJRx1Y/707HGjJAdnnAKIrY2m39s1YGy0guc7w1nwF1OUxSHsOYnjhcEPRol8Uhu8gPP/G7RsNlVqBoS+z90MSRaNWPMuwlTyoWtg5Fu7KnO5JiA5agfw2dv11yjeYaYwMA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774659473; c=relaxed/relaxed;
	bh=dloQV6jHBr0/sURABuBnaOAzjjd8M2H2553k5ObKm0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh8HtqkJrEhZbxrrMUt6l94eopZ4NOJEHAnIDg27SBwel3u5lKQRhuiBQ1MVUu6aI5CS+ckiF+RLHVeb5vaXXGhPiJdECrcl6og7mlM6F+/3pGZDBD9q8nNzbvXCV/0gCbINvRTdR0vbzIvTRe2k2gRkaee9b3dc2jqmUMqLTXvsCUCVVgYymIVVxsQVKsbk8z0ag2fctPIjlasmxtuxsLc7Js323+rjUBO36i1uexoxvn8jgTODysWs2B7nS81Q1XsgyPgLgQX+pajtvzahf45ONBq2uypNrO2JiWeRH3wBB5CETVIhYh/lDB5jrxcMGzXFjEcE6XyQgaStBU1AcQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TVzlFJTe; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TVzlFJTe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjJyl6wHLz2xNT
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 11:57:51 +1100 (AEDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1777060f8f.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2026 17:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774659468; cv=none;
        d=google.com; s=arc-20240605;
        b=R5imIiafDGz7T0uwwBaJkwNb3JcVDzuERifxyuT+0o7kOt93kiaKpehiF1Ogwb0MWN
         X8U00UAevnnlbXwWUAQhSO2De7+HY70cj3yM7rK+2Lw+lCO6hEiPYk7hXKBXTjJWg6Sn
         NRlSIiJIL/Iksbt0eHYIy76mgabMpDWfg4g+WaS6k+HtCxB4qC+0wUmeqCosslJmLaN9
         ZRgUJnnS47WstMq5y4V51ORtUITMWKnYlXOnXnomYP0UURWv5tpZcHQIEjdOpRe1y4EM
         VWdfECragvW2Loa1SK4EAvjllRBZUxtdVqvbb54Ic683RiFbUQ0ZGTO8h/Yf0Mi4g/zG
         Z6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dloQV6jHBr0/sURABuBnaOAzjjd8M2H2553k5ObKm0U=;
        fh=h5v5s3sJ8JjoTqamOMCLh4C2o/WjoTYr0jDIbqH17R4=;
        b=VqzegdgaV+9npSV+23dw6z+ThBgkWDDY+m5l4kb/lWoTNuLgQctiRyYpg6zOixi80b
         n9aBomDUNTW1CF7TlCYXW0svn4MOM6UYAmvFjUB2eDAEWv61hjoTp0ZY2hXlOM3a2S1v
         TjOOCFxRntCtMP0da2bDplRswNasK0GO8ximPxCZvHHKpkvGAWwDmNfJOi5k219/HjJk
         0E+HgR4WA8tT9iZ2C9m2gVwOvZDrxUu2cn3fQNZmwp7Qgb7iK/mZgY/QSLzGuzX0YVq+
         kZP7gmQusdhYSpZDWAS+1b7OkQ7Y2GKqjPZmKc7mjXOOqPdRMmQ4zfdTSwgndd7YtriA
         I+EQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774659468; x=1775264268; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dloQV6jHBr0/sURABuBnaOAzjjd8M2H2553k5ObKm0U=;
        b=TVzlFJTeBtgR5o6pKCKV3IIRvgT1d2hF8LJwG/vT9N5KdTlZ53SX/NOefZLUuZbiDp
         nctGZlf/X8Rd3OHRpBgNBZs+V0KWXwZ/G7AOlk2xRBXrvaYzoczORVq819tncSQcmeXV
         s9EA/gPyFHNdkEIBFK7Oozz8AN3lYmqW/ywTmmgEyhcmr+Xt3aM5U6shDN7qX5oi/k7D
         CzOQc+VwpWKxooDuwgiLxeDi94dkevxX71MmzWqmEoAcRIMZw1/ZaPVWy/9MQdzD1Uxb
         c+IWqAH4Rq9REocGd17qBCFAJfHEnE5qRjukUkCyea5MfjXVQoLTGF2jb1Rt63ivGHng
         QIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774659468; x=1775264268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dloQV6jHBr0/sURABuBnaOAzjjd8M2H2553k5ObKm0U=;
        b=VRMQV17+J+lSVHuLWF3PWMIUQwp0Y0x/cUuetqA4KtW8egY7LkZyWN3TSwuR3J7Rc9
         u+AR1sFnI+xgudyd3FS6V0Ifvx5qvRya5y3R3Gfl4dZKvmP3yDcIa6NezzPca7ytPuhS
         QG4TsZjNY3DBWyi1XzzoyqTktMWSTBTwxfabzbupI0Hs58HwTvNTXg+zi0s5WAYE/RnI
         7dlItmbsFpNwOFyU3eUMpf0iKt0Fh9jv1FbKqHA91f7TECUKC6iUeUIApIUqamoT+jnG
         rwIAG2ShCYuZBgoyGhEF+j72IrVYlhDwZQGBqUteVYGukz0+21VHl1ghbWXi4W0Cz06n
         b4Jg==
X-Gm-Message-State: AOJu0Yw/jB3KcNO+/yLXFdySzkcga/Tgr7NP34RIZkKAuErz+Laj0ZK/
	yce35RhleLmSlDjIBoOtwO3ebBXRpXEyRXm+nWk3b14116BTQ6UKtVjHkkBYWyOJ/BWyAVm0hws
	sLyJkdShOEwEMV3+y5dt26pu6wm/viNE=
X-Gm-Gg: ATEYQzxs15qjopbbVpc/m0DAcLgH9zc4XJyANk/Gv7g+6r9x+I5xiD50kjV1984xuUD
	Js6kOJJNkOkKeQKFt1eib9zL+IH/5QMLH+aDnyb/KiKRWlzUkfkKld9uECLqRivx4AR7tcOGVsW
	CCs3REz6l2rdn9XnosLqe368bqympKx+zq2u6nNd+a+ZMsWBaRFb+3ca65woHzNBYcTtf6WXdy/
	6TBp8xQadjblVtNzuYl8b3l4NjWO6izt3/62sZZmt4aVyY3WiydvxrgLqqogGmnkbencaj493HB
	UloMzG0jxElUOLimA5xxw2cmnwppGl0CxpMMuxrQ
X-Received: by 2002:a05:6000:2406:b0:439:c550:d920 with SMTP id
 ffacd0b85a97d-43b9ea77410mr8137116f8f.47.1774659467530; Fri, 27 Mar 2026
 17:57:47 -0700 (PDT)
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
References: <20260326103254.32152-1-ch@vnsh.in>
In-Reply-To: <20260326103254.32152-1-ch@vnsh.in>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Sat, 28 Mar 2026 06:27:35 +0530
X-Gm-Features: AQROBzCIv_4XRoltiezRAqadiouBKvf112O0FNVXsvpc7IMSHdljLlbgdmYHPSs
Message-ID: <CAMhhD9iL2Dj_ViKwmmOTUi=cx9ppuWter74UZsmwF=ogeVKRzA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: tar: fix multi-chunk metadata reads
To: Vansh Choudhary <ch@vnsh.in>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3056-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ch@vnsh.in,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 14EDB34CD85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested-by: Ajay Rajera <newajay.11r@gmail.com>
(Tested with long PAX headers via mkfs.erofs --tar)

On Thu, 26 Mar 2026 at 16:03, Vansh Choudhary <ch@vnsh.in> wrote:
>
> Advance the destination buffer in erofs_iostream_bread() after each
> erofs_iostream_read() call.
>
> Without that, metadata reads that span multiple stream chunks keep
> overwriting the start of the output buffer, which can corrupt PAX
> headers, GNU long names, long links, and other buffered metadata.
>
> Signed-off-by: Vansh Choudhary <ch@vnsh.in>
> ---
>  lib/tar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tar.c b/lib/tar.c
> index 70bf091..77754fd 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -250,6 +250,7 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
>  int erofs_iostream_bread(struct erofs_iostream *ios, void *buf, u64 bytes)
>  {
>         u64 rem = bytes;
> +       u8 *dst = buf;
>         void *src;
>         int ret;
>
> @@ -257,7 +258,8 @@ int erofs_iostream_bread(struct erofs_iostream *ios, void *buf, u64 bytes)
>                 ret = erofs_iostream_read(ios, &src, rem);
>                 if (ret < 0)
>                         return ret;
> -               memcpy(buf, src, ret);
> +               memcpy(dst, src, ret);
> +               dst += ret;
>                 rem -= ret;
>         } while (rem && ret);
>
> --
> 2.43.0
>
>

