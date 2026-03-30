Return-Path: <linux-erofs+bounces-3126-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDuEOMvIymmL/wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3126-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 21:02:35 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 63356360168
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 21:02:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl0xM2FlZz2xT6;
	Tue, 31 Mar 2026 06:02:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1229" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774897351;
	cv=pass; b=aeZTzrDs3B7z1yrqXmlAH8a2o1bQtPT7aYlX2xU+i+X36wohfx+KTQfJYniAYg9t+Dp205ESngp2fCsRSOcyItXUPppUHl3Pf+TbEz1pRK9eUSVXbaE3cZE7sYd8ExI+FXaggLk2FiyY8M6lyYEcOjQ7WS5C9nqTt1OMg5fEDkumjJuXcEFisUP1dn88I3gDoShmA9KoMZQCclzLRfv02ng4EI6ldw19U/fXd42LiX1HYiFCkWZ4hGfbZ2DMVPcA9QNjOdDbmWFuTqcfmP8a+TIILGcXY7h7qDRgCNeRymFEO5/mbtUksrEz++Iq2vT/FcsocaKxLIcnGkb0IORCSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774897351; c=relaxed/relaxed;
	bh=zWtBuaGbm7IvkZv04xOo2zsbrx8BTVRPyDGG9ew1ue0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkEE1i2Wq4GNjh5RJ0k6tV8ZHYoUOTxgGpHfsTCNrCFvHHnH4ev22Dtyw3GdRlzsaYKrH8TZxLvX/I1wKlNflA2rTl4WBwzN14rqJPct31ri7o/K2sh/oRxAge9haUXOm9aPwzKQ6gEXbk1rf8GblmwNOqDTxk9MZCKLTAg0gL5irFCX8zO4G+6DAzeZgfKDIY2dhjR+frivBoi9MYoyFUmoSomIUEgHoSlsuRQ2tBTLIixhDHsaiVs+tAKRAvUR08xvB+e0l8ARKooR3A7ooEKAlU/8JpJzPuWhyAK7vdyVU45d9bvI5awBg0pm9Ajv0SqQKDbaenHO7t6iJI+4kw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y5OrpxH9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y5OrpxH9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com [IPv6:2607:f8b0:4864:20::1229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl0xK6s8pz2xSb
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 06:02:28 +1100 (AEDT)
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-127380532eeso354574c88.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 12:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774897346; cv=none;
        d=google.com; s=arc-20240605;
        b=bF4MO6ptaLm+NJmtGdAZct/W8l58SXzk0sjrlzf+iKXzzfqhbexE3uujlayys0MPyr
         mR9iya3YXS/0wgpBNT19ZL3MencKcgIi+VEDKDmH2PpMMlr0gY7JGNSs9ylo7pOn5rDb
         ohj/0iUGPgRC6pVNo9/qQDa54fmNbA0en3uyGviRsEfn4MMYhnkU5KNklqwlMzf0HRtO
         IsyXXDIRmpn8eBQ+NwVZwDZ+KIsqBbxCI65KHBJxauHA3sg/CK2OzIpxT97xc0ZghTpC
         tiMUvvxd9Tb4E7YiIFtr5otG9KtwLvP3TLUeY0wgZb4VqnEX7K31AttBYrWr26Q8rDXS
         CbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zWtBuaGbm7IvkZv04xOo2zsbrx8BTVRPyDGG9ew1ue0=;
        fh=RlfH77I8/Kt0ZrtXOcpno9ZseSB9F3859mFc0m4jdXQ=;
        b=MZwUGeaNqnYRO+lucaMHYGuR4n4V3pSWkjjJE1SmHAeSiXebr1DPAFOQj+6s0ar64N
         fwHnBnYKowEtdQwykhJiyRFel7SIKrsEkZJhAA6sm63DlAM6OL2zj4SD0I7LaF5VMhDN
         JKEXwGuSagTRLXIGNE0yir2wblxHedA0zreA9I2h+q9n4qICSs3f3w5pjoaa4fI5ntVY
         iM2J1iCkoEn7twjspSOJfgc1dW4VyGOTpukeeos+NzaoyzSuKzOC0uxtauuQy+AlPs2P
         CE5OGdg2N5n+u3DKTRT1Ih/e/pzYopMn9yhHWg5IQQSmg5mE6Ih9kZtkJwVYHTiOYPJ7
         2paQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774897346; x=1775502146; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zWtBuaGbm7IvkZv04xOo2zsbrx8BTVRPyDGG9ew1ue0=;
        b=Y5OrpxH9h0shvaqagpfd+uRmXh0Wv/xwXDjTlGx/RBIg5XndfcXv7v18eSIv6EiXv4
         0ptUdmz14bViCeXq5zHpSXBovCmFAxetejTvw3g2pbm5XDIEBIO67BZPiN1yzLu8XCui
         76iRXIL3fR5uyVm+pB6hOiDesgHlCQdbXg4pDK/GZYRB1ByxCTaV0Iopu1MnbxtFFT/m
         Xqas9w8i7Jw34BtiAuc/NkU2d9G5qoshRz2tYdb0471S1f6zIdaTZNSCLPQNyY3rwJ3z
         jf4lDpDHYrU3RUcsDPilrQYwXxJI2L+SqLbu0koN2BL5uU9Yt6n6kO9XsMvsgInauo/L
         o6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774897346; x=1775502146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWtBuaGbm7IvkZv04xOo2zsbrx8BTVRPyDGG9ew1ue0=;
        b=RJdF/9uZcoIchoGz8Oiphkj/+H+XKXrvr+ifkgierc0EDKeB+x9ySDMcuv/Zl2sE3k
         31w0JWdI6ANO3FV633aaXFkcvWS6PjpI4HcKl0qHNhXpbgTYpw8Cpjlhm3jqTsQwvPxW
         5MO2sKzKndj/HtIL+BbMN+xbs5uphbWoQlBHCc3zsmx84FqDyYCEqyEQlTBrAmHhCOW/
         3NJJCHMJ7ZNpjXo+I04Wyne3pbTLxvwmNc6gAPITdSoMcZoUw34Y2zIbGhUZhhMdLmLL
         qes7TpZBzhPyhiVFpoid0fXnsiR1NOqJlJEHyW+95BvMo1J/I81BnQPm6/egUB4VO3bw
         QeQA==
X-Gm-Message-State: AOJu0Yx1G7AD9A3KyES1k6mhNyf8jyclhRVZMvotsNPqeQQNWcGEQTZC
	V6aLhDrzKFs/sQJezmo8qyxl8R5mBdSGxLqftPs9UcFxHvHAnO4DZj4vl/Mk0CwOFZ+umiPplBT
	mMSGdeq5L9WYRyo94b702id7ql5x4equdO8WH
X-Gm-Gg: ATEYQzx03tXI6bSFY5e7xx48Bg23Hi0eQLjMwkE8J/b+2ybPCT0VDW6KoUKWf2J1C7e
	w7AHUTJv8l7rH0CmpUMhIORR31gAAhGgbiLUdG+7dQVZsbJlHEWGcfioxTxPxULGR3FMFuWIEOT
	b3VfqO/WyoDMnqQwRO7FOogfBW4M7uF0iSjTh75lFMnh18XnzivK4WHAScaBArYibsVkNlFvW90
	/8rMyjbHIB/ahlqozCOEeRgT2Ew0aE3rUQJaVTQvkS4HOl2hgw9dhxG6rTNq8JBbambSeyiLX56
	Q13h8ejOgI//bhPa2Es=
X-Received: by 2002:a05:7022:388a:b0:128:ce44:be8f with SMTP id
 a92af1059eb24-12ab2844a9amr7585346c88.2.1774897345964; Mon, 30 Mar 2026
 12:02:25 -0700 (PDT)
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
 <CAGSu4WOLGADT4Z+iEw33K1M-1F1Pgu0aHBwk_8R_2tbee6k5+w@mail.gmail.com>
 <CAHf8aCV+d0-YL8Gt_Xhw0knS7gz8FZB_RF315XOLtfOi4ec0Vg@mail.gmail.com> <CAGSu4WMJ43VwWa-_6rvxmjQHNJxOAWfMZv+0jJAy2joQ+6vzeA@mail.gmail.com>
In-Reply-To: <CAGSu4WMJ43VwWa-_6rvxmjQHNJxOAWfMZv+0jJAy2joQ+6vzeA@mail.gmail.com>
From: Deepak Pathik <deepakpathik2005@gmail.com>
Date: Tue, 31 Mar 2026 00:32:13 +0530
X-Gm-Features: AQROBzB9DBLcw2NnSZIN_4uUruY-3uUOq15xyFCChL0UMEM_AE4Jsr2397-aaHU
Message-ID: <CAHf8aCV0S61bQ3+MqVbi0+iyvZ=ysR4GcpenKp8h_AomH-Hd0A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC_2026=5D_Multi=2Dthreaded_decompression_for_fsc?=
	=?UTF-8?Q?k=2Eerofs_=E2=80=94_design_question_on_z=5Ferofs=5Fdecompress=28=29_parallel?=
	=?UTF-8?Q?ism?=
To: Utkal Singh <singhutkal015@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000d1afde064e427dee"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3126-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 63356360168
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000d1afde064e427dee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That=E2=80=99s a great point =E2=80=94 I hadn=E2=80=99t fully thought throu=
gh the error aggregation
side yet.
I=E2=80=99m leaning towards running to completion with a shared error accum=
ulator
so fsck can surface all corruption in one run, but I=E2=80=99ll think throu=
gh the
exit semantics carefully.

Thanks again for the insights, really helpful.

Regards,
Deepak Pathik

On Tue, Mar 31, 2026 at 12:05=E2=80=AFAM Utkal Singh <singhutkal015@gmail.c=
om>
wrote:

> On Mon, Mar 30, 2026 at 2:00 PM, Deepak Pathik wrote:
> > the two-phase model (serial traversal + parallel data
> > verification/extraction) makes a lot more sense now
>
> Good, that is the right framing.
>
> One more thing worth deciding early: error aggregation policy. In the
> current serial path, erofs_check_inode() returns -errno and the caller
> stops on first error. With parallel workers you need a shared error
> accumulator and a policy for whether to drain the queue on first
> error or run to completion =E2=80=94 the choice affects both exit status
> correctness and how much corruption a single run surfaces on large
> images.
>
> Good luck with the proposal.
>
> Regards,
> Utkal Singh
>
> On Mon, 30 Mar 2026 at 14:00, Deepak Pathik <deepakpathik2005@gmail.com>
> wrote:
> >
> > Hi Utkal,
> >
> > Thanks again for the detailed explanation and for pointing me to the RF=
C
> =E2=80=94 it really helped clarify the bigger picture.
> >
> > I spent some time going through the relevant parts of the code and your
> comments made a lot more sense in that context. I see now that while
> pcluster-level parallelism is valid, the main challenge is making the
> surrounding infrastructure safe before introducing concurrency.
> >
> > In particular, I hadn=E2=80=99t fully accounted for:
> >
> > the lseek() + read() pattern in erofs_read_one_data() and why switching
> to pread() is necessary for correctness,
> >
> > the lack of synchronization in erofs_iget()/erofs_iput(), which could
> lead to refcount races,
> >
> > and the implications of using an unbounded workqueue on large images.
> >
> > Your point about backpressure was especially helpful =E2=80=94 I=E2=80=
=99m now
> considering a bounded queue or a semaphore-based approach to ensure the
> producer doesn=E2=80=99t get too far ahead of the workers.
> >
> > I also revisited the design with this in mind, and the two-phase model
> (serial traversal + parallel data verification/extraction) makes a lot mo=
re
> sense now, especially for isolating shared state like fsckcfg and path
> handling.
> >
> > I=E2=80=99ll continue refining the proposal with these constraints in m=
ind and
> go deeper into io.c, inode.c, and workqueue.c to make sure the design is
> correct before thinking about actual parallel execution.
> >
> > Thanks again for taking the time to explain this =E2=80=94 it was very =
helpful.
> >
> > Regards,
> > Deepak Pathik
> >
> >
> > On Mon, Mar 30, 2026 at 1:50=E2=80=AFAM Utkal Singh <singhutkal015@gmai=
l.com>
> wrote:
> >>
> >> On Sun, Mar 29, 2026 at 6:47 PM, Deepak Pathik wrote:
> >> > for LZMA-compressed images, are pclusters in fsck.erofs always
> >> > fixed-size and independently decompressible at the userspace level,
> >> > or are there cases where a pcluster depends on the state left by a
> >> > previous one?
> >>
> >> Hi Deepak,
> >>
> >> To answer your LZMA question: yes, each pcluster is independently
> >> decompressible by design. You can verify this directly in
> >> lib/decompress.c =E2=80=94 z_erofs_decompress_lzma() calls lzma_stream=
_decoder()
> >> and lzma_end() within a single invocation, with no persistent
> lzma_stream
> >> across calls. The same holds for ZSTD and deflate. The on-disk format
> >> enforces this: no pcluster depends on decompressor state from a
> >> previous one.
> >>
> >> The parallelism boundary you identified is correct. The deeper issue
> >> is one level up: erofs_check_inode() is called sequentially in the
> >> dispatch loop in fsck/main.c, and each call may decompress many
> >> pclusters per inode. Inode-level dispatch is simpler than
> >> pcluster-level because it avoids output ordering constraints.
> >>
> >> One thing worth thinking through before wiring erofs_workqueue into
> >> the fsck path: the existing queue in lib/workqueue.c is an unbounded
> >> producer queue built for mkfs compression workloads. On a 34,000+
> >> inode image, it will accumulate all inode descriptors in memory before
> >> workers can drain it. Backpressure =E2=80=94 either a bounded queue or=
 a
> >> semaphore on the existing one =E2=80=94 matters here.
> >>
> >> Two paths in the surrounding infrastructure also need fixing before
> >> concurrent dispatch is correct:
> >>
> >>   - erofs_read_one_data() in lib/io.c: lseek()+read() on a shared fd
> >>     is a TOCTOU race under concurrent calls. pread(2) fixes it cleanly=
.
> >>
> >>   - erofs_iget()/erofs_iput() in lib/inode.c: ref-count mutations
> >>     without synchronisation. Concurrent iput() can double-free.
> >>
> >> I sent an RFC on March 22 covering this design if it is useful context=
:
> >>
> >>
> https://lore.kernel.org/linux-erofs/CAGSu4WNBdB30K61xoUCi3FB9QR081fNh-1ho=
X1z2TZMk0nGpHQ@mail.gmail.com/
> >>
> >> Happy to discuss further on the list.
> >>
> >> Regards,
> >> Utkal Singh
> >>
> >>
> >> On Sun, 29 Mar 2026 at 18:47, Deepak Pathik <deepakpathik2005@gmail.co=
m>
> wrote:
> >> >
> >> > Hi,
> >> >
> >> > I'm Deepak Pathik, a second-year B.Tech student applying for the GSo=
C
> 2026 project on multi-threaded decompression support in fsck.erofs.
> >> >
> >> > While reading through the source, I traced the decompression path in
> erofs_verify_inode_data() and noticed that z_erofs_decompress() operates =
on
> a locally scoped struct z_erofs_decompress_req with its own input and
> output buffers =E2=80=94 no shared mutable state between calls. My plan i=
s to wire
> the existing erofs_workqueue (already used in lib/compress.c for
> mkfs.erofs) into the fsck extraction path at the pcluster level, with
> pwrite() for position-based output writes to avoid ordering locks.
> >> >
> >> > One thing I wanted to confirm before finalizing my proposal: for
> LZMA-compressed images, are pclusters in fsck.erofs always fixed-size and
> independently decompressible at the userspace level, or are there cases
> where a pcluster depends on the state left by a previous one? I want to
> make sure I'm not understating the LZMA case in my design.
> >> >
> >> > I've drafted a proposal and would be happy to share it for early
> feedback if that's useful.
> >> >
> >> > Thanks,
> >> > Deepak Pathik
> >> > https://github.com/deepakpathik
> >> > deepakpathik2005@gmail.com
>

--000000000000d1afde064e427dee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That=E2=80=99s a great point =E2=80=94 I hadn=E2=80=99t fu=
lly thought through the error aggregation side yet.<br>I=E2=80=99m leaning =
towards running to completion with a shared error accumulator so fsck can s=
urface all corruption in one run, but I=E2=80=99ll think through the exit s=
emantics carefully.<br><br>Thanks again for the insights, really helpful.<b=
r><br>Regards, =C2=A0<br>Deepak Pathik</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 31,=
 2026 at 12:05=E2=80=AFAM Utkal Singh &lt;<a href=3D"mailto:singhutkal015@g=
mail.com">singhutkal015@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Mon, Mar 30, 2026 at 2:00 PM, Deepak Pa=
thik wrote:<br>
&gt; the two-phase model (serial traversal + parallel data<br>
&gt; verification/extraction) makes a lot more sense now<br>
<br>
Good, that is the right framing.<br>
<br>
One more thing worth deciding early: error aggregation policy. In the<br>
current serial path, erofs_check_inode() returns -errno and the caller<br>
stops on first error. With parallel workers you need a shared error<br>
accumulator and a policy for whether to drain the queue on first<br>
error or run to completion =E2=80=94 the choice affects both exit status<br=
>
correctness and how much corruption a single run surfaces on large<br>
images.<br>
<br>
Good luck with the proposal.<br>
<br>
Regards,<br>
Utkal Singh<br>
<br>
On Mon, 30 Mar 2026 at 14:00, Deepak Pathik &lt;<a href=3D"mailto:deepakpat=
hik2005@gmail.com" target=3D"_blank">deepakpathik2005@gmail.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; Hi Utkal,<br>
&gt;<br>
&gt; Thanks again for the detailed explanation and for pointing me to the R=
FC =E2=80=94 it really helped clarify the bigger picture.<br>
&gt;<br>
&gt; I spent some time going through the relevant parts of the code and you=
r comments made a lot more sense in that context. I see now that while pclu=
ster-level parallelism is valid, the main challenge is making the surroundi=
ng infrastructure safe before introducing concurrency.<br>
&gt;<br>
&gt; In particular, I hadn=E2=80=99t fully accounted for:<br>
&gt;<br>
&gt; the lseek() + read() pattern in erofs_read_one_data() and why switchin=
g to pread() is necessary for correctness,<br>
&gt;<br>
&gt; the lack of synchronization in erofs_iget()/erofs_iput(), which could =
lead to refcount races,<br>
&gt;<br>
&gt; and the implications of using an unbounded workqueue on large images.<=
br>
&gt;<br>
&gt; Your point about backpressure was especially helpful =E2=80=94 I=E2=80=
=99m now considering a bounded queue or a semaphore-based approach to ensur=
e the producer doesn=E2=80=99t get too far ahead of the workers.<br>
&gt;<br>
&gt; I also revisited the design with this in mind, and the two-phase model=
 (serial traversal + parallel data verification/extraction) makes a lot mor=
e sense now, especially for isolating shared state like fsckcfg and path ha=
ndling.<br>
&gt;<br>
&gt; I=E2=80=99ll continue refining the proposal with these constraints in =
mind and go deeper into io.c, inode.c, and workqueue.c to make sure the des=
ign is correct before thinking about actual parallel execution.<br>
&gt;<br>
&gt; Thanks again for taking the time to explain this =E2=80=94 it was very=
 helpful.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Deepak Pathik<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Mar 30, 2026 at 1:50=E2=80=AFAM Utkal Singh &lt;<a href=3D"mai=
lto:singhutkal015@gmail.com" target=3D"_blank">singhutkal015@gmail.com</a>&=
gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Sun, Mar 29, 2026 at 6:47 PM, Deepak Pathik wrote:<br>
&gt;&gt; &gt; for LZMA-compressed images, are pclusters in fsck.erofs alway=
s<br>
&gt;&gt; &gt; fixed-size and independently decompressible at the userspace =
level,<br>
&gt;&gt; &gt; or are there cases where a pcluster depends on the state left=
 by a<br>
&gt;&gt; &gt; previous one?<br>
&gt;&gt;<br>
&gt;&gt; Hi Deepak,<br>
&gt;&gt;<br>
&gt;&gt; To answer your LZMA question: yes, each pcluster is independently<=
br>
&gt;&gt; decompressible by design. You can verify this directly in<br>
&gt;&gt; lib/decompress.c =E2=80=94 z_erofs_decompress_lzma() calls lzma_st=
ream_decoder()<br>
&gt;&gt; and lzma_end() within a single invocation, with no persistent lzma=
_stream<br>
&gt;&gt; across calls. The same holds for ZSTD and deflate. The on-disk for=
mat<br>
&gt;&gt; enforces this: no pcluster depends on decompressor state from a<br=
>
&gt;&gt; previous one.<br>
&gt;&gt;<br>
&gt;&gt; The parallelism boundary you identified is correct. The deeper iss=
ue<br>
&gt;&gt; is one level up: erofs_check_inode() is called sequentially in the=
<br>
&gt;&gt; dispatch loop in fsck/main.c, and each call may decompress many<br=
>
&gt;&gt; pclusters per inode. Inode-level dispatch is simpler than<br>
&gt;&gt; pcluster-level because it avoids output ordering constraints.<br>
&gt;&gt;<br>
&gt;&gt; One thing worth thinking through before wiring erofs_workqueue int=
o<br>
&gt;&gt; the fsck path: the existing queue in lib/workqueue.c is an unbound=
ed<br>
&gt;&gt; producer queue built for mkfs compression workloads. On a 34,000+<=
br>
&gt;&gt; inode image, it will accumulate all inode descriptors in memory be=
fore<br>
&gt;&gt; workers can drain it. Backpressure =E2=80=94 either a bounded queu=
e or a<br>
&gt;&gt; semaphore on the existing one =E2=80=94 matters here.<br>
&gt;&gt;<br>
&gt;&gt; Two paths in the surrounding infrastructure also need fixing befor=
e<br>
&gt;&gt; concurrent dispatch is correct:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0- erofs_read_one_data() in lib/io.c: lseek()+read() on=
 a shared fd<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0is a TOCTOU race under concurrent calls. pread(=
2) fixes it cleanly.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0- erofs_iget()/erofs_iput() in lib/inode.c: ref-count =
mutations<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0without synchronisation. Concurrent iput() can =
double-free.<br>
&gt;&gt;<br>
&gt;&gt; I sent an RFC on March 22 covering this design if it is useful con=
text:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/linux-erofs/CAGSu4W=
NBdB30K61xoUCi3FB9QR081fNh-1hoX1z2TZMk0nGpHQ@mail.gmail.com/" rel=3D"norefe=
rrer" target=3D"_blank">https://lore.kernel.org/linux-erofs/CAGSu4WNBdB30K6=
1xoUCi3FB9QR081fNh-1hoX1z2TZMk0nGpHQ@mail.gmail.com/</a><br>
&gt;&gt;<br>
&gt;&gt; Happy to discuss further on the list.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Utkal Singh<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Sun, 29 Mar 2026 at 18:47, Deepak Pathik &lt;<a href=3D"mailto:=
deepakpathik2005@gmail.com" target=3D"_blank">deepakpathik2005@gmail.com</a=
>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;m Deepak Pathik, a second-year B.Tech student applying =
for the GSoC 2026 project on multi-threaded decompression support in fsck.e=
rofs.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; While reading through the source, I traced the decompression =
path in erofs_verify_inode_data() and noticed that z_erofs_decompress() ope=
rates on a locally scoped struct z_erofs_decompress_req with its own input =
and output buffers =E2=80=94 no shared mutable state between calls. My plan=
 is to wire the existing erofs_workqueue (already used in lib/compress.c fo=
r mkfs.erofs) into the fsck extraction path at the pcluster level, with pwr=
ite() for position-based output writes to avoid ordering locks.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; One thing I wanted to confirm before finalizing my proposal: =
for LZMA-compressed images, are pclusters in fsck.erofs always fixed-size a=
nd independently decompressible at the userspace level, or are there cases =
where a pcluster depends on the state left by a previous one? I want to mak=
e sure I&#39;m not understating the LZMA case in my design.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;ve drafted a proposal and would be happy to share it fo=
r early feedback if that&#39;s useful.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks,<br>
&gt;&gt; &gt; Deepak Pathik<br>
&gt;&gt; &gt; <a href=3D"https://github.com/deepakpathik" rel=3D"noreferrer=
" target=3D"_blank">https://github.com/deepakpathik</a><br>
&gt;&gt; &gt; <a href=3D"mailto:deepakpathik2005@gmail.com" target=3D"_blan=
k">deepakpathik2005@gmail.com</a><br>
</blockquote></div>

--000000000000d1afde064e427dee--

