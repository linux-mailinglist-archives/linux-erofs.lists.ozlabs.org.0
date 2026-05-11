Return-Path: <linux-erofs+bounces-3394-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCE8HWGLAWp4dQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3394-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 09:55:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B6A509A47
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 09:55:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDX7v1kVZz2xlh;
	Mon, 11 May 2026 17:55:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778486107;
	cv=pass; b=P016KM2XXZr+ljRrgqm6/n+HtZ2aRfImZ5EUx3S3KrqfTFmz7dwyetkFbu14qmpKExYWP9uHDSHMBprK/dF9G+iSrPV81J/HtP5Dq+rEG+4iAm5ntCrN7VNdfcxUAf7rB3bV/ARoa6j/xd+DqM5MnR2+8O4nfNKJNE0gJt3tAltppLx72zNtVegyZyN36v6mszXCT2YHqGClXM7wVeoiH2etlbxzcnUPccvWqxgnn77saQKP6omcjnyHXgxKexf4e6Ja/wJlskKI2gDkqHLAOMVxApjPve3PbyBit5sqOXECLuU/eJauJ6rHBZ+8wMWRXZdK5/72nRBDHmtYjRfYkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778486107; c=relaxed/relaxed;
	bh=YNqC0EP+ZRlEgk4a4W28NKoUpWg0qHx/wFMvisS+PHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN7MRYyYNjsj3IMkSwaHFNztGrLTT49AAYFgPWQyvWl7AcakYcG7t5SUvA38rBG7baPHD3jZjqjSfDf8oVZpo3YzDslPJ7doaJ06nHDiQ/DAucfbWxMpji/RetyriK1LcCFrrMHB/HonXLWRzxK+Xgt8xZ3HQjYrcy5F4B/TjVg6D08d2xAeebETvJCdYzmOa33Pv8KiJA11Dh0VIq0HndLnAb2P5LfxwGbJIPxi9E9AP3IbFZDj4mUnFo5WIUNlfxQgyt4o2wtAdX3Ncduk0AM3x21N2RhKXFCrTLL3poj4KaPxGfyTDK8U6UnByhy0/gNt7vXGI4F5XB7jgzbGAw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bSiMJYFZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bSiMJYFZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDX7s2hWPz2xl6
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 May 2026 17:55:04 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-4462f8d2488so217312f8f.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 11 May 2026 00:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778486100; cv=none;
        d=google.com; s=arc-20240605;
        b=JRSnpdi+TzMQbiSjqab6Av9Trh94pDgl8opwo9sBVM/I6XNhWOUfbJnTLdRZtKfBRp
         6DdWbCvZu+76hpyRIXWlXTLkfwZqLGuCx7maE8BtTn72OGjjGC+kLuRPm9omvpPDY64D
         cziLfxV5mUg+kJvYqgILArFKuWJ9WVx0fVitDfUzymO1RTUpZqgHKEc6LpoFq3NIJyEX
         PjPxopzDmGxp1K7kbNO+oYseCaG45eKj++9GXBIO0bvkjJhLI3K8mntPgh5X/N+dPTx7
         PWgEvwBS0G6VXI2X827Te1r5yoTi17o+sw4qZuWxpMWXqJQrNCSFVG6xT/AKxKuC5Y9f
         j+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YNqC0EP+ZRlEgk4a4W28NKoUpWg0qHx/wFMvisS+PHU=;
        fh=BwaDHfHo1r9w1U6Ph0oPGq7gGMKW2P5Yrymmh3BjFzs=;
        b=BumK6CaWZKxvIHL9eQZBhIOXMTz4NiIPiW2JIVAeBNaNREAZp6sYWFpObs/QrTl4t7
         JEzc3R225MX2wf5/R6ikuJVrdf/oTaklj0kXOhFh8MFuAGwX76R6kKAz5v8tVdW59K2c
         /QhIxZJV4+pL7LlftneW+Rzge0NC5CJxMQrKiPk84bRyJTDt1kwa/+G9DqiEsJW4uNYx
         wAFSwGQIDVPcShgjU95U6PMhzVVidNRkWYTIS4TfFhWIuBMA9F/WtK0210NHHtqJ90rK
         ihXh2ZfwDhE2fl+d+3e1HQnwFa/1WNUb1hClSzH7VdjOnQKO+I9E5UxIGZlPtfFIhd1j
         6CRw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778486100; x=1779090900; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNqC0EP+ZRlEgk4a4W28NKoUpWg0qHx/wFMvisS+PHU=;
        b=bSiMJYFZErilHSrtfDn5ZqAx32al1Mluhn57tN+KwNAFdAPOnqAGJGMOW1Adk7E0io
         RexXIHyD44kqZlffBEqBwcyMSY2eaB2XZLi2Ypwe7F/9SN5P6HLqHql9WJMflGkZspbh
         NuJZwNrC3NaHq6ipsjtaotKZu2tH8jJGrYS42/yvklf3/oFuAe0yX3GmxbzjuplkBQYr
         HzGcEcpHtSFhgkks9HXqZnB5k1Z8LVZPLIF9N5GVIM0o6CgWsM9YkyEZ0HLHCQjPQU6O
         ch/0o+kNVqPDcmcvEW2ebo+y/SpeCB36dkL22wEMGCAYAUOvkLaitsda9EBwOp3Go7Wf
         ujAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486100; x=1779090900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNqC0EP+ZRlEgk4a4W28NKoUpWg0qHx/wFMvisS+PHU=;
        b=fVWZTJOrfrxEnQ2GQ5a1Boqv/9YJWemroB7QA7IfiaCHy7u+7GT9Zh90ZDSkfDbfxf
         UAR5Za8x/jR8nHCsx6IjJq9s3AJohSJZjYIqtw47DO+MeDVJVMH81xvImc5QSQSzBzFd
         ZnohD8FpFow3o4wY3i/CiY3BlFIDOqJAj/QnT2o5okcm4RgYsK5MwJtmgyIXeauY0R/q
         c6Ztp8pABB8h8Mfac0Tp/GPOyRA5Q9dWkIzMe15xq7ArSLO84a76j3Y+l6t/GDebD/yc
         ShtuoNu0/z6O3E/2JApilzyjCk8SRaVKd5H2VecSvjOCxsrUWdHGPdwfxJ5SVnq7Yo4c
         5AFA==
X-Forwarded-Encrypted: i=1; AFNElJ/bMzV2yMm6Zt3GGek0I2/ldWVSxBzH/xHCOuBIUxE+I4HU91zFGZz4yR2sl+MCuvC/sdCkiaIPh8giQQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyll36Yntdrqdzy/rTZzIosiEQAgFktTEwTyMhcCxJkxWlq+imN
	4AfvoaCJZKhyx3uPBFaaSUsNYzhIDe0e9wHXsz5k4dO9m54jXzHSA7Fll70YyFEEW01722yAk56
	cKRBU4Gqc/GTFAXR5aL6KGkGnQoyDJ1tjAg7X
X-Gm-Gg: Acq92OFPT1emmkUR0rLlNdOYtPvV5UJD4tdL/mMlfoGcBjhAYJ+1VTXamb+RTGSrxGV
	BWZuFG2ySkBt+llEF9v/PtJrYqvclYRBwq7cfF4rf6Plvyyj70+IcOJLsct9iRnJZO9le9Vl/D7
	6Xf7/b1hUQAjn7W+g0XOj9kRbxv1gwYpKUIijuNIppP49IlbJPCB5mEctIkxgZUZws8ufwrixBf
	pn6EOnzlQa40zaoGTS1IOdta/nzRWLWIRpJQ4b523n5duGaAnxLkC58OjwOKddeS0DoH7TVCG+D
	YRLeHRjt
X-Received: by 2002:a05:600c:4510:b0:48a:79da:c87 with SMTP id
 5b1f17b1804b1-48e5310852amr163508065e9.8.1778486099468; Mon, 11 May 2026
 00:54:59 -0700 (PDT)
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
References: <1777449565-22154-1-git-send-email-zhiguo.niu@unisoc.com> <e4701c42-1ed5-40a6-8f5d-927c40e3856b@linux.alibaba.com>
In-Reply-To: <e4701c42-1ed5-40a6-8f5d-927c40e3856b@linux.alibaba.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 11 May 2026 15:54:47 +0800
X-Gm-Features: AVHnY4Jb_0JDSKw6pa8ZCQB1Rmp0M9WRYFhGbiYcWr7Fr5PvDcaZ0fUEG7DBD-I
Message-ID: <CAHJ8P3KB02f2dTWrMXtyBMQwfqmFEeOwa4SW8CKL-rKrE=Dg=w@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: also handle last compacted 2B pack in z_erofs_drop_inline_pcluster
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, ke.wang@unisoc.com, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 04B6A509A47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3394-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:zhiguo.niu@unisoc.com,m:ke.wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,unisoc.com:email]
X-Rspamd-Action: no action

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=80 12:01=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zhiguo,
>
> On 2026/4/29 15:59, Zhiguo Niu wrote:
> > With ztailpacking enabled, the current process assumes that a compacted=
_4b_end
> > always exists in the compacted pack. However, in some specific files, t=
he
> > compacted pack may not have a compacted_4b_end. This leads to an incorr=
ect
> > modification of the last compacted_2B entry, resulting in incorrect mod=
ification
> > of its clusterofs. In subsequent fsck operations, incorrect parameters =
will
> > affect the decompression of the penultimate pcluster.
> >
> > This patch determines whether the last entry of the current compacted p=
ack
> > belongs to compacted 2B or 4B and then updates the correct bits accordi=
ngly.
> >
> > Fixes: a7c1f0575ef8 ("erofs-utils: lib: refine tailpcluster compression=
 approach")
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>
> Sorry for late response.
>
> I do think the issue is valid, but either the previous
> solution or the proposed one is ugly.

Hi Xiang,
Yes it would be ideal if the same piece of common code could cover
both scenarios.
But I haven't figured it out yet, so I'll distinguish them like this for no=
w. ^^
thanks!
>
> I wonder if there exists a better way to fixup the last lcluster
> type into plain instead: I've thought about for a while but without
> any valid suggestion.
>
> Thanks,
> Gao Xiang

