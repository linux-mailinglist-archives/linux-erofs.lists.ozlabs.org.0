Return-Path: <linux-erofs+bounces-3080-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o2apOLGJyWkizAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3080-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 22:21:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE74353F2C
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 22:21:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkQkM5L6zz2ySS;
	Mon, 30 Mar 2026 07:20:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f2b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774815659;
	cv=pass; b=JSoVAMScYJc3BD4wr8k6eiGkY/ocji5Awixp7cPCRmRt2sbqkfNqMe7mPohioTZbDJwJmcxEOS9tHinJcxDbBERsUe4kLnFx423E/OIcnm1/aL/dnVP0J/3pTKZyW/EFhmTeGOv3wC4aHdUy1EVO5OazFj7j1fZvkH7V31IHZt3DJKZeCa+2c1NJBp4dLh4wEwIl/Uike5yttTC5vtA1/N7B8bEICpaGZo/o6anAZRIK3D4avESsdg/LT2QOGodSURr7wBlEN6OqiYIsLBTHKYwjdPATvgdVksnkdJ498L+iGKjIiPmuvAwpEA/AHWf1NSq8SlyqjMkLMe3BUjaoPA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774815659; c=relaxed/relaxed;
	bh=PYIbwdRMoDwNthfiPn7BPnZbdW7bcaQgZux8jHGwFcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtWiOoLp98FP11G4oLNfgpVA/PHyCfSy39/36a3pJkbjEeAH5QvQlb7d+eM5CY5xscwq9obJgupuCIBJ3sJiSond1AC4oZCz5whjHlr7cclBsEHjVnbkCv6OifyuKTTK06s+xC+Itb7ybnn6GPOU5TXS5YcPGgbfjm4UIMvwLZ08wROhO5OjIG+7fwy9ZRzMryvMIQ2kz/WFfKTLuKuIsuWNwAkZUOt8y5HpeOfsCwwfzf7DGLAKuRmCfZkeLs0rpZ9zcm8pykj34XNtbH/rXFixFk/lXh2FU8q3L5J4etTEHXa0ZDAXyy1J/Y9hbZ8cjOHUzoFlHgOTgpfRU/bV1A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tbl40bzM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tbl40bzM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkQkL08txz2xQr
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 07:20:56 +1100 (AEDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-8a0b8b622c0so1192776d6.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 13:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774815649; cv=none;
        d=google.com; s=arc-20240605;
        b=SRBn87a13+WoEudG7Bq1m/A/iTo1lvM53x+FPD0SreFfI29Ta8JhiW/wpsakMllk7h
         M4Ntbf6UmEbRV/U9JszxsEqsDdIn9oWMLtwZ9iKbp5zou23W8ARQaCcaiS9anyU9jzs/
         OzbLkjRpcW3JhWQoPhG5ovExyLo1zcSSvd/A9y2yxHw3cGZHosWidhGT0OjMPavgUJdT
         g9JtuQpt3r08zro6d9YbzhYeMVzgSBEB92x3fYKO++9V5GTiAqFfzgqhfoEYhBuaPfyo
         DCg1zqwgn9y8+XpWTS8emC5rMqaRdSXDUd7+mWfTQ3gbfcqCq6bSLWkxR9pTHRFtCfo8
         g2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PYIbwdRMoDwNthfiPn7BPnZbdW7bcaQgZux8jHGwFcg=;
        fh=vaE4vsNMvoVyR/yn6s5czqZsrgG483cxb6FYahihPWQ=;
        b=EcGmPgUEiA9CfVe6J47fLBnmG9ijI4dzYEHWAMStAw9bIGy+bmQzHqQXsqQwYN9mi1
         kt93FdFaxg2A5/EjmFxy+ged1WuXETZuAUVyG2sj1kZ2GgID0KIyWPuJq/ZJWwdl9GkQ
         TUPSm6eH2ztLmBQPf0S74eunRJFFukLzYRgisZC4EtK+ZAvtCxFxjRmj6p0s1jb0P8+1
         JNYasw9cOS31+79xoOfd4QBG941k6XcAnIbJ2+G97KjizQIJTUh5iW3fVbqTOaREkMMq
         EXnAadfTIlBqP6/ioTyyKszvMvJeyAHaToPe1mHobpR2PdIlbKiM1TLmn0EGWGxugxEk
         IAyQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774815649; x=1775420449; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYIbwdRMoDwNthfiPn7BPnZbdW7bcaQgZux8jHGwFcg=;
        b=Tbl40bzMv54IuwXxxWmkJgyJKl0IB+Hudt9beMljiiA4xOQ9lbrpVQLW6fVO5NeGRf
         uS0Gkzgj0O3FJDHZjgsyHaLIHtWSxoa0nzdSNyWD/1zjKpsG+YYznRe78caj4mw8AzrB
         4fzESHa5jFFGUjWkW4qXAAmAfp8ZsuXvl7PqF017LP03FDRLAVXfE3RBuM84yn0W1LNT
         lAuexpWVQI3y9P7GrCDhERqicAV5xywNQSpQ6j0GSxgKdaf1+0WjQuftqin0HHncf7Pp
         ynDOSLlRhLSa5e362UxqSHeOAbSfoTRycs7j4luRnl/N2458UKLIhn16M8498GeX/rl6
         +z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774815649; x=1775420449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYIbwdRMoDwNthfiPn7BPnZbdW7bcaQgZux8jHGwFcg=;
        b=IqYmVmfIzSLJZL76hMhHX7c3uYZmzJEPV3Yc/DgCq3rd3yHPKykhyvrTSBRKWKMBFv
         y3ty12OAvmQH9BiO0Y4FUEjQnyYpnTiDvzG695/zKqefRhQX8CUOqvtV9pGo2PjiWS9C
         l8+zWL40I5chxKOY04vdYLTjo+AJ0u8MhrrNn6jMjFGacSzBTJ+NI3OMm+ZRfalVCKYc
         BnrMCBrmvtQmwlCpz2h+FLG3CZw2IJpR8VyAX8znUIjTUuAmZcpyNqLJxxicYTyEPCnf
         YGm/ZmG37Uz+LekZq4Yv3lPX6Dk/3UbP8Y2NJhkC2LmtAqnE94D0s9Xe2PaoaZ8N2xW3
         SHAQ==
X-Gm-Message-State: AOJu0Yzjkt0MsnajH4THbrY8SphTFI0RwVsdzrsBeCSRqLiqHfcniJno
	f+XJwA1ildwGR8Nru6McUJPv7/NJ2KcCSugt+83h/+kKBajmigR277G8Iyyef5X7nTkZ11H8CFK
	wr9NSY7nHzMHi6YKBnYhIrI5WgjCMU9o=
X-Gm-Gg: ATEYQzwv8ACGMyzfyFJ4oVEmC9ytcih+/etEobLCukv8Ne+TzvejsfSdeE4WZSgalbg
	Hg/aBSm5Dcv2bWAWoqWkRjb408EXgX/CzX/NAJP+4LypqAbkQNSGxFRhCuS/dJ78BCPR4uFrBYM
	i5qORtjVsc+UCzD3cQvVrmDHLLtWHoc7rwuxHjlcdMqZwOwLSd55JzL8HPtF45yCM2dWUtc/bV4
	QMoJLWbzl3gU8BRBSGEeM5g5vmoNu6SmX3v3svTbWssIFNh1Hw2pt/0TYOcYIqyC9V8RqLa1fLV
	GPrHqB7kijlAvc8IPfb6dAWj0WvLzTGQkKorhEttl0TU0sEU2+BolA4r/WSA8rMon6pUs20Nwfq
	E1Jcr
X-Received: by 2002:a05:6214:5910:b0:89c:ed34:5653 with SMTP id
 6a1803df08f44-89ced345c0dmr113296726d6.7.1774815649058; Sun, 29 Mar 2026
 13:20:49 -0700 (PDT)
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
References: <CAHf8aCXHHLFCghBEy4hF+DoDpYed0yOafvKbdbmDgfjRC2Lfww@mail.gmail.com>
In-Reply-To: <CAHf8aCXHHLFCghBEy4hF+DoDpYed0yOafvKbdbmDgfjRC2Lfww@mail.gmail.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Mon, 30 Mar 2026 01:50:47 +0530
X-Gm-Features: AQROBzDsH37HIyerZVpzudGwH_qUJLnaQNW4fvVWH4wvBZz78_9lyyWREqYCvFw
Message-ID: <CAGSu4WOLGADT4Z+iEw33K1M-1F1Pgu0aHBwk_8R_2tbee6k5+w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC_2026=5D_Multi=2Dthreaded_decompression_for_fsc?=
	=?UTF-8?Q?k=2Eerofs_=E2=80=94_design_question_on_z=5Ferofs=5Fdecompress=28=29_parallel?=
	=?UTF-8?Q?ism?=
To: Deepak Pathik <deepakpathik2005@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:deepakpathik2005@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3080-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,b.tech:url]
X-Rspamd-Queue-Id: 9CE74353F2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 6:47 PM, Deepak Pathik wrote:
> for LZMA-compressed images, are pclusters in fsck.erofs always
> fixed-size and independently decompressible at the userspace level,
> or are there cases where a pcluster depends on the state left by a
> previous one?

Hi Deepak,

To answer your LZMA question: yes, each pcluster is independently
decompressible by design. You can verify this directly in
lib/decompress.c =E2=80=94 z_erofs_decompress_lzma() calls lzma_stream_deco=
der()
and lzma_end() within a single invocation, with no persistent lzma_stream
across calls. The same holds for ZSTD and deflate. The on-disk format
enforces this: no pcluster depends on decompressor state from a
previous one.

The parallelism boundary you identified is correct. The deeper issue
is one level up: erofs_check_inode() is called sequentially in the
dispatch loop in fsck/main.c, and each call may decompress many
pclusters per inode. Inode-level dispatch is simpler than
pcluster-level because it avoids output ordering constraints.

One thing worth thinking through before wiring erofs_workqueue into
the fsck path: the existing queue in lib/workqueue.c is an unbounded
producer queue built for mkfs compression workloads. On a 34,000+
inode image, it will accumulate all inode descriptors in memory before
workers can drain it. Backpressure =E2=80=94 either a bounded queue or a
semaphore on the existing one =E2=80=94 matters here.

Two paths in the surrounding infrastructure also need fixing before
concurrent dispatch is correct:

  - erofs_read_one_data() in lib/io.c: lseek()+read() on a shared fd
    is a TOCTOU race under concurrent calls. pread(2) fixes it cleanly.

  - erofs_iget()/erofs_iput() in lib/inode.c: ref-count mutations
    without synchronisation. Concurrent iput() can double-free.

I sent an RFC on March 22 covering this design if it is useful context:

  https://lore.kernel.org/linux-erofs/CAGSu4WNBdB30K61xoUCi3FB9QR081fNh-1ho=
X1z2TZMk0nGpHQ@mail.gmail.com/

Happy to discuss further on the list.

Regards,
Utkal Singh


On Sun, 29 Mar 2026 at 18:47, Deepak Pathik <deepakpathik2005@gmail.com> wr=
ote:
>
> Hi,
>
> I'm Deepak Pathik, a second-year B.Tech student applying for the GSoC 202=
6 project on multi-threaded decompression support in fsck.erofs.
>
> While reading through the source, I traced the decompression path in erof=
s_verify_inode_data() and noticed that z_erofs_decompress() operates on a l=
ocally scoped struct z_erofs_decompress_req with its own input and output b=
uffers =E2=80=94 no shared mutable state between calls. My plan is to wire =
the existing erofs_workqueue (already used in lib/compress.c for mkfs.erofs=
) into the fsck extraction path at the pcluster level, with pwrite() for po=
sition-based output writes to avoid ordering locks.
>
> One thing I wanted to confirm before finalizing my proposal: for LZMA-com=
pressed images, are pclusters in fsck.erofs always fixed-size and independe=
ntly decompressible at the userspace level, or are there cases where a pclu=
ster depends on the state left by a previous one? I want to make sure I'm n=
ot understating the LZMA case in my design.
>
> I've drafted a proposal and would be happy to share it for early feedback=
 if that's useful.
>
> Thanks,
> Deepak Pathik
> https://github.com/deepakpathik
> deepakpathik2005@gmail.com

