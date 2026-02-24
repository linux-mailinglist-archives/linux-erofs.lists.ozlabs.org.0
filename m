Return-Path: <linux-erofs+bounces-2394-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI1kL6HLnWnfSAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2394-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 17:02:41 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C88189805
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 17:02:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL2YP0WWSz3cQx;
	Wed, 25 Feb 2026 03:02:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771948953;
	cv=pass; b=MYSIStLwX/SoVabjYsF7Ee2gprJZt+eAm5eTM59XAkUpGbYZl8humzUEJmS3Ovx6Q4OvvvZooebPmUTVpYnp/sK93wUKfDoPR9km0oKjLr0Vrw5VWUYhC38Q8LnofpchgeRiOcndQlk9z/WPpzZgNVML4Z0fwABFswy4yqUCBMS0Wg6YOey/T4KuF40m7j2PHQb3xwHrog23zeiMLT/tC6EyzVFb9Z0Yl5VlEye3ejZvxgnAO4Y5zX8Se0AA2lXBBFAAcEjc90boeSjPRrKBweYi9sxWPyGx3qK8Shz/Plg4aAKx6UUl5wdvlbWp08+8XMazL+e9Pw73z+lOwiQWtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771948953; c=relaxed/relaxed;
	bh=ZZLQarMW+APf5h82ACNvkI1wDkDO3j4DBzaOQiCdwzQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=WBR4OZ1RpvPJ7pnAbdkGtJCjemx7kLLIlgfPqWfwtuNPZFo5f5Kw5QH5X+V/KMMNQEpe4tj59MBeNjVi/lMr0Tztbj2j1FOsVusNTDG9tDxU7mMQuHw/E3qdBm2pH33iLYrZztK9uR73VZNbmoTMDGMgfRUOOlEjAjs8HarhH1ZLPgiH0nQPw1B57mWUmbQ/mjvfndG+OVRCAgWXVAkCHyYn72rHl6+09XlACV2GbKdOf+ZbSqEVhVAtUNbsgjNOaHK+68JP1AsXA8nRkaNb2xTN/CN/O6LbzwZ2rgW7Kh95wM2Bm1OjBLhmVLxqBi05oc/Ran5vIkqD7ws57FzJrQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=ZeuEhNfh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=matthew.lear@raspberrypi.com; receiver=lists.ozlabs.org) smtp.mailfrom=raspberrypi.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=ZeuEhNfh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raspberrypi.com (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=matthew.lear@raspberrypi.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL2YK6T95z3cQq
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 03:02:29 +1100 (AEDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-506bcb23a78so50505501cf.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 08:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771948946; cv=none;
        d=google.com; s=arc-20240605;
        b=Af74m4eIoU4JRZuOK9E3IxJ/1x2mhpohiQKZzfhqcm7TQdEWM9p/tnefFgEoDLfSAx
         YkByhq2OZwVa2qFHxRPChY85NJ7A6zduLATCuDV46IQVPhXuejdEHQ+mVXhnVddtrSBk
         0zlNBLSnodROsDnoxdb7H6VGGam5lojrxAnNlrT2VV1rw6NTnXn0KCktIko0/Od2T6UJ
         HNeRFqrMBAtCoG7jaEKF9aUZSJ7IrIc15GvjHwgI/M43mO2J8xknBiRmQ4gG86xIZFiF
         YTGvYYVKfimGmNWY+ETyua7rJKSi712HxWmIO1I8LkIem3z2zwSlA/qyzA5BlVBoVHGS
         DV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:user-agent:references
         :in-reply-to:from:dkim-signature;
        bh=ZZLQarMW+APf5h82ACNvkI1wDkDO3j4DBzaOQiCdwzQ=;
        fh=0H16UUzLYVoNxSfuZc44kpzYxgYuOp+SU4dGQtODrck=;
        b=eN6CVJSA839DshUxP+fnvC0o2ptA0jwo7aC1Sf9mmwwEsUY6b7UAL6OlXSEz+Ql5tt
         +vLp5AJVjrof5PCpDNAk5AfE/TMaFaXUsuVz2RSMoIOKn78IiFabbkSkRme2V0RqWvFe
         Ip6L5Xi/thl2GfdjgD/hLfhL5jvplYeh0Vx4fJMO85lqxwMXECQ0ntk2UqlIWguthzZ0
         Y8+CWLCbfJRYHpw1Oj4HygPjnc2bBjErCNJwsbE8KgOiy60UHpbFdf4khXpEgXXvOO/p
         wPfNTz1Ey2h8+hh+dyH6zHE92pSw09N8p9KUmRj8ue7BdwLp0IEkoh3bDvGpRbEgUqKz
         YHLw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1771948946; x=1772553746; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:mime-version:user-agent:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZLQarMW+APf5h82ACNvkI1wDkDO3j4DBzaOQiCdwzQ=;
        b=ZeuEhNfhWNClHnXp8TySLb6qorl1H02rJQ87k6SHAPzcw1H03MelvA8GrHeN8HiSxs
         WJo0ozeJorXP00JHJGp4eTlOXkOVEgp/bCDllGJUZ4fH/tNFo+ZOuNqhafQtJyKvpTpu
         nutVENcXSuGz9WBoR09rELvElsXv5KJw/cm4wHvJtp1noz53P55NPbEnBCBdRsMjxNCg
         rQyVH2xfTpKMfkwVQWrXp1V49s/xiMnNWPjbOe2Pu78BDwgFbqV5F/rNqDHQnAXl+8b+
         DYz3sxNXT0Um5KoTsdbF8ETNKXDUvx8LgQpEzov2dyfyrYseBNjXr1M0CX/6mCaikCG4
         38aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771948946; x=1772553746;
        h=to:subject:message-id:date:mime-version:user-agent:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZLQarMW+APf5h82ACNvkI1wDkDO3j4DBzaOQiCdwzQ=;
        b=WFJj5xTryu5YvlUMJnCB9spCgi1lahrzc/WVOqGAuNDlfvsxquG4a5bLGd79wXTsh8
         pJrb8STFNXsvJ1Wgn/tnHLDjRQAXt/TW4qyPvr/gjzMNBHlJDXDyy4YNifP++MdfKztL
         BzXN7U+PnMl7VQdK9cD1uFXO/PJnZO4iM87kBD1j8pUueEgllrQQv3N+crsjeEDttKw8
         oOeIir06eor9f+e++v1ytPf7J0w6nXBdOAEv/9G0ggBrL46de8dWCxb80bAXc9lEvu/k
         SQV/9kKEPuzFwNG9RYFYq/K23JWuew9hVQEty12hc6G6tq4s2HEGt/h0Geh7rifDzXcr
         uM7g==
X-Forwarded-Encrypted: i=1; AJvYcCUQmXjMgGs4Rw0Y8pweqTwkysZBPPHKTDJGqk6Lz2uOHSRsGin8/EhVbJSX5I2HHn2IRJdycoIeF9RaGQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YywFFg/IMvVJnyteUtYbbHKIp27NhQz0KH2DPUuJSys8Xl/CVxU
	ChED3gPyHKN7btCSmHN0pjAsSyVXlHtwzJJnZvzLyAHOhejcim9W+tygscT5u4lBLgf+yzXOQ52
	kqcVXxp6j9oxtyiD1EvIbCAEu7+Q+5T6HMubtsl4LSAGzO91JDNo8
X-Gm-Gg: AZuq6aLJkQPdrAWlqZAPZvBk+TFS8ssqraIXTam/Bl+0qdiVEmENv/gqW9GjHHLiQPh
	9wRgR0Za3+35jq4ytP4CMC+LTt/R8ahkpEH6Kadz15Gvnve1BLXpn84XznpaeGjLwUsPkvVoF6H
	xX001n+9zdONs4tv6aNqCbtVIg/19VIq3EtxGQOkSsniVHWF0cf22UJySj2caEZZReoS8Rv54bh
	s20JeXiebr2fQLcB8w4IqOgheq/rP5kmUa/sdpSk9JONbngVHKEKWkX9sW6AaEuLRaHLI4N5CbV
	O8S8UnOT
X-Received: by 2002:a05:622a:1113:b0:501:3e36:1513 with SMTP id
 d75a77b69052e-5070bb8283fmr171293691cf.6.1771948946005; Tue, 24 Feb 2026
 08:02:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 11:02:24 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 11:02:24 -0500
From: Matthew Lear <matthew.lear@raspberrypi.com>
In-Reply-To: <feb908c4-5e9c-4ba8-9818-6b6b66e9b4ff@linux.alibaba.com>
References: <CAPrOGNDb=Y1yt_m=NgMSj01Np0yCDF2TYTV_dY_nV585=eX6aA@mail.gmail.com>
 <feb908c4-5e9c-4ba8-9818-6b6b66e9b4ff@linux.alibaba.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
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
Date: Tue, 24 Feb 2026 11:02:24 -0500
X-Gm-Features: AaiRm52QJVlBJGHA1I5QwDkxM7IlGg_tl87ok-dJBKt4YEXC1QHvPj8CW5Jopt0
Message-ID: <CAPrOGNDnCBYdUjOiXBiVKSmLcPW_jxZbHXLdgMgj-T6LnXo0ig@mail.gmail.com>
Subject: Re: mkfs.erofs: should MAX_BLOCK_SIZE be tied to build host page size?
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[raspberrypi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[raspberrypi.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RSPAMD_URIBL_FAIL(0.00)[configure.ac:query timed out];
	FORGED_SENDER(0.00)[matthew.lear@raspberrypi.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2394-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.lear@raspberrypi.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[raspberrypi.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 07C88189805
X-Rspamd-Action: no action

Hi Gao Xiang,

Thank you for the quick reply.

>> Is there scope to increase the default block size ceiling of mkfs.erofs
>> to 16K (or perhaps increase it to 16K for aarch64 compilations)?
>
> I think the reasonable maximum block size for EROFS should be no
> more than 64k.
>
> I think we could consider set the MAX_BLOCK_SIZE to 64k for
> aarch64, but leave it to the page size if `-b` is unspecified.
>
> Would you mind submitting a patch for this (checking the target
> arch, if aarch64, set MAX_BLOCK_SIZE to 64k instead) since I've
> already had a bunch of other stuffs.

A change in configure.ac to do this looks straight-forward enough (I
think), but there may be justified concerns about the knock-on effects,
particularly as MAX_BLOCK_SIZE is used in various arrays. With 16K (4x
today), these would all increase quite a bit:

lib/liberofs_cache.h:  struct list_head watermeter[META +
1][2][EROFS_MAX_BLOCK_SIZE];
lib/namei.c:           char buf[EROFS_MAX_BLOCK_SIZE];
lib/dir.c:             char buf[EROFS_MAX_BLOCK_SIZE];
lib/data.c:            u8 buf[EROFS_MAX_BLOCK_SIZE];
lib/super.c:           u8 data[EROFS_MAX_BLOCK_SIZE];

With 64K, the memory footprint would be significantly larger.
What do you think?
--  Matt

